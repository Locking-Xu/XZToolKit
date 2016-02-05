//
//  XZCAShapeLayerViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCAShapeLayerViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"

@interface XZCAShapeLayerViewController ()

@end

@implementation XZCAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemBookmarks delegate:self action:@selector(detailBtn_Pressed)];
    
    [self linePerson];
    [self round];
    [self dashLine];
    [self arc];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//线条小人
- (void)linePerson{

    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.lineWidth = 5;
    
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}

//圆
- (void)round{

    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(200, 350)];
    [path addArcWithCenter:CGPointMake(150, 350) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(250, 350)];
    [path addArcWithCenter:CGPointMake(150, 350) radius:100 startAngle:0 endAngle:-2*M_PI clockwise:NO];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}

//虚线
- (void)dashLine{
    
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(300, 100)];

    [path addLineToPoint:CGPointMake(300, 200)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.lineWidth = 5;
    
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:2],nil,nil];
    
    shapeLayer.lineDashPhase = 15;
    
    shapeLayer.lineJoin = kCALineJoinBevel;
    
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];

}

//弧线
- (void)arc{

    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];

    [path addArcWithCenter:CGPointMake(300, 300) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES];

    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 5;
    
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    shapeLayer.strokeStart = 0.1;
    shapeLayer.strokeEnd = 0.6;
    
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}
#pragma mark UIButton Actions
- (void)detailBtn_Pressed{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = self.title;
    [self.navigationController pushViewController:codeVc animated:YES];
}

@end
