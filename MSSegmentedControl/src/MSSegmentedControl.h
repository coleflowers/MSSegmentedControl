//
//  MSSegmentedControl.h
//  TabStudy
//
//  Created by leilei ma on 2021/9/14.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSSCDisplayMode) {
    MSSCDisplayModeDefault,
    MSSCDisplayModeIconAndLabel,
    MSSCDisplayModeIconOnly,
    MSSCDisplayModeLabelOnly
};

typedef NS_ENUM(NSUInteger, MSSCDisplayStyle) {
    MSSCDisplayStyleButton,
    MSSCDisplayStyleMenu
};

@class MSSegmentedControlItem;

@interface MSSegmentedControl : NSView

@property MSSCDisplayMode displayMode;

@property MSSCDisplayStyle displayStyle;

@property (nonatomic, strong) NSArray<MSSegmentedControlItem *> *items;

@end

NS_ASSUME_NONNULL_END
