//
//  XZTipView.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTipView.h"
#import "UIView+Frame.h"

@implementation XZTipView
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        self.label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.label];
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGradient:context];
}

#pragma mark 线性渐变
-(void)drawGradient:(CGContextRef)context
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.8};
    CGFloat locations[2] = {0.0,1.0,};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //绘制渐变
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(0, self.frame.size.height), 0);
    
    //释放对象
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)hideWithTime:(CGFloat)time{

    [UIView animateWithDuration:time animations:^{
       
        self.alpha = 0.0f;
    }];
}

- (void)showWithTime:(CGFloat)time{

    [UIView animateWithDuration:time animations:^{
        
        self.alpha = 1.0f;
    }];
}
@end
