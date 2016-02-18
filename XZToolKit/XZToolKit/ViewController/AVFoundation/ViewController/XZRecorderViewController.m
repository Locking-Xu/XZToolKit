//
//  XZRecorderViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/18.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZRecorderViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XZRecorderViewController ()<AVAudioRecorderDelegate>{
    
    
    __weak IBOutlet UIProgressView *_progressView;
}

/** 录音机*/
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
/** 定时器*/
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XZRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter & Getter
- (AVAudioRecorder *)audioRecorder{
    
    if (!_audioRecorder) {
        
        //获得存放地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"record.caf"]];
        
        //创建设置
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //设置录音格式
        [dic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        //设置录音采样率，8000是电话采样率，对于一般录音已经够了
        [dic setObject:@(8000) forKey:AVSampleRateKey];
        //设置通道,这里采用单声道
        [dic setObject:@(1) forKey:AVNumberOfChannelsKey];
        //每个采样点位数,分为8、16、24、32
        [dic setObject:@(8) forKey:AVLinearPCMBitDepthKey];
        //是否使用浮点数采样
        [dic setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
        
        //创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:dic error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        
        if (error) {
            NSLog(@"创建录音机失败");
            return nil;
        }
    }
    
    return _audioRecorder;
}

- (NSTimer *)timer{
    
    if(!_timer){
    
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changePowerProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - Private_Methods
- (void)changePowerProgress{
    //更新测量值
    [self.audioRecorder updateMeters];
    //取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat power = [self.audioRecorder averagePowerForChannel:0];
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [_progressView setProgress:progress];
}
#pragma mark - UIButton_Actions
- (IBAction)startBtn_Pressed:(id)sender {
    if (![self.audioRecorder isRecording]) {
        
        [self.audioRecorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}
- (IBAction)pauseBtn_Pressed:(id)sender {
    
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}
- (IBAction)resumeBtn_Pressed:(id)sender {
    
    if (![self.audioRecorder isRecording]) {
        
        [self.audioRecorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}
- (IBAction)stopBtn_Pressed:(id)sender {
    
    [self.audioRecorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    _progressView.progress = 0.0f;
}

#pragma mark - AVAudioRecorder_Delegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"录音完成");
}
@end
