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
#import "XZImageTest.h"

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
        
        label.backgroundColor = [UIColor yellowColor];
        [self addSubview:label];
        
        label;
    });
    
}

- (void)addDayView{
    
    _dayViewArray = [NSMutableArray arrayWithCapacity:42];
    
    for (int i=0; i<42; i++) {
        
        XZDayView *view = [[XZDayView alloc] init];
        
        [self addSubview:view];
        
        [_dayViewArray addObject:view];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(0, 0, UISCREEN_WIDTH, _dayViewWidth);
    
    for (XZDayView *view in _dayViewArray) {
        
        NSInteger i = [_dayViewArray indexOfObject:view];
        
        view.frame = CGRectMake(_dayViewWidth*(i%7), _dayViewWidth*(i/7+1), _dayViewWidth, _dayViewWidth);
        
        view.imageView.image = [[XZImageTest shareInstance] getMonthImageWithDate:nil size:view.size];
        
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
