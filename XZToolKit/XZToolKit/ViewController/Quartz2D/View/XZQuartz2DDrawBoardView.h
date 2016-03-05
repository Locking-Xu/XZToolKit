//
//  XZQuartz2DDrawBoardView.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Kind){

    kLine,/** 直线*/
    kRect,/** 矩形*/
    kEllipse,/** 椭圆*/
    kRoundRect,/** 圆角矩形*/
    kPen/** 铅笔*/
};

@interface XZQuartz2DDrawBoardView : UIView

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) Kind kind;
@end
