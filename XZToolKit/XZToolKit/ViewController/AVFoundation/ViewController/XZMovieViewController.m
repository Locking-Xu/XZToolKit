//
//  XZMovieViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/18.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>

@interface XZMovieViewController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation XZMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.moviePlayer play];
    
    [self thumbnailImageRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  获取视频缩略图
 */
-(void)thumbnailImageRequest{
    //获取13.0s、21.5s的缩略图
    [self.moviePlayer requestThumbnailImagesAtTimes:@[@13.0,@21.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    //方法二:
    
    //文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"will" ofType:@"mp4"];
//    path=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL fileURLWithPath:path];
    //根据url创建AVURLAsset
//    AVURLAsset *urlAsset=[AVURLAsset assetWithURL:url];
    //根据AVURLAsset创建AVAssetImageGenerator
//    AVAssetImageGenerator *imageGenerator=[AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
//    NSError *error=nil;
//    CMTime time=CMTimeMakeWithSeconds(20, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
//    CMTime actualTime;
//    CGImageRef cgImage= [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    if(error){
//        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
//        return;
//    }
//    CMTimeShow(actualTime);
//    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
    //保存到相册
//    UIImageWriteToSavedPhotosAlbum(image,nil, nil, nil);
//    CGImageRelease(cgImage);
}


#pragma mark - Setter & Getter
- (MPMoviePlayerController *)moviePlayer{
    
    if (!_moviePlayer) {
        
        //文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"mp4"];
        path=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _moviePlayer.view.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT/2);
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.moviePlayer.view.mas_bottom);
            make.left.equalTo(self.moviePlayer.view.mas_left);
            make.height.mas_equalTo(@100);
            make.width.mas_equalTo(@100);
        }];
    }
    return _imageView;
}

#pragma mark - Notification_Methods
/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",(long)self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",(long)self.moviePlayer.playbackState);
}

/**
 *  缩略图请求完成,此方法每次截图成功都会调用一次
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerThumbnailRequestFinished:(NSNotification *)notification{
    NSLog(@"视频截图完成.");
    UIImage *image=notification.userInfo[MPMoviePlayerThumbnailImageKey];
    
    self.imageView.image = image;
}


@end
