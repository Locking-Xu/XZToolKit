//
//  XZQuartz2DDrawBoardView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DDrawBoardView.h"

@implementation XZQuartz2DDrawBoardView
{
    /** 向内存中的图片执行绘图的CGContextRef*/
    CGContextRef _buffContext;
    CGPoint _firstTouch;
    CGPoint _prevTouch;
    CGPoint _lastTouch;
    UIImage *_image;
}

- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(UISCREEN_WIDTH - 20.0f, UISCREEN_HEIGHT - 58*2), NO, [UIScreen mainScreen].scale);
        _buffContext = UIGraphicsGetCurrentContext();

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    [_image drawAtPoint:CGPointZero];

}

#pragma mark - UITouch_Methods
//手指开始触碰
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    _firstTouch = [touch locationInView:self];
    if (self.kind == kPen) {
        
        _prevTouch = _firstTouch;
    }
    
}

//手指拖动时
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (self.kind == kPen) {
        UITouch *touch = [touches anyObject];
        _lastTouch = [touch locationInView:self];
        [self draw:_buffContext];
        _image = UIGraphicsGetImageFromCurrentImageContext();
        [self setNeedsDisplay];
    }

}

//手指离开
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    [self draw:_buffContext];
    _image = UIGraphicsGetImageFromCurrentImageContext();
    [self setNeedsDisplay];
}

#pragma mark - Private_Methods
- (CGRect)curRect{

    return CGRectMake(_firstTouch.x, _firstTouch.y, _lastTouch.x-_firstTouch.x, _lastTouch.y - _firstTouch.y);
}

/**
 *  绘制圆角矩形
 *
 *  @param context 上下文
 *  @param x       左上角x
 *  @param y       左上角y
 *  @param width   宽度
 *  @param height  高度
 *  @param radius  半径
 */
- (void)CGContextAddRoundRect:(CGContextRef) context x:(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height radius:(CGFloat) radius{
    
    CGContextMoveToPoint(context, x + radius, y);
    CGContextAddLineToPoint(context, x + width-radius, y);
    CGContextAddArcToPoint(context, x+width, y, x+width, y+radius, radius);
    CGContextAddLineToPoint(context, x+width, y+height-radius);
    CGContextAddArcToPoint(context, x+width, y+height, x+width-radius, y+height, radius);
    CGContextAddLineToPoint(context, x+radius, y+height);
    CGContextAddArcToPoint(context, x, y+height, x, y+height-radius, radius);
    CGContextAddLineToPoint(context, x, y+radius);
    CGContextAddArcToPoint(context, x, y, x+radius, y, radius);
}

- (void)draw:(CGContextRef)ctx{

    CGContextSetStrokeColorWithColor(ctx, self.currentColor.CGColor);
    CGContextSetFillColorWithColor(ctx, self.currentColor.CGColor);
    CGContextSetLineWidth(ctx, 2.0f);
    CGContextSetShouldAntialias(ctx, YES);
    
    switch (self.kind) {
        case kLine:
            CGContextMoveToPoint(ctx, _firstTouch.x, _firstTouch.y);
            CGContextAddLineToPoint(ctx, _lastTouch.x, _lastTouch.y);
            CGContextStrokePath(ctx);
            break;
        case kRect:
            CGContextFillRect(ctx, [self curRect]);
            break;
        case kEllipse:
            CGContextFillEllipseInRect(ctx, [self curRect]);
            break;
        case kRoundRect:
        {
            //计算左上角坐标
            CGFloat leftTopX = _firstTouch.x<_lastTouch.x ? _firstTouch.x : _lastTouch.x;
            CGFloat leftTopY = _firstTouch.y<_lastTouch.y ? _firstTouch.y : _lastTouch.y;
            
            [self CGContextAddRoundRect:ctx x:leftTopX y:leftTopY width:fabs(_firstTouch.x - _lastTouch.x) height:fabs(_firstTouch.y - _lastTouch.y) radius:10.0f];
            CGContextFillPath(ctx);
        }
            break;
        case kPen:
            //添加从_prevTouch到_lastTouch的路径
            CGContextMoveToPoint(ctx, _prevTouch.x, _prevTouch.y);
            CGContextAddLineToPoint(ctx, _lastTouch.x, _lastTouch.y);
            CGContextStrokePath(ctx);
            _prevTouch = _lastTouch;
            break;
        default:
            break;
    }
}
@end
