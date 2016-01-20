//
//  XZMonthView.m
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZMonthView.h"
#import "XZImageHelper.h"

@implementation XZMonthView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
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
@end
