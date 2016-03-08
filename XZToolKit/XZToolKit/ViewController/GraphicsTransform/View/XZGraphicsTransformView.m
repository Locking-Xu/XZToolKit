//
//  XZGraphicsTransformView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/6.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGraphicsTransformView.h"

@implementation XZGraphicsTransformView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
    CGContextTranslateCTM(context, -40, 200);
    for (NSInteger i = 0; i<50; i++) {
        
        CGContextTranslateCTM(context, 50, 50);
        CGContextScaleCTM(context, 0.93, 0.93);
        CGContextRotateCTM(context, -M_PI/10);
        
        CGContextFillRect(context, CGRectMake(0, 0, 150, 75));
    }
}


@end
