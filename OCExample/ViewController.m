//
//  ViewController.m
//  OCExample
//
//  Created by 爱写代码的小马 on 2021/9/15.
//

#import "ViewController.h"
#import <MSSegmentedControl/MSSegmentedControl.h>

@interface ViewController()<MSSegmentedControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tab control
    NSArray *tabItems = @[
        [MSSegmentedControlItem initWithTitle:@"Menu Style"],
        [MSSegmentedControlItem initWithTitle:@"Button Style"],
    ];
    [self.tabCtl setIdentifier:@"menu"];
    [self.tabCtl setDisplayStyle:MSSCDisplayStyleMenu];
    [self.tabCtl setItems:tabItems];
    [self.tabCtl setDelegate:self];
    [self.tabCtl setTarget:self];
    [self.tabCtl setAction:@selector(ctlSelected:)];
    
    [self.contentTab selectTabViewItemAtIndex:self.tabCtl.selectedIndex];
    
    NSArray *bitItems = @[
        [MSSegmentedControlItem initWithTitle:@"测试1"],
        [MSSegmentedControlItem initWithTitle:@"测试2"],
    ];
    [self.bigMenu setDisplayStyle:MSSCDisplayStyleMenu];
    [self.bigMenu setItems:bitItems];
    
    // menu style show
    NSArray *items = @[
        [MSSegmentedControlItem initWithImageName:NSImageNameTouchBarGetInfoTemplate],
        [MSSegmentedControlItem initWithImageName:NSImageNameHomeTemplate],
        [MSSegmentedControlItem initWithImageName:NSImageNameActionTemplate],
    ];
    [self.menuCtl setItems:items];
    
    // menu style with title show
    NSArray *menuItems = @[
        [MSSegmentedControlItem initWith:@"Home" imageName:NSImageNameHomeTemplate],
        [MSSegmentedControlItem initWith:@"Setting" imageName:@"gearshape"],
        [MSSegmentedControlItem initWith:@"Help" imageName:@"questionmark.circle"]
    ];
    [self.menuWithTitle setItems:menuItems];
    
    // button style show
    [self.btnCtl setItems:items];
    [self.btnCtl setDisplayStyle:MSSCDisplayStyleButton];
    
    // button style with title show
    [self.btnWithTitle setItems:menuItems]; 
    [self.btnWithTitle setDisplayStyle:MSSCDisplayStyleButton];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - MSSegmentedControl action
- (void)ctlSelected:(MSSegmentedControl *)ctl {
    if ([ctl.identifier isEqualToString:@"menu"]) {
        [self.contentTab selectTabViewItemAtIndex:ctl.selectedIndex];
    }
    NSLog(@"[%@]selected : %ld", ctl.identifier, ctl.selectedIndex);
}

#pragma mark - MSSegmentedControl delegate
- (void)selected:(MSSegmentedControl *)ctl index:(NSInteger)index {
    NSLog(@"[%@]selected : %ld", ctl.identifier, ctl.selectedIndex);
}

@end
