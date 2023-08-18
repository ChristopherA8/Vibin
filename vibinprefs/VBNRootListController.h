#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBRootListController.h>
#import <Cephei/HBRespringController.h>
// #import <CepheiPrefs/HBAppearanceSettings.h>
#import <CepheiPrefs/HBLinkTableCell.h>
#import <CepheiPrefs/HBTwitterCell.h>
#import <Cephei/HBPreferences.h>

@interface VBNRootListController : PSListController
@property (nonatomic, retain) UIBarButtonItem *respringButton;
@property (nonatomic, retain) UILabel *titleLabel;
-(void)discord;
-(void)paypal;
-(void)sourceCode;
@end
