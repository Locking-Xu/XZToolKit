//
//  XZGPUImagePhotoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/10.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImagePhotoViewController.h"
#import <GPUImage/GPUImage.h>
#import <Masonry/Masonry.h>
#import "XZAlbumHelper.h"

@interface XZGPUImagePhotoViewController ()
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageView *primaryView;
@property (nonatomic, strong) UIButton *takeBtn;
@property (nonatomic, strong) UIButton *changeBtn;
@end

@implementation XZGPUImagePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.stillCamera startCameraCapture];
    self.takeBtn.backgroundColor = [UIColor blueColor];
    self.changeBtn.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (GPUImageOutput *)filter{
    if (!_filter) {
        
        _filter = [[GPUImageSketchFilter alloc] init];
        [_filter addTarget:self.primaryView];
    }
    return _filter;
}

- (GPUImageStillCamera *)stillCamera{
    if (!_stillCamera) {
        
        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        [_stillCamera addTarget:self.filter];
        
    }
    return _stillCamera;
}

- (GPUImageView *)primaryView{
    
    WS(weakself);
    if (!_primaryView) {
        _primaryView = [[GPUImageView alloc] init];
        _primaryView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self.view addSubview:_primaryView];
        [_primaryView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.view);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.height.equalTo(weakself.view.mas_width);
        }];
    }
    return _primaryView;
}

- (UIButton *)takeBtn{
    
    WS(weakself);
    if (!_takeBtn) {
        _takeBtn = [[UIButton alloc] init];
        [_takeBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [_takeBtn addTarget:self action:@selector(takeBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_takeBtn];
        [_takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.view);
            make.height.mas_equalTo(@35);
        }];
    }
    return _takeBtn;
}

- (UIButton *)changeBtn{
    
    WS(weakself);
    if (!_changeBtn) {
        
        _changeBtn = [[UIButton alloc] init];
        [_changeBtn setTitle:@"镜头切换" forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_changeBtn];
        [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.height.equalTo(weakself.takeBtn);
            make.bottom.equalTo(weakself.takeBtn.mas_top).offset(-10);
        }];
    }
    return _changeBtn;
}

#pragma mark - UIButton_Actions
- (void)takeBtn_Pressed{

    [self.stillCamera capturePhotoAsJPEGProcessedUpToFilter:self.filter withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
        
        [[XZAlbumHelper shareInstance] saveImageToAblumWithImage:[UIImage imageWithData:processedJPEG] successful:^(NSURL *url) {
            
            NSLog(@"保存成功");
            
        } fail:^(NSString *error) {
           
            NSLog(@"保存失败");
        }];

    }];
}

- (void)changeBtn_Pressed{
    
    [self.stillCamera rotateCamera];

}
@end
