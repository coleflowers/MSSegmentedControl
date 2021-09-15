//
//  MSSegmentedControlItem.h
//  TabStudy
//
//  Created by leilei ma on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSSegmentedControlItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSImage *icon;

@property (nonatomic, strong) NSColor *textColor;

@property (nonatomic, strong) NSColor *selectedTextColor;

+ (instancetype)initWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
