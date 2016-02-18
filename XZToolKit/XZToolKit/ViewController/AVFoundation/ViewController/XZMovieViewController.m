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
}


#pragma mark - Setter & Getter
- (MPMoviePlayerController *)moviePlayer{
    
    if (!_moviePlayer) {
        
        //文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"will" ofType:@"mp4"];
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
