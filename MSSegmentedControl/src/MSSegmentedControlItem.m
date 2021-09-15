//
//  MSSegmentedControlItem.m
//  TabStudy
//
//  Created by leilei ma on 2021/9/15.
//

#import "MSSegmentedControlItem.h"

@implementation MSSegmentedControlItem

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.icon = [coder decodeObjectForKey:@"icon"];
        self.textColor = [coder decodeObjectForKey:@"textColor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.icon forKey:@"icon"];
    [coder encodeObject:self.textColor forKey:@"textColor"];
}

+ (instancetype)initWithImageName:(NSString *)imageName {
    MSSegmentedControlItem *item = [[MSSegmentedControlItem alloc] init];
    item.icon = [NSImage imageNamed:imageName];
    item.title = @"测试"; //TODO 删除
    item.textColor = [NSColor textColor];
    item.selectedTextColor = [NSColor linkColor];
    return item;
}

@end
