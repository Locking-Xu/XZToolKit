//
//  XZCircle.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
//单个圆的状态
typedef NS_ENUM(NSUInteger, State){
    CircleStateNormal,//未选中状态
    CircleStateSelected,//选中状态
    CircleStateError,//错误状态
    CircleStateLastSelected,//最后一个选中状态,不显示三角箭头
    CircleStateLastError//最后一个错误状态,不显示三角箭头
};

//类别
typedef NS_ENUM(NSUInteger,Kind){
    
    CircleLockView,
    CircleInfoView
};

@interface XZCircle : UIView

@property (nonatomic, assign) State state;
@property (nonatomic, assign) Kind kind;
/** 角度*/
@property (nonatomic, assign) CGFloat angle;

@end
