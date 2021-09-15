//
//  MSSegmentedControl.h
//  MSSegmentedControl
//
//  Created by 爱写代码的小马 on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import <MSSegmentedControl/MSSegmentedControlItem.h>

//! Project version number for MSSegmentedControl.
FOUNDATION_EXPORT double MSSegmentedControlVersionNumber;

//! Project version string for MSSegmentedControl.
FOUNDATION_EXPORT const unsigned char MSSegmentedControlVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MSSegmentedControl/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSSCDisplayStyle) {
    MSSCDisplayStyleButton,
    MSSCDisplayStyleMenu
};

@class MSSegmentedControlItem;
@class MSSegmentedControl;

@protocol MSSegmentedControlDelegate <NSObject>

@optional
- (void)selected:(MSSegmentedControl *)ctl index:(NSInteger)index;

@end

@interface MSSegmentedControl : NSView

@property MSSCDisplayStyle displayStyle;

@property (nullable) SEL action;

@property (nullable, weak, nonatomic) id target;

@property (strong, nonatomic) IBOutlet id<MSSegmentedControlDelegate> delegate;

/*!
 * 选中索引
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/*!
 * 数据源
 */
@property (nonatomic, strong) NSArray<MSSegmentedControlItem *> *items;

/*!
 * 边框颜色
 */
@property (nonatomic, strong) NSColor *borderColor;

/*!
 * 边宽
 */
@property (nonatomic, assign) CGFloat borderWidth;

/*!
 * 背景色
 */
@property (nonatomic, strong) NSColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END

