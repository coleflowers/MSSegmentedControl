//
//  MSSegmentedControl.m
//  TabStudy
//
//  Created by leilei ma on 2021/9/14.
//

#import "MSSegmentedControl.h"
#import "MSSegmentedControlItem.h"

@interface MSSegmentedControl()

@property (nonatomic, strong) NSMutableArray<NSBezierPath *> *paths;

/*!
 * 选中索引
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/*!
 * 边宽
 */
@property (nonatomic, assign) CGFloat borderWidth;

/*!
 * 选中颜色【展示模式为按钮的时候有效】
 */
@property (nonatomic, strong) NSColor *selectedColor;

/*!
 * 未选中部分颜色【展示模式为按钮时有效】
 */
@property (nonatomic, strong) NSColor *unselectedColor;

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
    self.displayMode = MSSCDisplayModeIconOnly;
    self.displayStyle = MSSCDisplayStyleMenu;
    self.paths = @[].mutableCopy;
    self.selectedIndex = 0;
    self.borderWidth = 0.f;
    self.selectedColor = [NSColor selectedContentBackgroundColor];
    self.unselectedColor = [NSColor clearColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect]; 
    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:self.unselectedColor.CGColor];
    
    CGFloat radius = [self bounds].size.height / 5.f;
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.selectedColor.CGColor];
        
    [self drawContent];
}

- (CGSize)heightForString:(NSString *)text font:(NSFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        // no text means no height
        return CGSizeZero;
    }
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{
        NSFontAttributeName : font
    };
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height) + 1; // add 1 point as padding
    size.height = height;
    return size;
}

- (void)drawContent
{
    [self.paths removeAllObjects];
    
    CGFloat lineWidth = self.borderWidth;
    CGFloat maginLeftOne = 0;
    CGFloat maginLeftTwo = 0;
    
    CGFloat widthFirst = [self bounds].size.width / [self.items count];
    
    float point1_x = maginLeftOne;
    float point1_y = 0;
    __block CGPoint point1 = CGPointMake(point1_x, point1_y);
    
    float point2_x = maginLeftOne;
    __block float point2_y = self.frame.size.height + lineWidth / 2.0 ;
    __block CGPoint point2 = CGPointMake(point2_x, point2_y);
    
    __block float point3_x = point2_x + widthFirst + maginLeftTwo * 2;
    __block float point3_y = point2_y;
    __block CGPoint point3 = CGPointMake(point3_x, point3_y);
    
    __block  float point4_x = point3_x ;
    __block float point4_y = point1_y;
    __block CGPoint point4 = CGPointMake(point4_x, point4_y);
    
    __block NSColor *textColor = [NSColor whiteColor];
    [self.items enumerateObjectsUsingBlock:^(MSSegmentedControlItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSSize size = NSMakeSize(widthFirst, self.bounds.size.height);// [self getTitleSize:title];
        NSBezierPath *path = [NSBezierPath bezierPath];
        path.lineWidth = lineWidth;
        
        if (idx != 0) {
            point1 = point4;
            point2 = CGPointMake(point3.x, point3.y - lineWidth / 2.0);
            
            if (self.selectedIndex != 0 && idx == self.selectedIndex) {
                point2_y = point2.y + lineWidth ;
                point2 = CGPointMake(point2.x, point2_y);
            }
            
            point3_x = point3_x + size.width  + maginLeftTwo * 2;
            point3_y = point3_y ;
            point3 = CGPointMake(point3_x, point3_y);
            
            point4_x = point4_x + size.width + maginLeftTwo * 2;
            if (self.items.count == 2) {
                point3_x = point3_x + 1;
                point3 = CGPointMake(point3_x, point3_y);
                point4_x = point4_x + 1;
            }
            point4_y = point4_y;
            point4 = CGPointMake(point4_x, point4_y);
        }
        
        [path moveToPoint:point1];
        [path lineToPoint:point2];
        [path lineToPoint:point3];
        [path lineToPoint:point4];
        [path lineToPoint:point1];
        // unemphasizedSelectedContentBackgroundColor
        // selectedContentBackgroundColor
        [[NSColor whiteColor] set];
        path.lineCapStyle = NSLineCapStyleRound;
        path.lineJoinStyle = NSLineJoinStyleRound;
        
        if (self.selectedIndex != idx) {
            if (self.displayStyle == MSSCDisplayStyleButton) {
                [path fill];
            }
            textColor = obj.textColor;
            
            textColor = self.displayStyle == MSSCDisplayStyleButton ? self.selectedColor : textColor;
        } else {
            if (self.borderWidth > 0 && self.displayStyle == MSSCDisplayStyleButton) {
                [path stroke];
            }
            textColor = obj.selectedTextColor;// [NSColor whiteColor];// self.selectedColor;
        }
    
        if (
            self.displayMode == MSSCDisplayModeIconAndLabel
            || self.displayMode == MSSCDisplayModeLabelOnly
            ) {
            NSDictionary *dicAtt = @{NSFontAttributeName:[NSFont systemFontOfSize:[NSFont systemFontSize]],NSForegroundColorAttributeName:textColor};
            [obj.title drawAtPoint:NSMakePoint(point2.x + maginLeftTwo , (self.frame.size.height - size.height) / 2.0) withAttributes:dicAtt];
        }
        
        if (
            self.displayMode == MSSCDisplayModeIconAndLabel
            || self.displayMode == MSSCDisplayModeIconOnly
            ) {
            [self.selectedColor set];
            CGFloat areaMax = MIN([self bounds].size.height, [self bounds].size.width);
            CGFloat iconWidth = areaMax * (4/7.f);
            iconWidth = iconWidth == 0 ? 18 : iconWidth;
            CGFloat iconLeft = (widthFirst - iconWidth) / 2 + idx * widthFirst;
            CGFloat iconTop = ([self bounds].size.height - iconWidth) / 2;
            //NSLog(@"w:%f --- %@", iconWidth, NSStringFromRect(self.bounds));
            CGRect iconRect = CGRectMake(iconLeft, iconTop, iconWidth, iconWidth);
          
            NSImage *newImg = [obj.icon copy];
            [newImg lockFocus];
            
            if (self.displayStyle == MSSCDisplayStyleButton) {
                [textColor set];
            } else {
                if (self.selectedIndex == idx) {
                    [obj.selectedTextColor set];
                } else {
                    [obj.textColor set];
                }
            }
            NSRect imageRect = {NSZeroPoint, iconRect.size};
            NSRectFillUsingOperation(imageRect, NSCompositingOperationSourceIn);
            [newImg unlockFocus];
            
            [newImg drawInRect:iconRect];
        }
    
        [self.paths addObject:path];
        
    }];
}

- (void)mouseDown:(NSEvent *)event
{
    CGPoint eventLocation = [event locationInWindow];
    NSPoint point = [self convertPoint:eventLocation fromView:nil];
    [self.paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSBezierPath *path = obj;
        if ([path containsPoint:point]) {
            // NSLog(@"mouseDown  %ld",idx);
            if (self.selectedIndex != idx) {
                self.selectedIndex = idx;
                [self setNeedsDisplay:YES];
                /*
                if ([self.delegate respondsToSelector:@selector(selectTitleIndex:)]) {
                    [self.delegate selectTitleIndex:self.index];
                }*/
            }
        }
    }];
}

@end
