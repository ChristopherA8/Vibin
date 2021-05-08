#import <ControlCenterUIKit/CCUIToggleModule.h>
#import <Cephei/HBPreferences.h>

HBPreferences *preferences;
BOOL enabled;
// BOOL enabledDND;
// BOOL enableHideNotifs;

@interface CCToggle : CCUIToggleModule
{
  BOOL _selected;
}

@end