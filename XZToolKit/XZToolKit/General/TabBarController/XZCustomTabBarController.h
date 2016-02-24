//
//  XZCustomTabBarController.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTabBar.h"

static NSString * const XZTabBarItemTitle = @"tabbarItemTitle";
static NSString * const XZTabBarItemImage = @"tabBarItemImage";
static NSString * const XZTabBarItemSelectImage = @"tabBarItemSelectImage";

@interface XZCustomTabBarController : UITabBarController

@property (nonatomic, strong) NSArray *itemsAttributes;
@property (nonatomic, strong) XZTabBar *customTabbar;

+ (instancetype)shareInstance;
@end
