//
//  XZLabelFlowThreeConfig.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LineType){
    SingleLine,
    MultipleLine
};
@interface XZLabelFlowThreeConfig : NSObject
/** 单行、多行*/
@property (nonatomic, assign) LineType lineType;
/** 内容数组*/
@property (nonatomic, strong) NSArray *titleArray;
/** content edgs*/
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
/** 标签之间的间距*/
@property (nonatomic, assign) CGFloat itemSpace;
/** 标签内容与两边的距离*/
@property (nonatomic, assign) CGFloat itemTextSpace;
/** 标签高度*/
@property (nonatomic, assign) CGFloat itemHeigth;
/** 标签字体大小*/
@property (nonatomic, assign) CGFloat itemTextFont;
/** 标签字体的颜色*/
@property (nonatomic, strong) UIColor *itemTextColor;
/** 标签的圆角半径*/
@property (nonatomic, assign) CGFloat itemRadius;
/** 标签的边框宽度*/
@property (nonatomic, assign) CGFloat itemBorderWidth;
/** 标签边框的颜色*/
@property (nonatomic, strong) UIColor *itemBorderColor;
/** 标签的背景色*/
@property (nonatomic, strong) UIColor *itemBackgroundColor;
/** 行间距*/
@property (nonatomic, assign) CGFloat lineSpace;

@end
