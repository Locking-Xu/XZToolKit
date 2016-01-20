//
//  UIButton+FillColor.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FillColor)

/**
 * 设置Button在不同状态下的背景色
 *
 *  @param backgroundColor 背景色
 *  @param state           状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
