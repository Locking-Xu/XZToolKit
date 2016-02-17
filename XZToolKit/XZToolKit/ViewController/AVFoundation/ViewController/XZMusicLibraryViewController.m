//
//  XZMusicLibraryViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMusicLibraryViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface XZMusicLibraryViewController ()<MPMediaPickerControllerDelegate>

/** 媒体选择控制器*/
@property (nonatomic, strong) MPMediaPickerController *mediaPicker;
/** 音乐播放器*/
@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;
@end

@implementation XZMusicLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [self.musicPlayer endGeneratingPlaybackNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setter & Getter
- (MPMediaPickerController *)mediaPicker{

    if (!_mediaPicker) {
        
        _mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
        _mediaPicker.allowsPickingMultipleItems = YES;
        _mediaPicker.prompt = @"音乐库";
        _mediaPicker.delegate = self;
    }
    return _mediaPicker;
}

- (MPMusicPlayerController *)musicPlayer{

    if (!_musicPlayer) {
        
        _musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        //开启监听
        [_musicPlayer beginGeneratingPlaybackNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStateChange) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:_musicPlayer];
        //如果不使用MPMediaPickerController可以使用如下方法获得音乐库媒体队列
        //[_musicPlayer setQueueWithItemCollection:[self getLocalMediaItemCollection]];
        
    }
    return _musicPlayer;
}

#pragma mark - Private_Methods
- (void)playerStateChange{
    
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            //正在播放
            break;
        case MPMusicPlaybackStatePaused:
            //暂停
            break;
        case MPMusicPlaybackStateStopped:
            //停止
            break;
        default:
            break;
    }
    
}

/**
 *  取得媒体集合
 *
 *  @return 媒体集合
 */
-(MPMediaItemCollection *)getLocalMediaItemCollection{
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    NSMutableArray *array=[NSMutableArray array];
    for (MPMediaItem *item in mediaQueue.items) {
        [array addObject:item];
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    MPMediaItemCollection *mediaItemCollection=[[MPMediaItemCollection alloc]initWithItems:[array copy]];
    return mediaItemCollection;
}

#pragma mark - UIButton_Actions
- (IBAction)musicLibraryBtn_Pressed:(id)sender {
    
    [self presentViewController:self.mediaPicker animated:YES completion:nil];
}
                        

- (IBAction)playBtn_Pressed:(id)sender {
    
    [self.musicPlayer play];
}

- (IBAction)pauseBtn_Pressed:(id)sender {
    [self.musicPlayer pause];
}

- (IBAction)stopBtn_Pressed:(id)sender {
    [self.musicPlayer stop];
}

- (IBAction)previousBtn_Pressed:(id)sender{
    [self.musicPlayer skipToPreviousItem];
}

- (IBAction)nextBtn_Pressed:(id)sender {
    [self.musicPlayer skipToNextItem];
}


#pragma mark - MPMediaPickerController_Delegate
/**
 *  选择
 */
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{

    for (MPMediaItem *item in mediaItemCollection.items) {
        
        NSString *title = item.title;
        
        XZObjectLog(title);
    }
    
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  取消选择
 */
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
