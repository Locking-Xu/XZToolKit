//
//  XZCircleInfoView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCircleInfoView.h"
#import "XZCircle.h"
#import "XZGesturesPasswordConfig.h"

@implementation XZCircleInfoView

- (id)init{
    
    self = [super init];
    if (self) {
        
        [self addCircle];
    }
    return self;
}

/**
 *  添加9个小圆环
 */
- (void)addCircle{

    for (NSInteger i = 0; i<9; i++) {
        
        XZCircle *circle = [[XZCircle alloc] init];
        circle.kind = CircleInfoView;
        [self addSubview:circle];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat width = CircleInfoRadius * 2;
    CGFloat margin = (self.frame.size.width - width *3)/2.0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSUInteger row = idx / 3;//行
        NSUInteger column = idx % 3;//列
        
        CGFloat x = (width + margin) * column;
        CGFloat y = (width + margin) * row;
        
        obj.frame = CGRectMake(x, y, width, width);
        obj.tag = idx + 1;
    }];
}

- (void)setFillWithPassword:(NSString *)password{
    
    for (NSInteger i = 0; i<password.length; i++) {
        
        NSString *index = [password substringWithRange:NSMakeRange(i, 1)];
        XZCircle *circle = [self viewWithTag:index.integerValue+1];
        circle.state = CircleStateLastSelected;
    }
}
@end
