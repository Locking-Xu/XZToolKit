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

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/2.0, UISCREEN_WIDTH, UISCREEN_HEIGHT/2.0)];
//        _pickerView.delegate = self;
//        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor redColor];
        [self addSubview:_pickerView];
        
        NSLog(@"%@",self.colors);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
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


@end
