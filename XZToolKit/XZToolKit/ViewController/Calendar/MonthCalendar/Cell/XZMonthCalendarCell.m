//
//  XZMonthCalendarCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMonthCalendarCell.h"
#import "UIView+Frame.h"
#import "XZDayView.h"
#import "XZImageHelper.h"
#import "NSDate+String.h"

@implementation XZMonthCalendarCell{

    CGFloat _dayViewWidth;
    NSMutableArray *_dayViewArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _dayViewWidth = UISCREEN_WIDTH/7;
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
     
        [self addTitleLabel];
        [self addDayView];
    }
    
    return self;
}

- (void)addTitleLabel{
    
    self.titleLab = ({
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:20.0f];
        label.textColor = [UIColor redColor];
        [self addSubview:label];
        
        label;
    });
    
}

- (void)addDayView{
    
    _dayViewArray = [NSMutableArray arrayWithCapacity:42];
    
    for (int i=0; i<42; i++) {
        
        XZDayView *view = [[XZDayView alloc] init];
        
        view.tag = i;
        
        [self addSubview:view];
        
        [_dayViewArray addObject:view];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    for (XZDayView *view in _dayViewArray) {
        
        NSInteger i = [_dayViewArray indexOfObject:view];
    
        view.frame = CGRectMake(_dayViewWidth*(i%7), _dayViewWidth*(i/7+1), _dayViewWidth, _dayViewWidth);
    }
    
}

/**
 *  设置cell具体的内容
 *
 *  @param date 内容相对应的时间
 */
- (void)setUpCellWithDate:(NSDate *)date{

    [self clear];
    
    NSInteger numberOfDays = [date numberOfDayInCurrentMonth];
    NSInteger weekday = [date weekDay];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    
    self.titleLab.frame = CGRectMake(_dayViewWidth*(weekday-1), 0, UISCREEN_WIDTH, _dayViewWidth);
    
    for (NSInteger i = weekday-1;i< numberOfDays + weekday-1; i++) {
    
        XZDayView *view = _dayViewArray[i];
  
        [components setDay:(i - (weekday -1) + 1)];
        
        NSDate *tmpDate = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        view.date = tmpDate;
        
        view.imageView.image = [[XZImageHelper shareInstance] getDayImageWithDate:tmpDate size:CGSizeMake(_dayViewWidth, _dayViewWidth)];
    }
    
}

- (void)clear{
    
    for (XZDayView *view in _dayViewArray) {
        
        view.imageView.image = nil;
    }
}

/**
 *  获得cell的高度
 *
 *  @return CGFloat
 */
+ (CGFloat)heightOfCell{

    return UISCREEN_WIDTH;
}
@end
