//
//  XZMatrixTransformView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/7.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMatrixTransformView.h"

@implementation XZMatrixTransformView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 0, 0, 0.3);
    CGContextTranslateCTM(context, 160, 5);
    for (int i = 0; i<24; i++) {
        
        CGContextTranslateCTM(context, 50, 30);
        CGContextScaleCTM(context, 0.9, 0.9);
        CGAffineTransform transform = CGAffineTransformMake(1, 0, -tanf(M_PI/10), 1, 0, 0);
        CGContextConcatCTM(context, transform);
        CGContextFillRect(context, CGRectMake(0, 0, 120, 60));
    }
}


@end
