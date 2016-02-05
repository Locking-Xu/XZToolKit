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
#import "NSDate+String.h"
#import "NSString+Format.h"

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
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    [dateComponents setYear:self.year];
    [dateComponents setMonth:self.month + 1];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    monthCalendarVC.date = date;
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        
        [nav setBackItemTitle:[NSDate stringFromDate:date format:@"yyyy年MM月"] viewController:nav.viewControllers.lastObject];
        [nav pushViewController:monthCalendarVC animated:YES];
        

    }else{
        
        [vc.navigationController setBackItemTitle:[NSString stringFromInt:self.year] viewController:vc];
        [vc.navigationController pushViewController:monthCalendarVC animated:YES];
        
    }

}

@end
