#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SBMediaController.h"
#include "/Users/christopher/theos/vendor/lib/Cephei.framework/Headers/HBPreferences.h"
#import <objc/runtime.h>

HBPreferences *preferences;
BOOL enabled;
BOOL enableDND;
BOOL enableHideNotifs;

@interface SBUIController
@end

// Axon support
@interface AXNView : UIView
@end

@interface NCNotificationListView : UIScrollView
@end

@interface NCNotificationStructuredListViewController : UIViewController
@property(nonatomic, retain) NCNotificationListView *masterListView;
// %new
- (void)hideNotifs;
- (void)showNotifs;
@end

// Do Not Disturb
@class DNDModeAssertionLifetime;

@interface DNDModeAssertionDetails : NSObject
+ (id)userRequestedAssertionDetailsWithIdentifier:(NSString *)identifier
                                   modeIdentifier:(NSString *)modeIdentifier
                                         lifetime:(DNDModeAssertionLifetime *)
                                                      lifetime;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails
                             error:(NSError **)error;
@end

@interface DNDModeAssertionService : NSObject
+ (id)serviceForClientIdentifier:(NSString *)clientIdentifier;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails
                             error:(NSError **)error;
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