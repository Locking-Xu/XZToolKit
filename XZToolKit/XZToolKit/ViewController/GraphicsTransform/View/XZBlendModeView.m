//
//  XZBlendModeView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/7.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBlendModeView.h"
@interface XZBlendModeView()<UIPickerViewDataSource,UIPickerViewDelegate>{

    UIPickerView *_pickerView;
    UIColor *_destinationColor;
    UIColor *_sourceColor;
    CGBlendMode _blendMode;
}
@property (nonatomic, strong) NSArray *colors;
@end

@implementation XZBlendModeView

static NSString *blendMode[] = {
    @"Normal",
    @"Multiply",
    @"Screen",
    @"Overlay",
    @"Darken",
    @"Lighten",
    @"ColorDodge",
    @"ColorBurn",
    @"SoftLight",
    @"HardLight",
    @"Difference",
    @"Exclusion",
    @"Hue",
    @"Saturation",
    @"Color",
    @"Luminosity",
    @"Clear",
    @"Copy",
    @"SourceIn",
    @"SourceOut",
    @"SourceAtop",
    @"DestinationOver",
    @"DestinationIn",
    @"DestinationOut",
    @"DestinationAtop",
    @"XOR",
    @"PlusDarker",
    @"PlusLighter"
};

static NSInteger blendModeCount = sizeof(blendMode)/sizeof(blendMode[0]);

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/2.0, UISCREEN_WIDTH, UISCREEN_HEIGHT/2.0)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
        
        _sourceColor = [UIColor redColor];
        _destinationColor = [UIColor blackColor];
        _blendMode = kCGBlendModeNormal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextSetFillColorWithColor(context, _destinationColor.CGColor);
    CGContextFillRect(context, CGRectMake(120.0f, 20.0f, 140.0f, 140.0f));
    CGContextSetBlendMode(context, _blendMode);
    CGContextSetFillColorWithColor(context, _sourceColor.CGColor);
    CGContextFillRect(context, CGRectMake(60.0, 55.0, 260.0, 70.0));
}

#pragma mark - Private_Methods
/**
 *  计算颜色的亮度
 *
 *  @param color 颜色
 *
 *  @return 亮度
 */
CGFloat luminanceForColor(UIColor *color){
    //获取各颜色组件
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat luminance = 0.0;
    
    //获取颜色模式,根据不同的颜色模式采用不同的方法计算颜色亮度
    switch (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor))) {
        case kCGColorSpaceModelMonochrome:
            luminance = components[0];
            break;
        case kCGColorSpaceModelRGB:
            luminance = 0.2126 * components[0] + 0.7152 * components[1] + 0.0722 * components[2];
            break;
        default:
            luminance = 2.0;
            break;
    }
    return luminance;
}

#pragma mark - Setter && Getter
- (NSArray *)colors{

    if (!_colors) {
        
        _colors = @[
                    [UIColor redColor],
                    [UIColor greenColor],
                    [UIColor blueColor],
                    [UIColor yellowColor],
                    [UIColor magentaColor],
                    [UIColor cyanColor],
                    [UIColor orangeColor],
                    [UIColor purpleColor],
                    [UIColor brownColor],
                    [UIColor whiteColor],
                    [UIColor lightGrayColor],
                    [UIColor darkGrayColor],
                    [UIColor blackColor],
                    ];
        _colors = [_colors sortedArrayUsingComparator:^NSComparisonResult(UIColor *color1, UIColor *color2) {
            
            CGFloat luminance1 = luminanceForColor(color1);
            CGFloat luminance2 = luminanceForColor(color2);
            if (luminance1 == luminance2)
                return NSOrderedSame;
            else if (luminance1 < luminance2)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
    }
    return _colors;
}

#pragma mark - UIPickerView_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    switch (component) {
        case 0:
        case 1:
            return self.colors.count;
        case 2:
            return blendModeCount;
        default:
            return 0;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{

    switch (component) {
        case 0:
        case 1:
            return 50.0f;
        case 2:
            return 200.0f;
        default:
            return 0.0f;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    switch (component){
        case 0:
        case 1:
        {
            if (view.tag != 1) {
                CGRect frame = CGRectZero;
                frame.size = [pickerView rowSizeForComponent:component];
                frame = CGRectInset(frame, 4.0, 4.0);
                view = [[UIView alloc] initWithFrame:frame];
                view.tag = 1;
                view.userInteractionEnabled = NO;
            }
            view.backgroundColor = self.colors[row];
            return view;
        }
            break;
        case 2:
        {
            if (view.tag != 2) {
                
                CGRect frame = CGRectZero;
                frame.size = [pickerView rowSizeForComponent:component];
                frame = CGRectInset(frame, 4.0f, 4.0f);
                view = [[UILabel alloc] initWithFrame:frame];
                view.tag = 2;
                view.userInteractionEnabled = NO;
            }
            UILabel *label = (UILabel *)view;
            label.text = blendMode[row];
            
            return view;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - UIPickerView_Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _destinationColor = self.colors[[pickerView selectedRowInComponent:0]];
    _sourceColor = self.colors[[pickerView selectedRowInComponent:2]];
    _blendMode = (CGBlendMode)[pickerView selectedRowInComponent:2];
    [self setNeedsDisplay];
}
@end
