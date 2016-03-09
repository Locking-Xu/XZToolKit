//
//  XZNumberButtonConfig.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XZNumberButtonConfig : NSObject
/** 下标*/
@property (nonatomic, assign) NSInteger index;
/** 边框线宽*/
@property (nonatomic, assign) CGFloat itemBorderWidth;
/** 边框颜色*/
@property (nonatomic, strong) UIColor *itemBorderColor;

@end
