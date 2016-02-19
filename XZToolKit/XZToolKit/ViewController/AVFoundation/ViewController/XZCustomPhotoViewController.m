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
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //创建视屏预览层,用于实时展示摄像头状态
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.containerView.layer.masksToBounds = YES;
    
    //填充模式
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.captureVideoPreviewLayer.frame = self.containerView.layer.bounds;
    [self.containerView.layer addSublayer:self.captureVideoPreviewLayer];
    [self.captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
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

- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)postion{
    
    NSArray *array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in array) {
        
        if (device.position == postion)
            return device;
    }
    
    return nil;
}

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

#pragma mark - Setter & Getter
- (UIButton *)flashAutoBtn{
    WS(weakSelf);
    if (!_flashAutoBtn) {
        
        _flashAutoBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            button.backgroundColor = [UIColor grayColor];
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
@end
