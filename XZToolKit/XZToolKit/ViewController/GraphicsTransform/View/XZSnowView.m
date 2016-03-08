//
//  XZSnowView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/6.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZSnowView.h"
static CGPoint snowpos[] = {

    {20,4},
    {50,4},
    {80,4},
    {110,4},
    {140,4},
    {170,4},
    {200,4},
    {230,4},
    {290,4},
};

static NSInteger snowCount = sizeof(snowpos)/sizeof(snowpos[0]);
@interface XZSnowView()
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation XZSnowView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30.0f)];
        [button setBackgroundColor:[UIColor blueColor]];
        [button setTitle:@"停止" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stopBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)stopBtn_Pressed{

    [self.timer invalidate];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    for (int i = 0; i<snowCount; i++) {
        //保存当前绘图状态
        CGContextSaveGState(context);
        //平移坐标系统
        CGContextTranslateCTM(context, snowpos[i].x, snowpos[i].y);
        //旋转坐标系统
        CGContextRotateCTM(context, (arc4random()%6 - 3) *M_PI/10);
        //控制下落
        snowpos[i].y += arc4random() %8;
        if (snowpos[i].y >= UISCREEN_HEIGHT - 60) {
            snowpos[i].y = 4;
        }
        //绘制雪花
        [self CGContextAddFlower:context n:6 x:0 y:0 size:4 length:5];
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        
    }
}

/**
 *  绘制花瓣
 *
 *  @param context 上下文
 *  @param n       n花瓣
 *  @param dx      中心位置x
 *  @param dy      中心位置y
 *  @param size    大小
 *  @param lenght  长度
 */
- (void)CGContextAddFlower:(CGContextRef) context n:(NSInteger) n x:(CGFloat) dx y:(CGFloat) dy size:(NSInteger) size length:(NSInteger) length{
    
    CGContextMoveToPoint(context, dx, dy+size);
    CGFloat dig = 2*M_PI/n;
    for (int i = 0; i<=n; i++) {
        //计算控制点
        CGFloat ctr1x = sin((i-0.5) * dig) *length + dx;
        CGFloat ctr1y = cos((i-0.5) * dig) *length + dx;
        //结束点
        CGFloat x = sin(i*dig) * size + dx;
        CGFloat y = cos(i*dig) * size + dy;
        
        CGContextAddQuadCurveToPoint(context, ctr1x, ctr1y, x, y);
    }
    
}

@end
