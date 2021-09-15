//
//  ViewController.h
//  OCExample
//
//  Created by 爱写代码的小马 on 2021/9/15.
//

#import <Cocoa/Cocoa.h>

@class MSSegmentedControl;

@interface ViewController : NSViewController

@property (nonatomic, strong) IBOutlet NSTabView *contentTab;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *tabCtl;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *menuCtl;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *menuWithTitle;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *bigMenu;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *btnCtl;

@property (nonatomic, strong) IBOutlet MSSegmentedControl *btnWithTitle;

@end

