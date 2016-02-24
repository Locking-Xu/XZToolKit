//
//  XZCustomTabBarController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCustomTabBarController.h"
#import "XZTabBar.h"

@interface XZCustomTabBarController ()

@end

@implementation XZCustomTabBarController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.customTabbar = [[XZTabBar alloc] init];
    
    [self setValue:self.customTabbar forKey:@"tabBar"];
}

+ (instancetype)shareInstance{
    
    static XZCustomTabBarController *tabbarVc = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        tabbarVc = [[XZCustomTabBarController alloc] init];
        
    });
    
    return tabbarVc;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    
    if (viewControllers.count == 0 || viewControllers.count != self.itemsAttributes.count) {
        NSLog(@"数量有问题");
        return;
    }
    
    for (NSInteger i = 0 ;i<viewControllers.count;i++) {
        
        UIViewController *vc = viewControllers[i];
        NSDictionary *dic = self.itemsAttributes[i];
        
        vc.tabBarItem.image = [UIImage imageNamed:dic[XZTabBarItemImage]];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:dic[XZTabBarItemSelectImage]];
        
        //tabBarItem字体的设置
        //正常状态
        NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
        normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
        [vc.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
        
        //选中状态
        NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
        selectedText[NSForegroundColorAttributeName] = [UIColor orangeColor];
        [vc.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
        
        vc.tabBarItem.title = dic[XZTabBarItemTitle];
        
        [self addChildViewController:vc];
        
    }
}
@end
