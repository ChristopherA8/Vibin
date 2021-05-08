#import "CCToggle.h"

@implementation CCToggle

-(id)init {
    self = [super init];
    if (self) {
        _selected = enabled;
    }
    return self;
}

//Return the icon of your module here
- (UIImage *)iconGlyph
{
    _selected = enabled;
    // return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    if (@available(iOS 13, *)) {
        return [UIImage systemImageNamed:@"music.note"];
    }
    return nil;
}

//Return the color selection color of your module here
- (UIColor *)selectedColor
{
    return [UIColor colorWithRed: 0.07 green: 0.45 blue: 0.87 alpha: 1.00];
}

- (BOOL)isSelected
{
    return _selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;

    [super refreshState];

    if (_selected) {
        //Your module got selected, do something
        NSLog(@"Module selected");
        [preferences setBool:YES forKey:@"enabled"];
    } else {
        //Your module got unselected, do something
        NSLog(@"Module unselected");
        [preferences setBool:NO forKey:@"enabled"];
    }

    // [[NSNotificationCenter defaultCenter] postNotificationName:@"com.chr1s.vibinprefs/ReloadPrefs" object:self];

}

@end

static __attribute__((constructor)) void ctorWithoutCtorLol() {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.chr1s.vibinprefs"];
	[preferences registerBool:&enabled default:YES forKey:@"enabled"];
	// [preferences registerBool:&enableDND default:YES forKey:@"enableDND"];
	// [preferences registerBool:&enableHideNotifs default:YES forKey:@"enableHideNotifs"];
}