//
//  XZQuartz2DLineDashViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DLineDashViewController.h"
#import "XZQuartz2DDashView.h"
#import <Masonry/Masonry.h>

typedef struct{

    CGFloat pattern[5];
    size_t count;
}Pattern;

//初始化多个点线模式
static Pattern patterns[] = {
    {{10.0,10.0},2},
    {{10.0,20.0,10.0},3},
    {{10.0,20.0,30.0},3},
    {{10.0,10.0,20.0,20.0},4},
    {{10.0,10.0,20.0,30.0,50.0},5},
};

static NSInteger patternCount = sizeof(patterns)/sizeof(patterns[0]);

@interface XZQuartz2DLineDashViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{

    __weak XZQuartz2DLineDashViewController *weakSelf;
}
@property (nonatomic, strong) XZQuartz2DDashView *dashView;
@property (nonatomic, strong) UILabel *phaseLab;
@property (nonatomic, strong) UILabel *valueLab;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation XZQuartz2DLineDashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dashView.backgroundColor = [UIColor redColor];
    self.phaseLab.text = @"Phase";
    self.valueLab.text = @"0";
    self.slider.value = 0.5;
    self.valueLab.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dashPhase:(UISlider *)sender{
    self.valueLab.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    self.dashView.dashPase = sender.value;
}

#pragma mark - Setter && Getter
- (XZQuartz2DDashView *)dashView{
    if (!_dashView) {
        
        _dashView = [[XZQuartz2DDashView alloc] init];
        [_dashView setDashPattern:patterns[0].pattern count:patterns[0].count];
        [self.view addSubview:_dashView];
        [_dashView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.height.equalTo(weakSelf.view).multipliedBy(0.5);
        }];
    }
    return _dashView;
}

- (UILabel *)phaseLab{
    if (!_phaseLab) {
        
        _phaseLab = [[UILabel alloc] init];
        [_phaseLab setTextColor:[UIColor blackColor]];
        [self.view addSubview:_phaseLab];
        [_phaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.dashView.mas_bottom);
            make.left.equalTo(weakSelf.view);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@50);
        }];
    }
    return _phaseLab;
}
- (UILabel *)valueLab{
    
    if (!_valueLab) {
        
        _valueLab = [[UILabel alloc] init];
        [_valueLab setTextColor:[UIColor blackColor]];
        _valueLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_valueLab];
        
        [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.dashView.mas_bottom);
            make.right.equalTo(weakSelf.view);
            make.height.equalTo(weakSelf.phaseLab);
            make.width.equalTo(weakSelf.phaseLab);
        }];
    }
    return _valueLab;
}

- (UISlider *)slider{

    if (!_slider) {
        
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0.0f;
        _slider.maximumValue = 20.0f;
        [_slider addTarget:self action:@selector(dashPhase:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_slider];
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakSelf.phaseLab.mas_right);
            make.top.equalTo(weakSelf.phaseLab);
            make.height.equalTo(weakSelf.phaseLab);
            make.right.equalTo(weakSelf.valueLab.mas_left);
        }];
    }
    return _slider;
}

- (UIPickerView *)pickerView{

    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc] init];
        [self.view addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.phaseLab.mas_bottom);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
    }
    return _pickerView;
}

#pragma mark - UIPickerView_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return patternCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    Pattern p = patterns[row];
    NSMutableString *title = [NSMutableString stringWithFormat:@"%.0f",p.pattern[0]];
    for (size_t i = 1; i<p.count; ++i) {
        
        [title appendFormat:@"-%.0f",p.pattern[i]];
    }
    return title;
}
#pragma mark - UIPickerView_Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    [self.dashView setDashPattern:patterns[row].pattern count:patterns[row].count];
}
@end
