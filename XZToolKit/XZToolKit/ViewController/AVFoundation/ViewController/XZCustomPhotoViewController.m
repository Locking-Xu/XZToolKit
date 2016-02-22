//
//  XZCustomPhotoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/19.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCustomPhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>

typedef void(^ProPertyChangeBlock)(AVCaptureDevice *captureDevice);
@interface XZCustomPhotoViewController ()
/** 负责输入和输出设备之间的数据传递*/
@property (nonatomic, strong) AVCaptureSession *captureSession;
/** 负责从AVCaptureDevice获得输入数据*/
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;
/** 照片输出流*/
@property (nonatomic, strong) AVCaptureStillImageOutput *captureStillImageOutput;
/** 相机拍摄预览图层*/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
/** 自动闪光灯*/
@property (nonatomic, strong) UIButton *flashAutoBtn;
/** 打开闪光灯*/
@property (nonatomic, strong) UIButton *flashOnBtn;
/** 关闭闪光灯*/
@property (nonatomic, strong) UIButton *flashOffBtn;
/** 切换前后摄像头按钮*/
@property (nonatomic, strong) UIButton *toggleBtn;
/** 预览view*/
@property (nonatomic, strong) UIView *containerView;
/** 拍照按钮*/
@property (nonatomic, strong) UIButton *takeBtn;
/** 聚焦光标*/
@property (nonatomic, strong) UIImageView *focusCursor;

@end

@implementation XZCustomPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.flashAutoBtn setTitle:@"自动" forState:UIControlStateNormal];
    [self.flashOnBtn setTitle:@"开" forState:UIControlStateNormal];
    [self.flashOffBtn setTitle:@"关" forState:UIControlStateNormal];
    [self.toggleBtn setTitle:@"切换" forState:UIControlStateNormal];
    [self.takeBtn setTitle:@"拍照" forState:UIControlStateNormal];
    
    self.focusCursor.alpha = 0.0;
    
    self.containerView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    //设置分辨率
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetiFrame1280x720]) {
        
        [self.captureSession setSessionPreset:AVCaptureSessionPresetiFrame1280x720];
    }
    //获得输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    if (!captureDevice) {
        NSLog(@"取得后置摄像头错误");
        return;
    }
    
    //根据输入设备初始化设备输入对象,用于获得输入数据
    NSError *error = nil;
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"获取输入对象出错");
        return;
    }
    
    //初始化设备输出对象,用于获得输出对象
    self.captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *dic = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.captureStillImageOutput setOutputSettings:dic];
    
    //将设备输入添加到会话中
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
    }
    //将设备输出添加到会话中
    if ([self.captureSession canAddOutput:self.captureStillImageOutput]) {
        [self.captureSession addOutput:self.captureStillImageOutput];
    }
    
    [self addNotificationToCaptureDevice:captureDevice];
    [self setFlashButtonStatus];
    [self addGesturerecognizer];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //创建视屏预览层,用于实时展示摄像头状态
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.containerView.layer.masksToBounds = YES;
    
    //填充模式
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.captureVideoPreviewLayer.frame = self.containerView.layer.bounds;
    [self.containerView.layer insertSublayer:self.captureVideoPreviewLayer below:self.focusCursor.layer];
    [self.captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)postion{
    
    NSArray *array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in array) {
        
        if (device.position == postion)
            return device;
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

/**
 *  设置闪光灯按钮装坛
 */
- (void)setFlashButtonStatus{
    
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    AVCaptureFlashMode flashMode = captureDevice.flashMode;
    if ([captureDevice isFlashAvailable]) {
        
        self.flashAutoBtn.hidden = NO;
        self.flashOffBtn.hidden = NO;
        self.flashOnBtn.hidden = NO;
        self.flashAutoBtn.enabled = YES;
        self.flashOffBtn.enabled = YES;
        self.flashOnBtn.enabled = YES;
        self.flashAutoBtn.backgroundColor = [UIColor grayColor];
        self.flashOffBtn.backgroundColor = [UIColor grayColor];
        self.flashOnBtn.backgroundColor = [UIColor grayColor];
        
        switch (flashMode) {
            case AVCaptureFlashModeAuto:
                self.flashAutoBtn.enabled = NO;
                self.flashAutoBtn.backgroundColor = [UIColor greenColor];
                break;
            case AVCaptureFlashModeOff:
                self.flashOffBtn.enabled = NO;
                self.flashOffBtn.backgroundColor = [UIColor greenColor];
                break;
            case AVCaptureFlashModeOn:
                self.flashOnBtn.enabled = NO;
                self.flashOnBtn.backgroundColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        
    }else{
        
        self.flashAutoBtn.hidden = YES;
        self.flashOffBtn.hidden = YES;
        self.flashOnBtn.hidden = YES;
    }
}

/**
 *  设置闪光灯模式
 *
 *  @param mode 模式
 */
- (void)setFlashMode:(AVCaptureFlashMode)mode{
    
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:mode]) {
            [captureDevice setFlashMode:mode];
        }
    }];
}

/**
 *  设置聚焦点
 *
 *  @param focusMode    聚焦模式
 *  @param exposureMode 曝光模式
 *  @param point        聚焦点
 */
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{

    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
       
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

/**
 *  照片保存成功,方法名必须是这个格式
 *
 *  @param image       照片
 *  @param error       错误信息
 *  @param contextInfo 上下文
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"保存完成");
}

#pragma mark - UIButton_Actions
- (void)flashAutoBtn_Pressed:(UIButton *)sender{
    
    [self setFlashMode:AVCaptureFlashModeAuto];
    [self setFlashButtonStatus];
}
- (void)flashOffBtn_Pressed:(UIButton *)sender{
    
    [self setFlashMode:AVCaptureFlashModeOff];
    [self setFlashButtonStatus];
}
- (void)flashOnBtn_Pressed:(UIButton *)sender{
    
    [self setFlashMode:AVCaptureFlashModeOn];
    [self setFlashButtonStatus];
}

- (void)toggleBtn_Pressed:(UIButton *)sender{

    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [captureDevice position];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition = AVCaptureDevicePositionFront;
    if (currentPosition == AVCaptureDevicePositionUnspecified || currentPosition == AVCaptureDevicePositionFront) {
        toChangePosition = AVCaptureDevicePositionBack;
    }
    
    //获取最新的设备
    toChangeDevice = [self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    
    //获得调整后的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toChangeDevice error:nil];
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原来的输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    
    //提交会话配置
    [self.captureSession commitConfiguration];
    [self setFlashButtonStatus];
    
}

- (void)takeBtn_Pressed:(UIButton *)sender{
    
    //根据设备输出获得连接
    AVCaptureConnection *captureConnect = [self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnect completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
       
        if (imageDataSampleBuffer) {
            
            NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}

#pragma mark - UIGestureRecognizer
- (void)addGesturerecognizer{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self.containerView addGestureRecognizer:tapGesture];
}

- (void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    
    CGPoint point = [tapGesture locationInView:self.containerView];
    //将UI坐标转化成摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    
    //设置聚焦光标的位置
    self.focusCursor.center = point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
    
        self.focusCursor.alpha = 0.0;
    }];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
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

#pragma mark - Setter & Getter
- (UIButton *)flashAutoBtn{
    WS(weakSelf);
    if (!_flashAutoBtn) {
        
        _flashAutoBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            button.backgroundColor = [UIColor grayColor];
            [button addTarget:self action:@selector(flashAutoBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.view);
                make.leading.equalTo(weakSelf.view);
                make.height.mas_equalTo(@50);
                make.width.mas_equalTo(@50);
            }];
            button;
        });
    }
    
    return _flashAutoBtn;
}

- (UIButton *)flashOnBtn{
    WS(weakSelf);
    if (!_flashOnBtn) {
        
        _flashOnBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            
            button.backgroundColor = [UIColor grayColor];
            [button addTarget:self action:@selector(flashOnBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.view);
                make.left.equalTo(weakSelf.flashAutoBtn.mas_right).offset(20);
                make.height.equalTo(weakSelf.flashAutoBtn);
                make.width.equalTo(weakSelf.flashAutoBtn);
            }];
            
            button;
        });
    }
    return _flashOnBtn;
}

- (UIButton *)flashOffBtn{
    WS(weakSelf);
    if (!_flashOffBtn) {
        
        _flashOffBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            
            button.backgroundColor = [UIColor grayColor];
            [button addTarget:self action:@selector(flashOffBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.view);
                make.left.equalTo(weakSelf.flashOnBtn.mas_right).offset(20);
                make.height.equalTo(weakSelf.flashOnBtn.mas_height);
                make.width.equalTo(weakSelf.flashOnBtn.mas_width);
            }];
            
            button;
        });
    }
    return _flashOffBtn;
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
               
                make.right.equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.view);
                make.height.equalTo(weakSelf.flashOnBtn);
                make.width.equalTo(weakSelf.flashOnBtn);
            }];
            
            button;
        });
    }
    return _toggleBtn;
}

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
                make.height.mas_equalTo(@50);
            }];
            
            button;
        });
    }
    return _takeBtn;
}

- (UIView *)containerView{
    WS(weakSelf);
    if (!_containerView) {
        
        _containerView = ({
            UIView *view = [[UIView alloc] init];
            [self.view addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(weakSelf.flashOnBtn.mas_bottom);
                make.left.equalTo(weakSelf.view);
                make.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.takeBtn.mas_top);
            }];
            view;
        });
    }
    return _containerView;
}

- (UIImageView *)focusCursor{
    WS(weakSelf);
    if (!_focusCursor) {
        _focusCursor = ({
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.containerView addSubview:imageView];
            imageView.image = [UIImage imageNamed:@"cameraFocus"];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.center.equalTo(weakSelf.containerView);
                make.height.mas_equalTo(@50);
                make.width.mas_equalTo(@50);
            }];
            imageView;
        });
    }
    return _focusCursor;
}
@end
