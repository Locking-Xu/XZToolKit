//
//  XZDayCalendarCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZDayCalendarCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *gregorianLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarLabel;

- (void)setUpCellWithDate:(NSDate *)date month:(NSInteger)month day:(NSInteger)day;

@end
