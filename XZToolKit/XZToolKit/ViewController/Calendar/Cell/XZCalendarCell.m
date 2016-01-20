//
//  XZCalendarCell.m
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZCalendarCell.h"
#import "XZMonthView.h"
#import "UIView+Frame.h"
#import "NSDate+String.h"


static CGFloat const defaultMargin = 5.0f;
static CGFloat const yearTitleHeight = 30.0f;
static NSInteger const monthNumberOfYear = 12;

@implementation XZCalendarCell{
    
    NSMutableArray *_monthViewArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _yearLabel = [UILabel new];
        [self.contentView addSubview:_yearLabel];
        
        _monthViewArray = [NSMutableArray arrayWithCapacity:12];
        
        for (int i = 0; i<monthNumberOfYear; i++) {
            
            XZMonthView *monthView = [[XZMonthView alloc] init];
            
            [self.contentView addSubview:monthView];
            
            [_monthViewArray addObject:monthView];
            
            
        }
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _yearLabel.frame = CGRectMake(defaultMargin, 0, self.width - 2*defaultMargin, yearTitleHeight);
    
    CGFloat monthViewWidth = (UISCREEN_WIDTH - 4*defaultMargin)/3;
    
    for (XZMonthView *monthView in _monthViewArray) {
        
        NSInteger index = [_monthViewArray indexOfObject:monthView];

        monthView.frame = CGRectMake(monthViewWidth * (index%3) + defaultMargin * (index%3+1),
                                     (monthViewWidth + defaultMargin) * (index/3) +yearTitleHeight,
                                     monthViewWidth,
                                     monthViewWidth);
    }
}

/**
 *  根据屏幕计算cell的高度
 *
 *  @return cell的高度
 */
+ (CGFloat)heightOfCell{

    CGFloat monthViewWidth = (UISCREEN_WIDTH - 4*defaultMargin)/3;

    return (yearTitleHeight + 4*monthViewWidth + 3*defaultMargin);
}

- (void)setUpCellWithDate:(NSDate *)date{
    
    date = [date getValueForUnit:NSCalendarUnitYear];
    CGFloat monthViewWidth = (UISCREEN_WIDTH - 4*defaultMargin)/3;
    CGSize size = CGSizeMake(monthViewWidth, monthViewWidth);
    
    [_monthViewArray enumerateObjectsUsingBlock:^(XZMonthView *monthView, NSUInteger idx, BOOL * _Nonnull stop) {
  
        [monthView setMonthImageWithDate:[date dateByAddingValue:idx forKey:@"month"] size:size];
        
    }];
}

@end
