//
//  XZGPUImageImageViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/15.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImageImageViewController.h"
#import <GPUImage/GPUImage.h>
#import <Masonry/Masonry.h>
@interface XZGPUImageImageViewController ()
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageView *primaryView;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation XZGPUImageImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"2"];
    self.sourcePicture = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    self.filter = [[GPUImageTiltShiftFilter alloc] init];
    
    [self.filter forceProcessingAtSize:self.primaryView.sizeInPixels];
    [self.sourcePicture addTarget:self.filter];
    [self.filter addTarget:self.primaryView];
    
    [self.sourcePicture processImage];
    
    self.slider.value = 0.5f;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UISlider *)slider{
    
    WS(weakself);
    if (!_slider) {
     
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0.0f;
        _slider.maximumValue = 10.0f;
        [_slider addTarget:self action:@selector(slider_Changed:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_slider];
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view).offset(10.0f);
            make.right.equalTo(weakself.view).offset(-10.0f);
            make.bottom.equalTo(weakself.view).offset(-10.0f);
        }];
        
    }
    return _slider;
}

- (GPUImageView *)primaryView{
    WS(weakself);
    if (!_primaryView) {
        
        _primaryView = [[GPUImageView alloc] init];
        [self.view addSubview:_primaryView];
        [_primaryView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.view);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.slider.mas_top);
        }];
    }
    return _primaryView;
}

#pragma mark - UIButton_Actions
- (void)slider_Changed:(UISlider *)sender{

    [(GPUImageTiltShiftFilter *)self.filter setTopFocusLevel:sender.value];
    [(GPUImageTiltShiftFilter *)self.filter setBottomFocusLevel:sender.value];
    
    [self.sourcePicture processImageWithCompletionHandler:^{
        NSLog(@"Completed");
    }];

}
@end
