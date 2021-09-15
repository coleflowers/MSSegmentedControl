//
//  MSSegmentedControlItem.m
//  MSSegmentedControl
//
//  Created by 爱写代码的小马 on 2021/9/15.
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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textColor = [NSColor textColor];
        self.selectedTextColor = [NSColor linkColor];
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
    return item;
}

+ (instancetype)initWithTitle:(NSString *)title {
    MSSegmentedControlItem *item = [[MSSegmentedControlItem alloc] init];
    item.title = title;
    return item;
}

+ (instancetype)initWith:(NSString *)title imageName:(NSString *)imageName {
    MSSegmentedControlItem *item = [self initWithTitle:title];
    item.icon = [NSImage imageNamed:imageName];
    return item;
}

@end
