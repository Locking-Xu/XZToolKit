//
//  XZImagePickerViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/19.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImagePickerViewController.h"
#import <Masonry/Masonry.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface XZImagePickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIButton *videoBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation XZImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.showBtn setTitle:@"相片库" forState:UIControlStateNormal];
    [self.photoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [self.videoBtn setTitle:@"拍视频" forState:UIControlStateNormal];
    [self.imageView setBackgroundColor:[UIColor redColor]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter & Getter
- (UIButton *)showBtn{
    
    if (!_imageBtn) {
        
        _imageBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            button.backgroundColor = [UIColor blueColor];
            button.tag = 100;
            [button addTarget:self action:@selector(button_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            WS(weakSelf);
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.center.equalTo(weakSelf.view);
                make.height.mas_equalTo(@30);
                make.width.mas_equalTo(@100);
                
            }];
            button;
        });
    }
    return _imageBtn;
}

- (UIButton *)photoBtn{
    
    if (!_photoBtn) {
        
        _photoBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor blueColor];
            [self.view addSubview:button];
            button.tag = 200;
            [button addTarget:self action:@selector(button_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            WS(weakSelf);
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.imageBtn.mas_bottom).offset(20);
                make.centerX.equalTo(weakSelf.imageBtn.mas_centerX);
                make.height.equalTo(weakSelf.imageBtn.mas_height);
                make.width.equalTo(weakSelf.imageBtn.mas_width);
            }];
            
            button;
        });
    }
    return _photoBtn;
}

- (UIButton *)videoBtn{
    
    if (!_videoBtn) {
        
        _videoBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            
            button.tag = 300;
            [button addTarget:self action:@selector(button_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor blueColor]];
            [self.view addSubview:button];
            
            WS(weakSelf);
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.photoBtn.mas_bottom).offset(20);
                make.centerX.equalTo(weakSelf.view);
                make.width.equalTo(weakSelf.photoBtn.mas_width);
                make.height.equalTo(weakSelf.photoBtn.mas_height);
            }];
            
            button;
        });
    }
    return _videoBtn;
}

- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        [self.view addSubview:_imageView];
        WS(weakSelf);
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.imageBtn.mas_top).offset(-20);
            
        }];
    }
    return _imageView;
}

- (UIImagePickerController *)imagePicker{

    if (!_imagePicker) {
        
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

#pragma mark - UIButton_Actions
- (void)button_Pressed:(UIButton *)sender{

    if (sender.tag == 100) {
        //相片库
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (sender.tag == 200){
        //拍照
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }else if (sender.tag == 300){
        //拍视频
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        //设置摄像头模式
        self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    }

    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController_Delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    XZObjectLog(@"dismiss");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        XZObjectLog(mediaType);
    }];
    
    
}
@end
