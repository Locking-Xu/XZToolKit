//
//  XZStandardTabBarController.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZStandardTabBarController : UITabBarController
/** TabBar的BarItem数组*/
@property (nonatomic, strong) NSArray *items;
/** TabBar的BarItem的高亮颜色*/
@property (nonatomic, strong) UIColor *itemSelectColor;
/** TabBar的背景色*/
@property (nonatomic, strong) UIColor *tabbarBackgroundColor;

+ (instancetype)shareInstance;

/**
 *  建立TabBar
 */
- (void)setTabbar;

/**
 *  显示TabBar
 *
 *  @param animation 是否有动画
 */
- (void)showTabbarWithAnimation:(BOOL)animation;

/**
 *  隐藏TabBar
 *
 *  @param animation 是否有动画
 */
- (void)hideTabbarWithAnimation:(BOOL)animation;

@end
