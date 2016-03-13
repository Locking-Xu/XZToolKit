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
#import "XZLabelFlowThreeView.h"


@interface XZGPUImagePhotoViewController ()<XZLabelFlowThreeViewDelegate>{
    
    NSDictionary *_filterDic;

}
/** 相机*/
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;
/** 滤镜*/
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
/** 预览view*/
@property (nonatomic, strong) GPUImageView *primaryView;
/** 拍照按钮*/
@property (nonatomic, strong) UIButton *takeBtn;
/** 切换镜头按钮*/
@property (nonatomic, strong) UIButton *changeBtn;
/** 开闪光灯按钮*/
@property (nonatomic, strong) UIButton *flashOn;
/** 关闪光灯按钮*/
@property (nonatomic, strong) UIButton *flashOff;
/** 自动闪光灯按钮*/
@property (nonatomic, strong) UIButton *flashAuto;
/** 选择滤镜*/
@property (nonatomic, strong) XZLabelFlowThreeView *filterSelectView;
@end

@implementation XZGPUImagePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _filterDic = @{
                   @"亮度":@"GPUImageBrightnessFilter",
                   @"曝光":@"GPUImageExposureFilter",
                   @"对比度":@"GPUImageContrastFilter",
                   @"饱和度":@"GPUImageSaturationFilter",
                   @"伽马线":@"GPUImageGammaFilter",
                   @"反色":@"GPUImageColorInvertFilter",
                   @"褐色":@"GPUImageSepiaFilter",
                   @"色阶":@"GPUImageLevelsFilter",
                   @"灰度":@"GPUImageGrayscaleFilter",
                   @"色彩直方图，显示在图片上":@"GPUImageHistogramFilter",
                   @"色彩直方图":@"GPUImageHistogramGenerator",
                   @"RGB":@"GPUImageRGBFilter",
                   @"色调曲线":@"GPUImageToneCurveFilter",
                   @"单色":@"GPUImageMonochromeFilter",
                   @"不透明度":@"GPUImageOpacityFilter",
                   @"提亮阴影":@"GPUImageHighlightShadowFilter",
                   @"色彩替换（替换亮部和暗部色彩）":@"GPUImageFalseColorFilter",
                   @"色度":@"GPUImageHueFilter",
                   @"色度键":@"GPUImageChromaKeyFilter",
                   @"白平横":@"GPUImageWhiteBalanceFilter",
                   @"像素平均色值":@"GPUImageAverageColor",
                   @"纯色":@"GPUImageSolidColorGenerator",
                   @"亮度平均":@"GPUImageLuminosity",
                   @"像素色值亮度平均，图像黑白（有类似漫画效果）":@"GPUImageAverageLuminanceThresholdFilter",
                   };

    [self.stillCamera startCameraCapture];
    
    self.takeBtn.backgroundColor = [UIColor blueColor];
    self.changeBtn.backgroundColor = [UIColor redColor];
    
    self.flashOn.backgroundColor = [UIColor redColor];
    self.flashOff.backgroundColor = [UIColor yellowColor];
    self.flashAuto.backgroundColor = [UIColor purpleColor];
    
    self.filterSelectView.labelFlowThreeDelegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

#pragma mark - Setter && Getter
- (GPUImageOutput *)filter{
    if (!_filter) {
        
        _filter = [[GPUImageGammaFilter alloc] init];
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

- (UIButton *)flashOn{
    
    WS(weakself);
    if (!_flashOn) {
        _flashOn = [[UIButton alloc] init];
        [_flashOn setTitle:@"开" forState:UIControlStateNormal];
        [_flashOn addTarget:self action:@selector(flashOnBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_flashOn];
        [_flashOn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.height.equalTo(weakself.takeBtn);
            make.width.mas_equalTo(@50);
            make.bottom.equalTo(weakself.changeBtn.mas_top).offset(-10);
        }];
    }
    return _flashOn;
}

- (UIButton *)flashOff{
    
    WS(weakself);
    if (!_flashOff) {
        _flashOff = [[UIButton alloc] init];
        [_flashOff setTitle:@"关" forState:UIControlStateNormal];
        [self.view addSubview:_flashOff];
        [_flashOff addTarget:self action:@selector(flashOffBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [_flashOff mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.flashOn.mas_right).offset(10);
            make.top.equalTo(weakself.flashOn);
            make.width.equalTo(weakself.flashOn);
            make.height.equalTo(weakself.flashOn);
        }];
    }
    return _flashOff;
}

- (UIButton *)flashAuto{
    WS(weakself);
    if (!_flashAuto) {
        
        _flashAuto = [[UIButton alloc] init];
        [_flashAuto setTitle:@"自动" forState:UIControlStateNormal];
        [_flashAuto addTarget:self action:@selector(flashAutoBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_flashAuto];
        [_flashAuto mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.flashOff);
            make.left.equalTo(weakself.flashOff.mas_right).offset(10);
            make.width.equalTo(weakself.flashOff);
            make.height.equalTo(weakself.flashOff);
        }];
    }
    return _flashAuto;
}

- (XZLabelFlowThreeView *)filterSelectView{
    
    WS(weakself);
    if (!_filterSelectView) {
        
        XZLabelFlowThreeConfig *config = [[XZLabelFlowThreeConfig alloc] init];
        config.titleArray = _filterDic.allKeys;
        _filterSelectView = [[XZLabelFlowThreeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) config:config];
        [self.view addSubview:_filterSelectView];
        [_filterSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.flashOff.mas_top).offset(-10);
            make.height.mas_equalTo(@30);
        }];
    }
    return _filterSelectView;
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

- (void)flashOnBtn_Pressed{
    [self.stillCamera.inputCamera lockForConfiguration:nil];
    [self.stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
    [self.stillCamera.inputCamera unlockForConfiguration];
}

- (void)flashOffBtn_Pressed{
    [self.stillCamera.inputCamera lockForConfiguration:nil];
    [self.stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOff];
    [self.stillCamera.inputCamera unlockForConfiguration];
}

- (void)flashAutoBtn_Pressed{
    [self.stillCamera.inputCamera lockForConfiguration:nil];
    [self.stillCamera.inputCamera setFlashMode:AVCaptureFlashModeAuto];
    [self.stillCamera.inputCamera unlockForConfiguration];
}

#pragma mark - XZLabelFlowThree_Delegate
- (void)clickTagAtIndex:(NSInteger)index title:(NSString *)title{

    [self.stillCamera removeTarget:self.filter];
    
    Class class = NSClassFromString(_filterDic[title]);
    
    self.filter = [[class alloc] init];
    [self.filter addTarget:self.primaryView];
    [self.stillCamera addTarget:self.filter];
}
@end
