//
//  XZTabBarController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTabBarController.h"

@interface XZTabBarController ()

@end

@implementation XZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)shareInstance{
    
    static XZTabBarController *tabbarVc = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        tabbarVc = [[XZTabBarController alloc] init];
        
    });
    
    return tabbarVc;
}

/**
 *  建立TabBar
 */
- (void)setTabbar{
    
    for (int i=0 ;i <self.items.count ; i++) {
        
        NSDictionary *dic = self.items[i];
        UIViewController *vc = self.viewControllers[i];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:dic[@"title"] image:[UIImage imageNamed:dic[@"image"]] tag:i];
        vc.tabBarItem = item;
    }
}

/**
 *  隐藏TabBar
 *
 *  @param animation 是否有动画
 */
- (void)hideTabbarWithAnimation:(BOOL)animation{
    
    __block CGRect rect = self.tabBar.frame;
    
    if (rect.origin.y < [UIScreen mainScreen].bounds.size.height) {
        
        CGFloat duration = animation ? 0.0f :0.5f;
        
        [UIView animateWithDuration:duration animations:^{
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            
            self.tabBar.frame = rect;
        }];
    }
    
}

/**
 *  显示TabBar
 *
 *  @param animation 是否有动画
 */
- (void)showTabbarWithAnimation:(BOOL)animation{
    
    __block CGRect rect = self.tabBar.frame;
    
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        
        CGFloat duration = animation ? 0.0f :0.5f;
        
        [UIView animateWithDuration:duration animations:^{
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 49;
            
            self.tabBar.frame = rect;
        }];
    }
    
}
#pragma mark - Setter_Methods

- (void)setItems:(NSArray *)items{
    
    _items = items;
}

- (void)setItemSelectColor:(UIColor *)itemSelectColor{
    
    self.tabBar.tintColor = itemSelectColor;
}

- (void)setTabbarBackgroundColor:(UIColor *)tabbarBackgroundColor{
    
    self.tabBar.barTintColor = tabbarBackgroundColor;
    self.tabBar.translucent = NO;
}


@end
