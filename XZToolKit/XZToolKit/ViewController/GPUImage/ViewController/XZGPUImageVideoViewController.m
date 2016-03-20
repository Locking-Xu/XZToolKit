//
//  XZGPUImageVideoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImageVideoViewController.h"
#import <Masonry/Masonry.h>
#import <GPUImage/GPUImage.h>
#import <WebKit/WebKit.h>
@interface XZGPUImageVideoViewController ()
/** 拍摄按钮*/
@property (nonatomic, strong) UIButton *takeBtn;
/** 暂停按钮*/
@property (nonatomic, strong) UIButton *pauseBtn;

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWrite;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation XZGPUImageVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.takeBtn.backgroundColor = [UIColor blueColor];
    self.pauseBtn.backgroundColor = [UIColor redColor];
    self.slider.value = 0.0f;
    [self.videoCamera startCameraCapture];
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
        [_slider addTarget:self action:@selector(sliderBtn_Pressed:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_slider];
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.takeBtn.mas_top).offset(-10);
        }];
        
    }
    
    return _slider;
}


- (UIButton *)takeBtn{
    
    WS(weakself);
    if (!_takeBtn) {
        
        _takeBtn = [[UIButton alloc] init];
        [_takeBtn setTitle:@"拍摄" forState:UIControlStateNormal];
        [_takeBtn addTarget:self action:@selector(takeBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_takeBtn];
        [_takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.width.equalTo(weakself.view).multipliedBy(0.5);
            make.height.mas_equalTo(@30);
            make.bottom.equalTo(weakself.view);
        }];
    }
    return _takeBtn;
}

- (UIButton *)pauseBtn{
    WS(weakself);
    if (!_pauseBtn) {
        _pauseBtn = [[UIButton alloc] init];
        [_pauseBtn addTarget:self action:@selector(pauseBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
        [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.view addSubview:_pauseBtn];
        [_pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.takeBtn);
            make.bottom.equalTo(weakself.takeBtn);
            make.left.equalTo(weakself.takeBtn.mas_right);
            make.right.equalTo(weakself.view);
        }];
    }
    return _pauseBtn;
}

- (GPUImageView *)filterView{
    WS(weakself);
    if (!_filterView) {
        _filterView = [[GPUImageView alloc] init];
        _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self.view addSubview:_filterView];
        [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.view);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.slider.mas_top).offset(-10);
        }];
    }
    return _filterView;
}

- (GPUImageMovieWriter *)movieWrite{
    
    if (!_movieWrite) {
        NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:pathToMovie]) {
            [[NSFileManager defaultManager] removeItemAtPath:pathToMovie error:nil];
        }
        
        //unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
        NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
        _movieWrite = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(320, 320)];
        _movieWrite.encodingLiveVideo = YES;
    }
    
    
    return _movieWrite;
}

- (GPUImageOutput *)filter{
    
    if (!_filter) {
        
        _filter = [[GPUImageSepiaFilter alloc] init];
        [_filter addTarget:self.movieWrite];
        [_filter addTarget:self.filterView];
    }
    return _filter;
}

- (GPUImageVideoCamera *)videoCamera{
    
    if (!_videoCamera) {
        
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
        _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _videoCamera.horizontallyMirrorFrontFacingCamera = NO;
        _videoCamera.horizontallyMirrorRearFacingCamera = NO;
        [_videoCamera addTarget:self.filter];
    }
    return _videoCamera;
}



#pragma mark - UIButton_Actions
- (void)sliderBtn_Pressed:(UISlider *)sender{
    
    ((GPUImageSepiaFilter *)self.filter).intensity = sender.value;
}

- (void)takeBtn_Pressed:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        self.videoCamera.audioEncodingTarget = self.movieWrite;
        [self.movieWrite startRecording];
        
    }else{
        
        [sender setTitle:@"拍摄" forState:UIControlStateNormal];
        [self.movieWrite finishRecording];
        
    }
}

- (void)pauseBtn_Pressed:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
    
        [sender setTitle:@"继续" forState:UIControlStateNormal];
        [self.videoCamera pauseCameraCapture];
    }else{
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self.videoCamera resumeCameraCapture];
    }
}

#pragma mark - GPUImageMovieWriter_Delegate
- (void)movieRecordingCompleted{
    
    NSLog(@"录制成功");
}
- (void)movieRecordingFailedWithError:(NSError*)error{
    NSLog(@"录制失败");
}
@end
