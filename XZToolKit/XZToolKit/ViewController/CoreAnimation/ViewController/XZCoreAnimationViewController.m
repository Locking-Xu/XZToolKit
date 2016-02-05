//
//  XZCoreAnimationViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCoreAnimationViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"
#import "UIView+Frame.h"

@interface XZCoreAnimationViewController (){

    __weak IBOutlet UIView *_animationView;
    
}

@end

@implementation XZCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemBookmarks delegate:self action:@selector(detailBtn_Pressed)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIButton Actions
- (void)detailBtn_Pressed{

    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = self.title;
    [self.navigationController pushViewController:codeVc animated:YES];
}

- (IBAction)coreAnimationButton_Pressed:(UIButton *)sender{

    //Basic Animation(10~14)
    //KeyFrame Animation(20~23)
    //Spring Animation(30~22)
    //Group Animation(40)
    //Transitio Animation(50~61)
    
    switch (sender.tag) {
        case 10:
            //位移
            [self move];
            break;
        case 11:
            //缩放
            [self scale];
            break;
        case 12:
            //旋转
            [self rotate];
            break;
        case 13:
            //透明度
            [self alpha];
            break;
        case 14:
            //背景色
            [self backgroundColor];
            break;
        case 20:
            //关键帧
            [self keyFrame];
            break;
        case 21:
            //路径
            [self path];
            break;
        case 22:
            //抖动
            [self shake];
            break;
        case 23:
            //抛物线
            [self parabolic];
            break;
        case 30:
            //弹性位移
            [self springMove];
            break;
        case 31:
            //弹性缩放
            [self springScale];
            break;
        case 32:
            //弹性旋转
            [self springRotate];
            break;
        case 40:
            //位移+旋转
            [self groupAnimation];
            break;
        case 50:
            [self transitionAnimationWith:kCATransitionFade];
            break;
        case 51:
            [self transitionAnimationWith:kCATransitionMoveIn];
            break;
        case 52:
            [self transitionAnimationWith:kCATransitionPush];
            break;
        case 53:
            [self transitionAnimationWith:kCATransitionReveal];
            break;
        case 54:
            [self transitionAnimationWith:@"cube"];
            break;
        case 55:
            [self transitionAnimationWith:@"suckEffect"];
            break;
        case 56:
            [self transitionAnimationWith:@"oglFlip"];
            break;
        case 57:
            [self transitionAnimationWith:@"rippleEffect"];
            break;
        case 58:
            [self transitionAnimationWith:@"pageCurl"];
            break;
        case 59:
            [self transitionAnimationWith:@"pageUnCurl"];
            break;
        case 60:
            [self transitionAnimationWith:@"cameraIrisHollowOpen"];
            break;
        case 61:
            [self transitionAnimationWith:@"cameraIrisHollowClose"];
            break;
        default:
            break;
    }
}

#pragma mark Basic Animation
//位移
- (void)move{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_animationView.frame),CGRectGetMidY(_animationView.frame))];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_animationView.frame) + 100,CGRectGetMidY(_animationView.frame))];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"displacement"];
}

//缩放
- (void)scale{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSNumber numberWithInt:2];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"scale"];
}

//旋转
- (void)rotate{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"rotate"];
}

//透明
- (void)alpha{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"opacity"];
}

//背景色
- (void)backgroundColor{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (id)[UIColor greenColor].CGColor;
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"backgroundColor"];
}

#pragma mark KeyFrame Animation
//关键帧
- (void)keyFrame{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //设置关键帧的位置，必须包含起始和终止位置
    animation.values = @[
                                [NSValue valueWithCGPoint:_animationView.origin],
                                [NSValue valueWithCGPoint:CGPointMake(320-15, _animationView.y)],
                                [NSValue valueWithCGPoint:CGPointMake(320-15, _animationView.y + 100)],
                                [NSValue valueWithCGPoint:CGPointMake(15, _animationView.y + 100)],
                                [NSValue valueWithCGPoint:_animationView.origin]
                                ];
    
    //设置每个关键帧的时长，默认时长为 总duration／（value.count － 1）
    animation.keyTimes = @[
                                  [NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.6],
                                  [NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:0.9],
                                  ];
    //时间函数
    animation.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         ];
    
    animation.duration = 4.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"position"];
}

//路径
- (void)path{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 200, 100)];
    
    animation.path = path.CGPath;
    
    animation.duration = 5.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"position"];
    
}

//抖动
- (void)shake{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    animation.values = @[value1,value2,value3];
    animation.repeatCount = MAXFLOAT;
    
    [_animationView.layer addAnimation:animation forKey:@"shake"];
}

//抛物线
- (void)parabolic{
    
    CGPoint start = CGPointMake(0, 150);
    CGPoint end = CGPointMake(100, 300);
    
    //初始化抛物线
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cpx = (start.x + end.x)/2;
    CGFloat cpy = -50;
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, end.x, end.y);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.toValue = [NSNumber numberWithFloat:(CGFloat)((arc4random() % 4) + 4)/10.0];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.duration = 3.0;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[animation,scaleAnimation];
    [_animationView.layer addAnimation:groupAnimation forKey:@"position scale"];
}

#pragma mark - Spring Animation
/**
 *  弹性位移
 */
- (void)springMove{
    
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_animationView.frame),CGRectGetMidY(_animationView.frame))];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_animationView.frame) + 50,CGRectGetMidY(_animationView.frame))];
    animation.duration =2.0f;
    
    /** 质量*/
    animation.mass = 10.0f;
    /** 刚度系数*/
    animation.stiffness = 10.0f;
    /** 阻尼系数*/
    animation.damping = 10.0f;
    /** 初始速率*/
    animation.initialVelocity = 5.0f;//IOS8下出现崩溃
    
    [_animationView.layer addAnimation:animation forKey:@"displacement"];
}

/**
 *  弹性缩放
 */
- (void)springScale{
    
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSNumber numberWithInt:2];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"scale"];
}

/**
 *  弹性旋转
 */
- (void)springRotate{
    
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 2.0f;
    
    [_animationView.layer addAnimation:animation forKey:@"rotate"];
}

#pragma mark Group Animation
- (void)groupAnimation{
    
    //位移动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(50, 64)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 64)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 300)];
    animation1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:0.8f];
    animation2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:animation1,animation2,animation3, nil];
    groupAnimation.duration = 4.0f;
    
    [_animationView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

#pragma mark Transition Animation
- (void)transitionAnimationWith:(NSString *)type{
    
    _animationView.backgroundColor = [UIColor blueColor];
    
    CATransition *animation = [CATransition animation];
    animation.subtype = kCATransitionFromRight;
    animation.type = type;
    animation.duration = 1.0f;
    animation.delegate = self;
    
    [_animationView.layer addAnimation:animation forKey:@"transition"];
    
}

#pragma mark CAAnimation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {
        
        _animationView.backgroundColor = [UIColor redColor];
    }
}
@end
