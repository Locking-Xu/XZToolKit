//
//  XZDayView.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZDayView.h"
#import "XZDayCalendarViewController.h"
#import <Foundation/Foundation.h>
#import "XZUtils.h"
#import "UINavigationController+Common.h"

@implementation XZDayView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture_Pressed)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)tapGesture_Pressed{
    
    XZDayCalendarViewController *dayCalendarVc = [[XZDayCalendarViewController alloc] initWithNibName:@"XZDayCalendarViewController" bundle:[NSBundle mainBundle]];
    
    dayCalendarVc.date = self.date;
    
    UIViewController *vc = [XZUtils getCurrentViewController];
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        
        [nav setBackItemTitle:@"" viewController:nav.viewControllers.lastObject];
        [nav pushViewController:dayCalendarVc animated:YES];
        
        
    }else{
        
        [vc.navigationController setBackItemTitle:@"" viewController:vc];
        [vc.navigationController pushViewController:dayCalendarVc animated:YES];
        
    }

}
@end
