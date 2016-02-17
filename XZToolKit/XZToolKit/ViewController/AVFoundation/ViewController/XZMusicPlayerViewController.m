//
//  XZMusicPlayerViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/14.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMusicPlayerViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XZMusicPlayerViewController ()<AVAudioPlayerDelegate>{

    __weak IBOutlet UIButton *_playBtn;
    __weak IBOutlet UIProgressView *_progressView;
    
}

@property (nonatomic, strong) AVAudioPlayer *audioPalyer;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation XZMusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemBookmarks delegate:self action:@selector(detailBtn_Pressed)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVAudioPlayer *)audioPalyer{

    if (!_audioPalyer) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"遇见" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        //初始化播放器
        _audioPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPalyer.numberOfLoops = 1;
        _audioPalyer.delegate =self;
        _audioPalyer.volume = 1.0f;
        [_audioPalyer prepareToPlay];
        
        if (error) {
            
            NSLog(@"初始化失败");
        }
        
        //设置后台播放模式
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
        
        //监听耳机拔出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
        
    }
    return _audioPalyer;
}

//输出终端变化
- (void)routeChange:(NSNotification *)notification{

    NSDictionary *dic = notification.userInfo;
    
    NSInteger changeReason = [dic[AVAudioSessionRouteChangeReasonKey] integerValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            //暂停
            [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
            [self.audioPalyer pause];
            self.timer.fireDate = [NSDate distantFuture];
        }
    }
}

- (NSTimer *)timer{

    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgressView) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)updateProgressView{

    float progress = self.audioPalyer.currentTime/self.audioPalyer.duration;
    
    [_progressView setProgress:progress];
    
}

#pragma mark UIButtons_Action
- (void)detailBtn_Pressed{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = self.title;
    [self.navigationController pushViewController:codeVc animated:YES];
}

- (IBAction)playBtn_Pressed:(UIButton *)sender {
    
    if ([self.audioPalyer isPlaying]) {
        //暂停
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [self.audioPalyer pause];
        self.timer.fireDate = [NSDate distantFuture];
        
    }else{
        //播放
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self.audioPalyer play];
        self.timer.fireDate = [NSDate distantPast];
    }
    
}

#pragma mark AVAudioPalyer_Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    NSLog(@"播放结束");
}
@end
