//
//  XZQuartz2DTextViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DTextViewController.h"
#import <Masonry/Masonry.h>
#import "XZQuartz2DTextView.h"

@interface XZQuartz2DTextViewController (){

    __weak XZQuartz2DTextViewController *weakSelf;
}
@property (nonatomic, strong) UILabel *rotateLab;
@property (nonatomic, strong) UILabel *scaleLab;
@property (nonatomic, strong) UISlider *rotateSlider;
@property (nonatomic, strong) UISlider *scaleSlider;
@property (nonatomic, strong) XZQuartz2DTextView *textView;
@end

@implementation XZQuartz2DTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.rotateLab.text = @"旋转";
    self.rotateSlider.value = 0;
    self.scaleLab.text = @"缩放";
    self.scaleSlider.value = 1;
    self.textView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UILabel *)rotateLab{

    if (!_rotateLab) {
        
        _rotateLab = [[UILabel alloc] init];
        [self.view addSubview:_rotateLab];
        [_rotateLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view).offset(20);
            make.height.mas_equalTo(@40);
            make.width.mas_equalTo(@50);
            
        }];
    }
    return _rotateLab;
}

- (UISlider *)rotateSlider{

    if (!_rotateSlider) {
        
        _rotateSlider = [[UISlider alloc] init];
        _rotateSlider.minimumValue = -90.0;
        _rotateSlider.maximumValue = 90.0;
        [_rotateSlider addTarget:self action:@selector(changerRotate:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_rotateSlider];
        [_rotateSlider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakSelf.rotateLab.mas_right);
            make.right.equalTo(weakSelf.view).offset(-20);
            make.centerY.equalTo(weakSelf.rotateLab);
        }];
    }
    return _rotateSlider;
}

- (UILabel *)scaleLab{

    if (!_scaleLab) {
        
        _scaleLab = [[UILabel alloc] init];
        [self.view addSubview:_scaleLab];
        [_scaleLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(weakSelf.rotateLab.mas_top);
            make.left.equalTo(weakSelf.rotateLab);
            make.height.equalTo(weakSelf.rotateLab);
            make.width.equalTo(weakSelf.rotateLab);
        }];
    }
    return _scaleLab;
}
- (UISlider *)scaleSlider{

    if (!_scaleSlider) {
        
        _scaleSlider = [[UISlider alloc] init];
        _scaleSlider.minimumValue = 0.0f;
        _scaleSlider.maximumValue = 5.0;
        [_scaleSlider addTarget:self action:@selector(changerScale:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_scaleSlider];
        [_scaleSlider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(weakSelf.scaleLab);
            make.left.equalTo(weakSelf.rotateSlider);
            make.right.equalTo(weakSelf.rotateSlider);
        }];
        
    }
    return _scaleSlider;
}

- (XZQuartz2DTextView *)textView{

    if (!_textView) {
        
        _textView = [[XZQuartz2DTextView alloc] init];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.scaleLab.mas_top).offset(-20);
        }];
    }
    return _textView;
}

- (void)changerScale:(UISlider *)sender{

    self.textView.scale = sender.value;
}
- (void)changerRotate:(UISlider *)sender{
    self.textView.rotate = sender.value;
}
@end
