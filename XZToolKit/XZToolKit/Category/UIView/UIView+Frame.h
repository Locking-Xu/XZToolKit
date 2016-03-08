//
//  UIView+Frame.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/** 原点*/
@property (nonatomic, assign) CGPoint origin;
/** 大小*/
@property (nonatomic, assign) CGSize size;

/** 原点－X*/
@property (nonatomic, assign) CGFloat x;
/** 原点－Y*/
@property (nonatomic, assign) CGFloat y;

/** 大小－宽度*/
@property (nonatomic, assign) CGFloat width;
/** 大小－高度*/
@property (nonatomic, assign) CGFloat height;

/** 最小－X*/
@property (nonatomic, assign) CGFloat minX;
/** 最小－Y*/
@property (nonatomic, assign) CGFloat minY;

/** 中间－X*/
@property (nonatomic, assign) CGFloat midX;
/** 中间－Y*/
@property (nonatomic, assign) CGFloat midY;

/** 最大－X*/
@property (nonatomic, assign) CGFloat maxX;
/** 最大－Y*/
@property (nonatomic, assign) CGFloat maxY;
@end
