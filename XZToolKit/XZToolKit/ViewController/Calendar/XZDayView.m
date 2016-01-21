//
//  XZDayView.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZDayView.h"
#import <Foundation/Foundation.h>

@implementation XZDayView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.backgroundColor = RandomColor;
        [self addSubview:self.imageView];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}
@end
