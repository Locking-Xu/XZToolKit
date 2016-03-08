//
//  UINavigationController+Common.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UINavigationController+Common.h"

@implementation UINavigationController (Common)

/**
 *  设置NavigationBar背景颜色
 *
 *  @param barBackgroundColor 背景色
 */
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor{
    
    [self.navigationBar setBarTintColor:barBackgroundColor];
    
}


/**
 *  设置返回键以及返回标题颜色
 *
 *  @param backAndTitleColor 颜色
 */
- (void)setBackColor:(UIColor *)backColor{
    
    [self.navigationBar setTintColor:backColor];
}

/**
 *  NavigationBar是否半透明显示
 *
 *  @param isTranslucent BOOL
 */
- (void)setIsTranslucent:(BOOL)isTranslucent{
    
    [self.navigationBar setTranslucent:isTranslucent];
}

/**
 *   设置标题字体颜色和字体大小
 *
 *  @param titleColor 字体颜色
 *  @param titleFont  字体大小
 */
- (void)setTitleColor:(UIColor *)titleColor font:(UIFont *)titleFont{
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,titleFont,NSFontAttributeName, nil];
    
    [self.navigationBar setTitleTextAttributes:attributes];
}

/**
 *  设置返回键标题
 *
 *  @param title          标题
 *  @param viewController 显示的ViewController
 */
- (void)setBackItemTitle:(NSString *)title viewController:(UIViewController *)viewController{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = title;
    
    viewController.navigationItem.backBarButtonItem = backItem;
}

/**
 *   添加系统样式的BarButton
 *
 *  @param systemType     按钮的类型
 *  @param viewController 显示的ViewController
 *  @param method         关联的SEL
 */
- (void)addSystemRightButton:(UIBarButtonSystemItem)systemType delegate:(UIViewController *)viewController action:(SEL)method{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemType target:viewController action:method];
    
    viewController.navigationItem.rightBarButtonItem = rightItem;
}


@end
