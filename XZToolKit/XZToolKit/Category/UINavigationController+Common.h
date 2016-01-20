//
//  UINavigationController+Common.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Common)

/** NavigtionBar的背景颜色*/
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor;
/** 返回键以及返回标题颜色*/
- (void)setBackColor:(UIColor *)backColor;

/** NavigationBar是否半透明显示，会对整体是否下移64有影响*/
- (void)setIsTranslucent:(BOOL)isTranslucent;

/**
 *  PS:如果同时设置标题字体大小和颜色的话，的先设置大小再设置颜色
 */
/** 标题字体颜色*/
- (void)setTitleColor:(UIColor *)titleColor;
/** 标题字体大小*/
- (void)setTitleFont:(UIFont *)titleFont;


/**
 *  设置返回键标题
 *
 *  @param title          标题
 *  @param viewController 显示的ViewController
 */
- (void)setBackItemTitle:(NSString *)title viewController:(UIViewController *)viewController;

/**
 *   添加系统样式的BarButton
 *
 *  @param systemType     按钮的类型
 *  @param viewController 显示的ViewController
 *  @param method         关联的SEL
 */
- (void)addSystemRightButton:(UIBarButtonSystemItem)systemType delegate:(UIViewController *)viewController action:(SEL)method;

@end
