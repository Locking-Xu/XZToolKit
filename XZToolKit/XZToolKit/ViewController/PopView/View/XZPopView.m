//
//  XZPopView.m
//  XZPopView
//
//  Created by 徐章 on 15/11/9.
//  Copyright © 2015年 xuzhang. All rights reserved.
//

#import "XZPopView.h"


/** 箭头底边宽度*/
#define Arrow_Width 5.0f
/** 箭头高度*/
#define Arrow_Height   Arrow_Width*(sqrtf(3)/2)
/** 拐角半径*/
#define Corner_Radius 5.0f

@implementation XZPopView

- (id)initWithRelyView:(id)relyView height:(CGFloat)height leftWidth:(CGFloat)leftWidth rightWidth:(CGFloat)rightWidth direction:(Direction)direction superView:(UIView *)superView{
    
    self = [super init];
    if (self) {
        
        _relyView = (UIView *)relyView;
        _leftWidth = leftWidth;
        _rightWidth = rightWidth;
        _height = height;
        _direction = direction;
        _superView = superView;
        
        _contentViewColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.masksToBounds = YES;
        
        [self createVerticalPopView];
        
    }
    
    return self;
    
}

//创建ContentView
- (void)initContentView{
    
    if (_direction == Top) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), _height)];
        
    }else if(_direction == Bottom){
    
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Arrow_Height, CGRectGetWidth(self.frame), _height)];
        
    }else if (_direction == Left){
    
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _height, CGRectGetHeight(self.frame))];
        
    }else if (_direction == Right){
    
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(Arrow_Height, 0, _height, CGRectGetHeight(self.frame))];
    }
    self.contentView.layer.cornerRadius = Corner_Radius;
    self.contentView.layer.masksToBounds = YES;
    
    [self addSubview:self.contentView];
    

    
}

- (void)setDelegate:(id<XZPopViewDelegate>)delegate{
    
    _delegate = delegate;
    
    if (_delegate && [_delegate respondsToSelector:@selector(xzPopViewContentView)]) {
        
        [self.contentView addSubview:[_delegate xzPopViewContentView]];
        
    }
}

//创建popView
- (void)createVerticalPopView{

    /** RelyView相对于SuperView的frame*/
    CGRect relyRect = [_relyView.superview convertRect:_relyView.frame toView:_superView];
    
    /** self的frame*/
    CGRect rect;
    
    //popView在相关联RelyView的上边
    if (_direction == Top)
    {
        /**popView的宽度 左边宽度＋右边宽度＋箭头宽度 */
        CGFloat popView_Width = _leftWidth + _rightWidth +Arrow_Width;
        /**popView的高度 内容高度＋箭头高度 */
        CGFloat popView_Heigth = _height + Arrow_Height;
        /**popView的X坐标 = RelyView的中心点x坐标*/
        CGFloat popView_X = relyRect.origin.x + relyRect.size.width/2 - Arrow_Width/2 - _leftWidth;
        /**popView的Y坐标 = RelyView的y坐标 - 高度 - 交投高度*/
        CGFloat popView_Y = relyRect.origin.y - _height - Arrow_Height;
        
        rect = CGRectMake(popView_X, popView_Y, popView_Width, popView_Heigth);
        
    }
    //popView在相关联RelyView的下边
    else if (_direction == Bottom)
    {
        /**popView的宽度 左边宽度＋右边宽度＋箭头宽度 */
        CGFloat popView_Width = _leftWidth + _rightWidth +Arrow_Width;
        /**popView的高度 内容高度＋箭头高度 */
        CGFloat popView_Heigth = _height + Arrow_Height;
        /**popView的X坐标 = RelyView的中心点x坐标 - 箭头宽度/2 - 左边宽度*/
        CGFloat popView_X = relyRect.origin.x + relyRect.size.width/2 - Arrow_Width/2 - _leftWidth;
        /**popView的Y坐标 = RelyView的y坐标 + RelyView的高度*/
        CGFloat popView_Y = relyRect.origin.y + relyRect.size.height;
        
        rect = CGRectMake(popView_X, popView_Y, popView_Width, popView_Heigth);
    }
    //popView在相关联RelyView的左边
    else if (_direction == Left)
    {
        /**popView的宽度 高度＋箭头高度 */
        CGFloat popView_Width = _height + Arrow_Height;
        /**popView的高度 左边宽度＋右边宽度＋箭头宽度 */
        CGFloat popView_Heigth = _leftWidth + _rightWidth + Arrow_Width;
        /**popView的X坐标 = RelyView的x坐标 - 箭头高度 - 高度*/
        CGFloat popView_X = relyRect.origin.x - Arrow_Height - _height;
        /**popView的Y坐标 = RelyView的中心点y坐标 - 箭头宽度/2 -右边宽度*/
        CGFloat popView_Y = relyRect.origin.y + relyRect.size.width/2 - Arrow_Width/2 - _rightWidth;
        
        rect = CGRectMake(popView_X, popView_Y, popView_Width, popView_Heigth);
    }
    //popView在相关联RelyView的右边
    else if (_direction == Right)
    {
        /**popView的宽度 高度＋箭头高度 */
        CGFloat popView_Width = _height + Arrow_Height;
        /**popView的高度 左边宽度＋右边宽度＋箭头宽度 */
        CGFloat popView_Heigth = _leftWidth + _rightWidth + Arrow_Width;
        /**popView的X坐标 = RelyView的x坐标 + RelyView的宽度*/
        CGFloat popView_X = relyRect.origin.x + relyRect.size.width;
        /**popView的Y坐标 = RelyView的中心点y坐标 - 箭头宽度/2 -右边宽度*/
        CGFloat popView_Y = relyRect.origin.y + relyRect.size.width/2 - Arrow_Width/2 - _rightWidth;
        
        rect = CGRectMake(popView_X, popView_Y, popView_Width, popView_Heigth);
    }
    
    self.frame = rect;

    _originalBounds = self.bounds;
    
    [self initContentView];
    
}

- (void)drawRect:(CGRect)rect{
    
    [self drawBorder];
    
}

//绘制边框
- (void)drawBorder{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [_contentViewColor setFill];
    
    
    if (_direction == Top) {
        
        /** 箭头坐标*/
        CGPoint arrowPoint = CGPointMake(_leftWidth + Arrow_Width/2, CGRectGetHeight(self.frame));
        
        [path moveToPoint:arrowPoint];
        
        [self drawTopBorder:path];
        
    }else if(_direction == Bottom){
        
        /** 箭头坐标*/
        CGPoint arrowPoint = CGPointMake(_leftWidth + Arrow_Width/2, 0);
        
        [path moveToPoint:arrowPoint];
        
        [self drawBottomBorder:path];
    
    }else if (_direction == Left){
    
        /** 箭头坐标*/
        CGPoint arrowPoint = CGPointMake(CGRectGetWidth(self.frame), _rightWidth + Arrow_Width/2);
        
        [path moveToPoint:arrowPoint];
        
        [self drawLeftBorder:path];

        
    }else if (_direction == Right){
    
        /** 箭头坐标*/
        CGPoint arrowPoint = CGPointMake(0, _rightWidth + Arrow_Width/2);
        
        [path moveToPoint:arrowPoint];
        
        [self drawRightBorder:path];
    }
    
    [path closePath];

    [path fill];
    
}

//popView在下方边框
- (void)drawBottomBorder:(UIBezierPath *)path{
    
    [path addLineToPoint:CGPointMake(_leftWidth, Arrow_Height)];
    [path addLineToPoint:CGPointMake(Corner_Radius, Arrow_Height)];
    [path addQuadCurveToPoint:CGPointMake(0, Arrow_Width + Corner_Radius) controlPoint:CGPointMake(0, Arrow_Width)];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(Corner_Radius, CGRectGetHeight(self.frame)) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - Corner_Radius, CGRectGetHeight(self.frame))];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-Corner_Radius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), Arrow_Height+ Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) - Corner_Radius, Arrow_Height) controlPoint:CGPointMake(CGRectGetWidth(self.frame), Arrow_Height)];
    [path addLineToPoint:CGPointMake(_leftWidth + Arrow_Width, Arrow_Height)];
}

//popView在上方边框
- (void)drawTopBorder:(UIBezierPath *)path{

    [path addLineToPoint:CGPointMake(_leftWidth, CGRectGetHeight(self.frame) - Arrow_Height)];
    [path addLineToPoint:CGPointMake(Corner_Radius, CGRectGetHeight(self.frame) - Arrow_Height)];
    [path addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-Arrow_Height - Corner_Radius) controlPoint:CGPointMake(0, CGRectGetHeight(self.frame)-Corner_Radius)];
    [path addLineToPoint:CGPointMake(0, Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(Corner_Radius, 0) controlPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - Corner_Radius, 0)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame), Corner_Radius) controlPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-Arrow_Height -Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) - Corner_Radius, CGRectGetHeight(self.frame)-Arrow_Height) controlPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - Arrow_Height)];
    [path addLineToPoint:CGPointMake(_leftWidth + Arrow_Width, CGRectGetHeight(self.frame)-Arrow_Height)];
    
    
}

/**
 *  popView在左侧边框
 */
- (void)drawLeftBorder:(UIBezierPath *)path{
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    [path addLineToPoint:CGPointMake(selfWidth - Arrow_Height, _rightWidth + Arrow_Width)];
    [path addLineToPoint:CGPointMake(selfWidth - Arrow_Height, _rightWidth + Arrow_Width + _leftWidth - Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(selfWidth - Corner_Radius - Arrow_Height, selfHeight) controlPoint:CGPointMake(selfWidth - Arrow_Height, selfHeight)];
    [path addLineToPoint:CGPointMake(Corner_Radius, selfHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, selfHeight - Corner_Radius) controlPoint:CGPointMake(0, selfHeight)];
    [path addLineToPoint:CGPointMake(0, Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(Corner_Radius, 0) controlPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(selfWidth - Corner_Radius - Arrow_Height, 0)];
    [path addQuadCurveToPoint:CGPointMake(selfWidth - Arrow_Height, Corner_Radius) controlPoint:CGPointMake(selfWidth - Arrow_Height, 0)];
    [path addLineToPoint:CGPointMake(selfWidth - Arrow_Height, _rightWidth)];

}

/**
 *  popView在右侧边框
 */
- (void)drawRightBorder:(UIBezierPath *)path{
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    [path addLineToPoint:CGPointMake(Arrow_Height, _rightWidth)];
    [path addLineToPoint:CGPointMake(Arrow_Height, Corner_Radius)];
    [path addQuadCurveToPoint:CGPointMake(Corner_Radius + Arrow_Height, 0) controlPoint:CGPointMake(Arrow_Height, 0)];
    [path addLineToPoint:CGPointMake(selfWidth - Corner_Radius, 0)];
    
    [path addQuadCurveToPoint:CGPointMake(selfWidth, Corner_Radius) controlPoint:CGPointMake(selfWidth, 0)];
    
    [path addLineToPoint:CGPointMake(selfWidth, selfHeight - Corner_Radius)];
    
    [path addQuadCurveToPoint:CGPointMake(selfWidth - Corner_Radius, selfHeight) controlPoint:CGPointMake(selfWidth, selfHeight)];
    [path addLineToPoint:CGPointMake(Corner_Radius + Arrow_Height, selfHeight)];
    [path addQuadCurveToPoint:CGPointMake(Arrow_Height,selfHeight - Corner_Radius) controlPoint:CGPointMake(Arrow_Height, selfHeight)];
    [path addLineToPoint:CGPointMake(Arrow_Height, _rightWidth + Arrow_Width)];
}


//设置背景色
- (void)setContentViewColor:(UIColor *)contentViewColor{
    
    _contentViewColor = contentViewColor;
}

/**
 *  显示
 */
- (void)show{
    
    [_superView addSubview:self];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25;
    animation.values = @[[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1.2],[NSNumber numberWithFloat:1.0]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animation forKey:@"showScale"];
}

/**
 *  隐藏
 */
- (void)hide{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25;
    animation.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:0.0]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"hideScale"];
}

#pragma mark - UIAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if ([anim isEqual:[self.layer animationForKey:@"hideScale"]]) {
        
        [self removeFromSuperview];
    }
}
@end
