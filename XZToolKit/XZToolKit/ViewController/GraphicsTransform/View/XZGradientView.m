//
//  XZGradientView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGradientView.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, GradientType){
    
    LinearGradient,
    RadialGradient
};
@interface XZGradientView(){

    BOOL _isBeforeStart;
    BOOL _isBehindStart;
    GradientType _type;
    CGGradientRef _gradient;
}
@property (nonatomic, strong) UILabel *beforeLabel;
@property (nonatomic, strong) UISwitch *beforeSwitch;
@property (nonatomic, strong) UILabel *behindLabel;
@property (nonatomic, strong) UISwitch *behindSwitch;
@property (nonatomic, strong) UILabel *kindLabel;
@property (nonatomic, strong) UISegmentedControl *kindSegment;
@end
@implementation XZGradientView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.behindLabel.text = @"填充结束点之后的区域";
        self.behindSwitch.on = _isBehindStart = YES;
        
        self.beforeLabel.text = @"填充开始点之前的区域";
        self.beforeSwitch.on = _isBeforeStart = NO;
        
        self.kindLabel.text = @"渐变类型";
        self.kindSegment.selectedSegmentIndex = _type = 0;
        self.clearsContextBeforeDrawing = YES;//每次绘制时清除上一次内容
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGFloat colors[] = {
                            1,0,0,1,
                            0,1,0,1,
                            0,0,1,1,
                            };
        _gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/sizeof(colors[0]));
        CGColorSpaceRelease(rgb);

    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //四周减小20
    CGRect clipRect = CGRectInset(rect, 20.0, 20.0);
    //定义开始、结束点
    CGPoint start,end;
    CGFloat startRadius,endRadius;
    CGContextClipToRect(context, clipRect);
    
    switch (_type) {
        case LinearGradient:
            //线性渐变
            start = CGPointMake(clipRect.origin.x, clipRect.origin.y + clipRect.size.height/4.0f);
            end = CGPointMake(clipRect.origin.x, clipRect.origin.y + clipRect.size.height/4.0f*3);
            CGContextDrawLinearGradient(context, _gradient, start, end, [self drawingOptions]);
            break;
        case RadialGradient:
            
            start = end = CGPointMake(CGRectGetMidX(clipRect), CGRectGetMidY(clipRect));
            CGFloat r = clipRect.size.width < clipRect.size.height ? clipRect.size.width : clipRect.size.height;
            startRadius = r/8.0f;
            endRadius = r/2.0f;
            CGContextDrawRadialGradient(context, _gradient, start, startRadius, end, endRadius, [self drawingOptions]);
            break;
        default:
            break;
    }
}

#pragma mark - Private_Methods
- (CGGradientDrawingOptions)drawingOptions{

    return _isBehindStart ? kCGGradientDrawsAfterEndLocation : kCGGradientDrawsBeforeStartLocation;
}

#pragma mark - Setter && Getter
- (UILabel *)behindLabel{
    WS(weakself);
    if (!_behindLabel) {
        
        _behindLabel = [[UILabel alloc] init];
        [self addSubview:_behindLabel];
        [_behindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself).offset(20);
            make.bottom.equalTo(weakself).offset(-20);
        }];
    }
    return _behindLabel;
}

- (UISwitch *)behindSwitch{

    WS(weakself);
    if (!_behindSwitch) {
        _behindSwitch = [[UISwitch alloc] init];
        [_behindSwitch addTarget:self action:@selector(behindSwitch_Pressed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_behindSwitch];
        [_behindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(weakself).offset(-20);
            make.centerY.equalTo(weakself.behindLabel);
        }];
    }
    return _behindSwitch;
}

- (UILabel *)beforeLabel{

    WS(weakself);
    if (!_beforeLabel) {
        
        _beforeLabel = [[UILabel alloc] init];
        [self addSubview:_beforeLabel];
        [_beforeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.behindLabel);
            make.bottom.equalTo(weakself.behindLabel.mas_top).offset(-20);
        }];
    }
    return _beforeLabel;
}

- (UISwitch *)beforeSwitch{

    WS(weakself);
    if (!_beforeSwitch) {
        
        _beforeSwitch = [[UISwitch alloc] init];
        [_beforeSwitch addTarget:self action:@selector(beforeSwitch_Pressed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_beforeSwitch];
        [_beforeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(weakself.behindSwitch);
            make.centerY.equalTo(weakself.beforeLabel);
        }];
    }
    return _beforeSwitch;
}

- (UILabel *)kindLabel{

    WS(weakself);
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        [self addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.beforeLabel);
            make.bottom.equalTo(weakself.beforeLabel.mas_top).offset(-20);
        }];
    }
    return _kindLabel;
}

- (UISegmentedControl *)kindSegment{

    WS(weakself);
    if (!_kindSegment) {
        
        _kindSegment = [[UISegmentedControl alloc] initWithItems:@[@"线性渐变",@"圆形渐变"]];
        [_kindSegment addTarget:self action:@selector(kindSegement_Pressed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_kindSegment];
        [_kindSegment mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(weakself.beforeSwitch);
            make.centerY.equalTo(weakself.kindLabel);
            make.width.mas_equalTo(@200);
        }];
    }
    return _kindSegment;
}

#pragma mark UIButton_Actions
- (void)beforeSwitch_Pressed:(UISwitch *)sender{
    _isBeforeStart = sender.on;
    self.behindSwitch.on = _isBehindStart = !sender.on;
    [self setNeedsDisplay];
    
}

- (void)behindSwitch_Pressed:(UISwitch *)sender{
    _isBehindStart = sender.on;
    self.beforeSwitch.on = _isBeforeStart = !sender.on;
    [self setNeedsDisplay];
}

- (void)kindSegement_Pressed:(UISegmentedControl *)sender{
   
    _type = sender.selectedSegmentIndex;
    [self setNeedsDisplay];
}
@end
