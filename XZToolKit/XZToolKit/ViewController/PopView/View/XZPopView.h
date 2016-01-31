//
//  XZPopView.h
//  XZPopView
//
//  Created by 徐章 on 15/11/9.
//  Copyright © 2015年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZPopViewDelegate <NSObject>

- (UIView *)xzPopViewContentView;

@end

typedef NS_ENUM(NSInteger, Direction){
    
    Top,
    Bottom,
    Left,
    Right
    
};

@interface XZPopView : UIView{
    
    UIView *_relyView;
    CGFloat _leftWidth;
    CGFloat _rightWidth;
    CGFloat _height;
    Direction _direction;
    
    UIView *_superView;
    
    CGRect _originalBounds;
    
}

/** 内容试图背景色*/
@property (nonatomic, strong) UIColor *contentViewColor;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) id <XZPopViewDelegate> delegate;

/*
    当popView是在竖直方向上的时候
 
                 /\
     ___________/  \____________
    | leftWidth      rightWidth |
    |                           |
    |                           |height
    |                           |
    |                           |
    |___________________________|
 
 
 
 当popView是在水平方向上的时候
                
                   height
             ___________________
             |                 |
             |                 |
             | rightWidth      |
             |                 |
             |                 |
           <                   |
             |                 |
             |                 |
             |leftWidth        |
             |                 |
             |_________________|
 
 
    中间箭头的宽高都适用默认值
    relyView:相关联的View
    leftWidth:箭头左边(下边)的宽度（不包括箭头的底边宽度）
    rightWidth:箭头右边(上边)的宽度（不包括箭头的底边宽度）
    height:内容区域的高度(宽度)（不包括箭头的高度）
    superView:父视图
 */
- (id)initWithRelyView:(id)relyView
                height:(CGFloat)height
                leftWidth:(CGFloat)leftWidth
                rightWidth:(CGFloat)rightWidth
                direction:(Direction)direction
                superView:(UIView *)superView;

- (void)show;

- (void)hide;
@end
