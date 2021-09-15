//
//  MSSegmentedControl.m
//  MSSegmentedControl
//
//  Created by 爱写代码的小马 on 2021/9/14.
//

#import "MSSegmentedControl.h"
#import "MSSegmentedControlItem.h"

@interface MSSegmentedControl()

@property (nonatomic, strong) NSMutableArray<NSBezierPath *> *paths;

@end

@implementation MSSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    self.displayStyle = MSSCDisplayStyleMenu;
    self.paths = @[].mutableCopy;
    self.selectedIndex = 0;
    self.borderWidth = 0.f;
    self.borderColor = [NSColor selectedContentBackgroundColor];
    self.backgroundColor = [NSColor clearColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect]; 
    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:self.backgroundColor.CGColor];
    
    CGFloat radius = [self bounds].size.height / 5.f;
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.borderColor.CGColor];
        
    [self drawContent];
}

- (CGSize)sizeForString:(NSString *)text font:(NSFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        return CGSizeZero;
    }
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{
        NSFontAttributeName : font
    };
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height) + 1;
    size.height = height;
    return size;
}

- (void)drawContent {
    [self.paths removeAllObjects];
    NSFont *fnt = [NSFont systemFontOfSize:[NSFont systemFontSize]];
    
    CGFloat h = [self bounds].size.height;
    
    CGFloat itemWidth = [self bounds].size.width / [self.items count];
    
    float point1X = 0;
    float point1Y = 0;
    CGPoint point1 = CGPointMake(point1X, point1Y);
    
    float point2X = 0;
    float point2Y = self.frame.size.height + self.borderWidth / 2.0 ;
    CGPoint point2 = CGPointMake(point2X, point2Y);
    
    float point3X = point2X + itemWidth;
    float point3Y = point2Y;
    CGPoint point3 = CGPointMake(point3X, point3Y);
    
    float point4X = point3X;
    float point4Y = point1Y;
    CGPoint point4 = CGPointMake(point4X, point4Y);
    
    NSColor *textColor = [NSColor whiteColor];
    CGFloat areaMax = MIN(h, [self bounds].size.width);
    for (int idx = 0; idx < [self.items count]; idx++) {
        MSSegmentedControlItem *obj = [self.items objectAtIndex:idx];
        
        NSBezierPath *path = [NSBezierPath bezierPath];
        path.lineWidth = self.borderWidth;
        
        if (idx != 0) {
            point1 = point4;
            point2 = CGPointMake(point3.x, point3.y - self.borderWidth / 2.0);
            
            if (self.selectedIndex != 0 && idx == self.selectedIndex) {
                point2Y = point2.y + self.borderWidth;
                point2 = CGPointMake(point2.x, point2Y);
            }
            
            point3X = point3X + itemWidth;
            point3Y = point3Y ;
            point3 = CGPointMake(point3X, point3Y);
            
            point4X = point4X + itemWidth;
            if (self.items.count == 2) {
                point3X = point3X + 1;
                point3 = CGPointMake(point3X, point3Y);
                point4X = point4X + 1;
            } 
            point4 = CGPointMake(point4X, point4Y);
        }
        
        [path moveToPoint:point1];
        [path lineToPoint:point2];
        [path lineToPoint:point3];
        [path lineToPoint:point4];
        [path lineToPoint:point1];

        [self.backgroundColor set];
        path.lineCapStyle = NSLineCapStyleRound;
        path.lineJoinStyle = NSLineJoinStyleRound;
        
        if (self.selectedIndex != idx) {
            if (self.displayStyle == MSSCDisplayStyleButton) {
                [path fill];
            }
            textColor = obj.textColor;
        } else {
            if (self.borderWidth > 0 && self.displayStyle == MSSCDisplayStyleButton) {
                [path stroke];
            }
            textColor = obj.selectedTextColor;
        }
        
        CGFloat titleHeight = 0;
        CGFloat iconWidth = 0;
        CGSize titleSize = CGSizeZero;
        
        if (obj.title && [obj.title length] > 0) {
            titleSize = [self sizeForString:obj.title font:fnt maxWidth:itemWidth];
            titleHeight = titleSize.height;
        }
        
        if (obj.icon) {
            iconWidth = titleHeight > 0 ? (areaMax - titleHeight) * (3.6/7.f) :  areaMax * (4/7.f);
            iconWidth = iconWidth == 0 ? 18 : iconWidth;
        }
        
        if (obj.title && [obj.title length] > 0) {
            NSDictionary *dicAtt = @{
                NSFontAttributeName:fnt,
                NSForegroundColorAttributeName:textColor
            };
            CGFloat m = (itemWidth - titleSize.width) > 0 ? (itemWidth - titleSize.width)/2 : 0;
            CGFloat titleTop = (h - titleSize.height - iconWidth) / 2;
            [obj.title drawAtPoint:NSMakePoint(point2.x + m , titleTop) withAttributes:dicAtt];
        }
        
        if (obj.icon) {
            CGFloat iconLeft = (itemWidth - iconWidth) / 2 + idx * itemWidth;
            CGFloat iconTop = titleHeight > 0 ? (h - iconWidth - titleHeight) / 2 + titleHeight : (h - iconWidth) / 2;
            CGRect iconRect = CGRectMake(iconLeft, iconTop, iconWidth, iconWidth);
            
            // TODO 图片缩放
            NSImage *newImg = [obj.icon copy];
            [newImg lockFocus];
           
            [textColor set];
            
            NSRect imageRect = {NSZeroPoint, newImg.size};
            NSRectFillUsingOperation(imageRect, NSCompositingOperationSourceIn);
            [newImg unlockFocus];
            
            [newImg drawInRect:iconRect];
            // [newImg drawInRect:iconRect fromRect:NSZeroRect operation:NSCompositingOperationCopy fraction:1.0];
        }
    
        [self.paths addObject:path];
        
    }
}

- (void)mouseDown:(NSEvent *)event {
    CGPoint eventLocation = [event locationInWindow];
    NSPoint point = [self convertPoint:eventLocation fromView:nil];
    [self.paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSBezierPath *path = obj;
        if ([path containsPoint:point]) {
            if (self.selectedIndex != idx) {
                self.selectedIndex = idx;
                [self setNeedsDisplay:YES];
                
                if (self.action && self.target) {
                    [self.target performSelector:self.action
                                    withObject:self
                                    afterDelay:0.0];
                }
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(selected:index:)]) {
                    [self.delegate selected:self index:self.selectedIndex];
                }
            }
        }
    }];
}

#pragma mark setter
- (void)setItems:(NSArray<MSSegmentedControlItem *> *)items {
    _items = items;
}

@end
