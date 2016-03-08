//
//  XZGesturesPasswordConfig.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#ifndef XZGesturesPasswordConfig_h
#define XZGesturesPasswordConfig_h

#pragma mark - ============= XZCircleInfoView =============
/** InfoView上圆环的半径*/
#define CircleInfoRadius    6.0f


#pragma mark - ============= XZCircleLockView =============
/** LockView圆环距离左右的间距*/
#define CircleLockMargin    30.0f
/** LockView的连线的宽度*/
#define CircleLockConnectLineWidth  2.0f


#pragma mark - =============== XZLockLabel ===============
/** 普通状态下字体颜色*/
#define TextColorNotmalColor    RGBA(241,241,241,1)
/** 普通状态下字体颜色*/
#define TextColorWarningColor    RGBA(254,82,92,1)

/** 准备绘制手势密码*/
#define TextPrepareToSet @"绘制解锁图案"
/** 最少连接4个点*/
#define TextLeastConnect @"最少连接4个点"
/** 设置成功*/
#define TextSetSuccess @"设置成功"

#pragma mark - ================= XZCircle =================
/** 空心圆圆环的宽度*/
#define CircleLineWidth     1.0f
/** 内环实心圆的占比*/
#define CircleProportation  0.4f
/** 连线的宽度*/
#define CircleLineWidth     1.0f
/** 三角形箭头的边长*/
#define CircleArrowLength   10.0f


/** 普通状态下外环的颜色*/
#define CircleStateNormalOutSideColor   RGBA(241,241,241,1)
/** 选中状态下外环的颜色*/
#define CircleStateSelectedOutSideColor RGBA(34,178,246,1)
/** 错误状态下外环的颜色*/
#define CircleStateErrorOutSideColor    RGBA(254,82,92,1)

/** 普通状态下内环实心圆的颜色*/
#define CircleStateNormalInSideColor    [UIColor clearColor]
/** 选中状态下内环实心圆的颜色*/
#define CircleStateSelectedInSideColor  RGBA(34,178,246,1)
/** 错误状态下内环实心圆的颜色*/
#define CircleStateErrorInSideColor     RGBA(254,82,92,1)

/** 普通状态下连线的颜色*/
#define CircleStateNormalLineColor      RGBA(34,178,246,1)
/** 错误状态下连线的颜色*/
#define CircleStateErrorLineColor       RGBA(254,82,92,1)


#endif /* XZGesturesPasswordConfig_h */
