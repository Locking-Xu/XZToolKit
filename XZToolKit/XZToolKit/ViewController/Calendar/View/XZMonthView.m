//
//  XZMonthView.m
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZMonthView.h"
#import "XZImageHelper.h"
#import "XZUtils.h"
#import "XZMonthCalendarViewController.h"
#import "UINavigationController+Common.h"

@implementation XZMonthView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture_Pressed)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.imageView.frame = self.bounds;
}

- (void)setMonthImageWithDate:(NSDate *)date size:(CGSize)size{
    
    UIImage *image = [[XZImageHelper shareInstance] getMonthImageWithDate:date size:size];
    self.imageView.image = image;
}

#pragma mark UIGestureRecoginzer
- (void)tapGesture_Pressed{

    UIViewController *vc = [XZUtils getCurrentViewController];
    
    XZMonthCalendarViewController *monthCalendarVC = [[XZMonthCalendarViewController alloc] init];
    
    monthCalendarVC.year = XZIntToString(self.year);
    monthCalendarVC.month = XZIntToString(self.month);
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        
        [nav setBackItemTitle:XZIntToString(self.year) viewController:nav.viewControllers.lastObject];
        [nav pushViewController:monthCalendarVC animated:YES];

    }else{
        
        [vc.navigationController setBackItemTitle:XZIntToString(self.year) viewController:vc];
        [vc.navigationController pushViewController:monthCalendarVC animated:YES];
        
    }

}

@end
