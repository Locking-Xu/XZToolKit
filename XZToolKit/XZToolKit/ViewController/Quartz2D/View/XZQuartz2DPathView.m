//
//  XZQuartz2DPathView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DPathView.h"

@implementation XZQuartz2DPathView


- (void)drawRect:(CGRect)rect {
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.type) {
        case ARC:
        {
            for (NSInteger i = 0; i<10; i++) {
                
                CGContextBeginPath(context);
                //添加一段圆弧，最后一个参数代表顺逆时针
                CGContextAddArc(context, i*25, i*25, (i+1)*8, M_PI*1.5, M_PI, 0);
                CGContextClosePath(context);
                CGContextSetRGBFillColor(context, 1, 0, 1, (10-i)*0.1);
                CGContextFillPath(context);
            }
            
        }
            break;
            
        default:
            break;
    }
}


@end
