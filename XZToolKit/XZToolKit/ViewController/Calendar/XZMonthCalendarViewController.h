//
//  XZMonthCalendarViewController.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMonthCalendarViewController : UIViewController

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

@property (nonatomic, strong) NSDate *date;
@end
