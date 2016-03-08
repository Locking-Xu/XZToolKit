//
//  XZCircleLockView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCircleLockView.h"
#import "XZGesturesPasswordConfig.h"
#import "XZCircle.h"
@interface XZCircleLockView(){
    
    CGFloat _width;
    CGPoint _currectPoint;
}
@property (nonatomic, strong) NSMutableArray *circleArray;
@end

@implementation XZCircleLockView
- (id)init{
    
    self = [super init];
    if (self) {
        
        _width = (UISCREEN_WIDTH - CircleLockMargin * 4)/3.0;
        [self addCircle];
    }
    return self;
}

/**
 *  添加9个小圆环
 */
- (void)addCircle{
    
    for (NSInteger i = 0; i<9; i++) {
        
        XZCircle *circle = [[XZCircle alloc] init];
        circle.kind = CircleLockView;
        [self addSubview:circle];
    }
}

- (void)layoutSubviews{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSUInteger row = idx / 3;//行
        NSUInteger column = idx % 3;//列
        
        CGFloat x = _width * column + (column+1) * CircleLockMargin;
        CGFloat y = _width * row + (row+1) * CircleLockMargin;
        
        obj.frame = CGRectMake(x, y, _width, _width);
        obj.tag = idx;

    }];
}

- (void)drawRect:(CGRect)rect{
    
    if (!self.circleArray || self.circleArray.count == 0)
        return;
    
    UIColor *color = [self getCurrentState] == CircleStateError ? CircleStateErrorLineColor : CircleStateNormalLineColor;
    
    [self connectCircleInRect:rect color:color];
}

#pragma mark - Private_Methods
/**
 *  连线
 */
- (void)connectCircleInRect:(CGRect)rect color:(UIColor *)color{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //进行裁剪
    CGContextAddRect(context, rect);
    [self.subviews enumerateObjectsUsingBlock:^(__kindof XZCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGContextAddEllipseInRect(context, obj.frame);//要裁减的形状
    }];
    CGContextEOClip(context);
    
    
    //遍历数组中的Circle
    for (NSInteger i = 0; i<self.circleArray.count; i++) {
        
        XZCircle *circel = self.circleArray[i];
        if (i == 0) {
            CGContextMoveToPoint(context, circel.center.x, circel.center.y);
        }else{
            CGContextAddLineToPoint(context, circel.center.x, circel.center.y);
        }
    }
    
    //连接最后一个按钮到手指的位置
    if (!CGPointEqualToPoint(_currectPoint, CGPointZero)) {
        
        if ([self getCurrentState] != CircleStateError)
            CGContextAddLineToPoint(context, _currectPoint.x, _currectPoint.y);
    }
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineWidth(context, CircleLockConnectLineWidth);
    [color set];
    CGContextStrokePath(context);
}

/**
 *  设置选中的circle的状态
 *
 *  @param state 状态
 */
- (void)setAllCircleToState:(State)state{
    
    [self.circleArray enumerateObjectsUsingBlock:^(XZCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.state = state;
    }];
}

/**
 *  设置最后一个circle的状态
 *
 *  @param state 状态
 */
- (void)setLastCircleToState:(State)state{
    
    ((XZCircle *)self.circleArray.lastObject).state = state;
}

/**
 *  获取当前连线的状态
 */
- (State)getCurrentState{
    
    return ((XZCircle *)self.circleArray.firstObject).state;
}

/**
 *  连线错误处理
 */
- (void)connectCircleError{

    [self setAllCircleToState:CircleStateError];
    [self setLastCircleToState:CircleStateLastError];
    [self setNeedsDisplay];
}

/**
 *  重设所有的Circle、清空连线
 */
- (void)resetAllCircle{
    
    if ([self getCurrentState] == CircleStateError) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self setAllCircleToState:CircleStateNormal];
            [self.circleArray removeAllObjects];
            [self setNeedsDisplay];
        });
    }else{
    
        [self setAllCircleToState:CircleStateNormal];
        [self.circleArray removeAllObjects];
        [self setNeedsDisplay];
    }
}


/**
 *  没添加一个circle计算一次防线,并补上被跳过的circle
 */
- (void)calculateAngleAndConnectJumpCircle{
    
    if (self.circleArray.count <= 1)
        return;
    //取出最后一个对象
    XZCircle *lastOne = self.circleArray.lastObject;
    //取出倒数第二个对象
    XZCircle *lastTwo = self.circleArray[self.circleArray.count - 2];
    
    //两者中心点的位置
    CGFloat last_1_x = lastOne.center.x;
    CGFloat last_1_y = lastOne.center.y;
    CGFloat last_2_x = lastTwo.center.x;
    CGFloat last_2_y = lastTwo.center.y;
    
    //计算角度
    CGFloat angle = atan2(last_1_y - last_2_y, last_1_x - last_2_x) + M_PI_2;
    lastTwo.angle = angle;
    
    //处理跳跃线段
    CGPoint point = CGPointMake((last_1_x + last_2_x)/2.0f, (last_1_y + last_2_y)/2.0f);
    for (XZCircle *circle in self.subviews) {
        
        if (CGRectContainsPoint(circle.frame, point) && ![self.circleArray containsObject:circle]) {
            
            circle.angle = [[self.circleArray objectAtIndex:self.circleArray.count - 2] angle];
            [self.circleArray insertObject:circle atIndex:self.circleArray.count - 1];
            break;
        }
    }
}

/**
 *  获取设置的密码
 *
 *  @return 密码字符串
 */
- (NSString *)getPassword{
    
    NSMutableString *passwordString = [[NSMutableString alloc] init];
    for (XZCircle *circle in self.circleArray) {
        
        [passwordString appendFormat:@"%ld",(long)circle.tag];
    }
    return [passwordString copy];
}

#pragma mark - Setter && Getter
- (NSMutableArray *)circleArray{
    
    if (!_circleArray) {
        _circleArray = [NSMutableArray array];
    }
    return _circleArray;
}

#pragma mark - Touch_Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof XZCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (CGRectContainsPoint(obj.frame, point)) {
            
            obj.state = CircleStateSelected;
            [self.circleArray addObject:obj];
        }
    }];
    [self setLastCircleToState:CircleStateLastSelected];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof XZCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectContainsPoint(obj.frame, point)) {
            
            if (![self.circleArray containsObject:obj]) {
                
                [self.circleArray addObject:obj];
                [self calculateAngleAndConnectJumpCircle];
            }
        }else{
            
            _currectPoint = point;
        }
    }];
    
    [self setAllCircleToState:CircleStateSelected];
    
    [self setLastCircleToState:CircleStateLastSelected];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //至少设置四位数密码
    if (self.circleArray.count < 4) {
        
        [self.lockLabel showWarningMessage:TextLeastConnect];
        [self connectCircleError];
        
    }else{
        
        [self.lockLabel showNormalMessage:TextSetSuccess];
        [self.circleInfoView setFillWithPassword:[self getPassword]];
        NSLog(@"%@",[self getPassword]);
    }
    
    [self resetAllCircle];
}
@end
