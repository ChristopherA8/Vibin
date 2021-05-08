#import "MediaRemote.h"
#import "SBMediaController.h"
#import <objc/runtime.h>

@interface NCNotificationListView : UIScrollView
@end

@interface NCNotificationStructuredListViewController : UIViewController
@property (nonatomic, retain) NCNotificationListView *masterListView;
// %new
-(void)hideNotifs;
-(void)showNotifs;
@end

%hook NCNotificationStructuredListViewController
-(void)viewDidAppear:(BOOL)animated {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNotifs) name:@"hideNotificationsOnCS" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotifs) name:@"showNotificationsOnCS" object:nil];
    });
	%orig;
}
%new
-(void)hideNotifs {
	for (UIView *view in self.masterListView.subviews) {
		if ([view isKindOfClass:%c(NCNotificationListView)]) {
			[UIView animateWithDuration:0.8 animations:^{
				view.alpha = 0;
			}];
			dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.8);
			dispatch_after(delay, dispatch_get_main_queue(), ^(void){
				view.hidden = YES;
			});
		}
	}
}
%new
-(void)showNotifs {
	for (UIView *view in self.masterListView.subviews) {
		if ([view isKindOfClass:%c(NCNotificationListView)]) {
			view.hidden = NO; // Reenables notifs
			view.alpha = 0; // Keeps them hidden
			[UIView animateWithDuration:0.8 animations:^{				
				view.alpha = 1; // Slowly fades them in
			}];
		}
	}
}
-(void)dealloc {
	%orig;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
%end

//Do Not Disturb
@class DNDModeAssertionLifetime;

@interface DNDModeAssertionDetails : NSObject
+ (id)userRequestedAssertionDetailsWithIdentifier:(NSString *)identifier modeIdentifier:(NSString *)modeIdentifier lifetime:(DNDModeAssertionLifetime *)lifetime;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails error:(NSError **)error;
@end

@interface DNDModeAssertionService : NSObject
+ (id)serviceForClientIdentifier:(NSString *)clientIdentifier;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails error:(NSError **)error;
@end

static BOOL DNDEnabled;
static DNDModeAssertionService *assertionService;

typedef struct {
	BOOL active;
	BOOL enabled;
	BOOL sunSchedulePermitted;
	int mode;
	unsigned long long disableFlags;
	BOOL available;
} Status;


void enableDND() {
	if (!assertionService) {
		assertionService = (DNDModeAssertionService *)[objc_getClass("DNDModeAssertionService") serviceForClientIdentifier:@"com.apple.donotdisturb.control-center.module"];
	}
	DNDModeAssertionDetails *newAssertion = [objc_getClass("DNDModeAssertionDetails") userRequestedAssertionDetailsWithIdentifier:@"com.apple.control-center.manual-toggle" modeIdentifier:@"com.apple.donotdisturb.mode.default" lifetime:nil];
	[assertionService takeModeAssertionWithDetails:newAssertion error:NULL];
}

void disableDND() {
	if (!assertionService) {
    	assertionService = (DNDModeAssertionService *)[objc_getClass("DNDModeAssertionService") serviceForClientIdentifier:@"com.apple.donotdisturb.control-center.module"];
    }
    [assertionService invalidateAllActiveModeAssertionsWithError:NULL];
}

%hook DNDState
-(BOOL)isActive {
	// Fetch current dnd state
	DNDEnabled = %orig;
	return DNDEnabled;
}
%end

SBMediaController *mediaController;

%hook SBUIController
-(id)init {
	[[NSNotificationCenter defaultCenter] addObserver:self
	selector:@selector(currentSongChanged:)
	name:@"SBMediaNowPlayingChangedNotification"
	object:nil];

	mediaController = [%c(SBMediaController) sharedInstance];

	return %orig;
}
%new
- (void)currentSongChanged:(NSNotification *)notification {
    if (mediaController.isPlaying) {
		enableDND();
		[[NSNotificationCenter defaultCenter] postNotificationName:@"hideNotificationsOnCS" object:self];
    } else {
		disableDND();
		[[NSNotificationCenter defaultCenter] postNotificationName:@"showNotificationsOnCS" object:self];
	}
}
%end