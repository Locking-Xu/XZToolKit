//
//  XZCustomVideoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCustomVideoViewController.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^ProPertyChangeBlock)(AVCaptureDevice *captureDevice);
@interface XZCustomVideoViewController ()<AVCaptureFileOutputRecordingDelegate>
/** 拍摄按钮*/
@property (nonatomic, strong) UIButton *takeBtn;
/** 切换镜头按钮*/
@property (nonatomic, strong) UIButton *toggleBtn;
/** 内容区域*/
@property (nonatomic, strong) UIView *containerView;
/** 负责输入和输出设备之间的数据传递*/
@property (nonatomic, strong) AVCaptureSession *captureSession;
/** 负责从AVCaptureDevice获得输入数据*/
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;
/** 视屏输出流*/
@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;
/** 拍摄预览图层*/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;


@end

@implementation XZCustomVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.takeBtn setTitle:@"拍摄" forState:UIControlStateNormal];
    [self.toggleBtn setTitle:@"切换" forState:UIControlStateNormal];
    self.contentView.backgroundColor = [UIColor greenColor];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //初始化会话
    self.captureSession = [[AVCaptureSession alloc] init];
    //设置分辨率
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    //获得输入设备
     AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
        return;
    }
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    NSError *error;
    //根据输入设备初始化设备输入对象,用于获得输入数据
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"获取摄像头输入对象是出错");
        return;
    }
    AVCaptureDeviceInput *audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //初始化设备输出对象,用于获得输出数据
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    //将设备输入添加到会话中
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
        [self.captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported]) {
            
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }

    //将设备输出添加到会话中
    if ([self.captureSession canAddOutput:self.captureMovieFileOutput]) {
        [self.captureSession addOutput:self.captureMovieFileOutput];
    }
 
    [self addNotificationToCaptureDevice:captureDevice];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //创建视频预览层,用于实时展示摄像头状态
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    //填充模式
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.captureVideoPreviewLayer.frame = self.containerView.layer.bounds;
    [self.containerView.layer addSublayer:self.captureVideoPreviewLayer];
    [self.captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.captureSession stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private_Methods
/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
- (void)changeDeviceProperty:(ProPertyChangeBlock)propertyChange{
    
    AVCaptureDevice *captureDevice = self.captureDeviceInput.device;
    NSError *error;
    ////注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性错误");
    }
}

#pragma mark - Notification
/**
 *  给输出设备添加通知
 *
 *  @param captureDevice 输出设备
 */
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    
    //添加区域改变通知必须先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    //捕获区域发生改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

- (void)areaChange:(NSNotification *)notification{
    
    NSLog(@"设备区域发生改变");
}

#pragma mark - UIButton_Actions
- (void)takeBtn_Pressed:(UIButton *)sender{
    
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    if ([self.captureMovieFileOutput isRecording]) {
    //正在拍摄
        [self.takeBtn setTitle:@"开始拍摄" forState:UIControlStateNormal];
        [self.captureMovieFileOutput stopRecording];
    }else{
    //不在拍摄
        [self.takeBtn setTitle:@"停止拍摄" forState:UIControlStateNormal];
        //预览图层和视屏方向保持一致
        captureConnection.videoOrientation = [self.captureVideoPreviewLayer connection].videoOrientation;
        NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"];
        NSURL *fileUrl = [NSURL fileURLWithPath:outputFilePath];
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
    }
}

- (void)toggleBtn_Pressed:(UIButton *)sender{
    
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
        toChangePosition=AVCaptureDevicePositionBack;
    }
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];

}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    
    NSLog(@"开始录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    NSLog(@"结束录制");
    //视屏录制结束将视屏保存到相册
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
       
        if (error) {
            NSLog(@"保存失败");
        }else{
            
            NSLog(@"保存成功");
        }
    }];
}

#pragma mark - Setter && Getter
- (UIButton *)takeBtn{
    WS(weakSelf);
    if (!_takeBtn) {
        
        _takeBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(takeBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.equalTo(weakSelf.view);
                make.left.equalTo(weakSelf.view);
                make.right.equalTo(weakSelf.view);
                make.height.mas_equalTo(@30);
            }];
            
            button;
        });
    }
    return _takeBtn;
}

- (UIButton *)toggleBtn{
    WS(weakSelf);
    if (!_toggleBtn) {
        
        _toggleBtn = ({
        
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor grayColor];
            [button addTarget:self action:@selector(toggleBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.view);
                make.left.equalTo(weakSelf.view);
                make.right.equalTo(weakSelf.view);
                make.height.equalTo(weakSelf.takeBtn);
            }];
            
            button;
        });
    }
    return _toggleBtn;
}

- (UIView *)contentView{
    WS(weakSelf)
    if (!_containerView) {
        
        _containerView = ({
            
            UIView *view = [[UIView alloc] init];
            view.layer.masksToBounds = YES;
            [self.view addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.toggleBtn.mas_bottom);
                make.left.equalTo(weakSelf.view);
                make.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.takeBtn.mas_top);
            }];
            
            view;
        });
    }
    return _containerView;
}
@end
