//
//  XZRotateButton.m
//  OctopusNotebooks
//
//  Created by 徐章 on 15/9/26.
//  Copyright © 2015年 徐章. All rights reserved.
//

#import "XZRotateButton.h"
#import "UIView+Frame.h"

@interface XZRotateButton (){
    
    CGFloat _originWidth;
    CGFloat _originRadius;
}

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation XZRotateButton

/**
 *  开始旋转
 */
- (void)startRotating{
    
    [self setTitle:nil forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _originRadius = self.layer.cornerRadius;
        
        //圆角
        self.layer.cornerRadius = self.height/2;
        
    } completion:^(BOOL finished) {
        
        _originWidth =self.width;
        
        //bounds
        [UIView animateWithDuration:0.3 animations:^{
            
            self.layer.bounds = CGRectMake(0, 0, self.height, self.height);
            
        } completion:^(BOOL finished) {
            
            [self addProgressLayer];
            
            [self startProgressAnimation];
        }];
        
    }];
}

/**
 *  停止旋转
 */
- (void)stopRotating{
    
    [self stopProgressAnimation];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.layer.bounds = CGRectMake(0, 0, _originWidth, self.height);
         self.layer.cornerRadius = _originRadius;
        
    } completion:^(BOOL finished) {
        
        [self setTitle:@"登录" forState:UIControlStateNormal];
        
    }];
    
}

/**
 *  添加线条
 */
- (void)addProgressLayer{
    
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    
    CGFloat radius = self.height/2 - 10;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:(CGFloat)(0) endAngle:(CGFloat)(2*M_PI) clockwise:YES];
    
    self.progressLayer.path = path.CGPath;
    
    _progressLayer.strokeStart = 0.0f;
    
    _progressLayer.strokeEnd = 0.0f;
    
    [self.layer addSublayer:self.progressLayer];
    
}

- (CAShapeLayer *)progressLayer{
    
    if (!_progressLayer) {
        
        _progressLayer = [CAShapeLayer layer];
        
        _progressLayer.frame = CGRectMake(0, 0, 50, 50);
        _progressLayer.lineWidth = 5.0f;
        
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        _progressLayer.fillColor = nil;
        
        _progressLayer.lineCap = kCALineCapRound;
        
        _progressLayer.lineJoin = kCALineJoinBevel;
     
    }
    
    return _progressLayer;
}

/**
 *  添加线条动画
 */
- (void)startProgressAnimation{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 4.0f;
    animation.fromValue = @(0.0f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    [self.progressLayer addAnimation:animation forKey:@"totation"];
    
    CABasicAnimation *headAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    headAnimation.duration = 1.0f;
    headAnimation.fromValue = @(0.f);
    headAnimation.toValue = @(0.25f);
    headAnimation.repeatCount = INFINITY;
    headAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CABasicAnimation *tailAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tailAniamtion.duration = 1.0f;
    tailAniamtion.fromValue = @(0.f);
    tailAniamtion.toValue = @(1.0f);
    tailAniamtion.repeatCount = INFINITY;
    tailAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CABasicAnimation *endHeadAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    endHeadAnimation.beginTime = 1.0f;
    endHeadAnimation.duration = 0.5f;
    endHeadAnimation.fromValue = @(0.25f);
    endHeadAnimation.toValue = @(1.0f);
    endHeadAnimation.repeatCount = INFINITY;
    endHeadAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CABasicAnimation *endTailAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endTailAniamtion.beginTime = 1.0f;
    endTailAniamtion.duration = 0.5f;
    endTailAniamtion.fromValue = @(1.f);
    endTailAniamtion.toValue = @(1.0f);
    endTailAniamtion.repeatCount = INFINITY;
    endTailAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 1.5f;
    animationGroup.animations = @[headAnimation,tailAniamtion,endHeadAnimation,endTailAniamtion];
    
    animationGroup.repeatCount = INFINITY;
    
    [self.progressLayer addAnimation:animationGroup forKey:@"animationGroup"];
    
}

- (void)stopProgressAnimation{
    
    [self.progressLayer removeAllAnimations];
    [self.progressLayer removeFromSuperlayer];
}
@end
