//
//  XZAVPlayerViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/18.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAVPlayerViewController.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Frame.h"

@interface XZAVPlayerViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *playBtn;/** 播放器对象*/
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;

@end

@implementation XZAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.playBtn.backgroundColor = [UIColor redColor];
    self.oneBtn.backgroundColor = [UIColor greenColor];
    self.twoBtn.backgroundColor = [UIColor greenColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self createPlayerLayer];
    [self.player play];

}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    
    self.player = nil;
}
#pragma mark - Setter & Getter
- (UIView *)contentView{

    if (!_contentView) {
        
        _contentView = ({
            
            UIView *view = [[UIView alloc] init];
            
            [self.view addSubview:view];
            WS(weakSelf);
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.view.mas_top);
                make.left.equalTo(weakSelf.view.mas_left);
                make.right.equalTo(weakSelf.view.mas_right);
                make.height.equalTo(weakSelf.view).multipliedBy(0.4);
            }];
            
            view;
        });
    }
    return _contentView;
}

- (UIButton *)playBtn{

    if (!_playBtn) {
     
        _playBtn = ({
            
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            WS(weakSelf);
           [button mas_makeConstraints:^(MASConstraintMaker *make) {
              
               make.top.equalTo(weakSelf.contentView.mas_bottom);
               make.left.equalTo(weakSelf.view);
               make.height.mas_equalTo(@50);
               make.width.mas_equalTo(@50);
           }];
            [button addTarget:self action:@selector(playBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"暂停" forState:UIControlStateNormal];
            button;
        });
    }
    return _playBtn;
}

- (UIProgressView *)progressView{

    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc] init];
        
        [_progressView setProgress:0.0];
        [self.view addSubview:_progressView];
        WS(weakSelf);
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakSelf.playBtn.mas_right).offset(20);
            make.right.equalTo(weakSelf.view).offset(-20);
            make.centerY.equalTo(weakSelf.playBtn.mas_centerY);
        }];
    }
    return _progressView;
}

- (AVPlayer *)player{

    if (!_player) {
        
        AVPlayerItem *item = [self getPlayerItemWithName:@"1"];
        _player = [AVPlayer playerWithPlayerItem:item];
        [self updateProgressView];
        [self addObserverToPlayerItem:item];
    }
    
    return _player;
}

- (UIButton *)oneBtn{
    
    if (!_oneBtn) {
        
        _oneBtn = ({
        
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            WS(weakSelf);
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.playBtn.mas_bottom).offset(20);
                make.height.equalTo(weakSelf.playBtn.mas_height);
                make.width.equalTo(weakSelf.playBtn.mas_width);
            }];
            [button setTitle:@"1" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(oneBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _oneBtn;
}

- (UIButton *)twoBtn{

    if (!_twoBtn) {
        
        _twoBtn = ({
        
            UIButton *button = [[UIButton alloc] init];
            [self.view addSubview:button];
            WS(weakSelf);
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(weakSelf.oneBtn.mas_top);
                make.left.equalTo(weakSelf.oneBtn.mas_right).offset(20);
                make.width.equalTo(weakSelf.oneBtn.mas_width);
                make.height.equalTo(weakSelf.oneBtn.mas_height);
            }];
            [button setTitle:@"2" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(twoBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _twoBtn;
}
#pragma mark - Private_Methods
/**
 *  创建播放层
 */
- (void)createPlayerLayer{
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.contentView.bounds;
    playerLayer.videoGravity=AVLayerVideoGravityResize;//视频填充模式
    [self.contentView.layer addSublayer:playerLayer];
}

/**
 *  获得资源对象
 */
- (AVPlayerItem *)getPlayerItemWithName:(NSString *)name{

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    path =[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    return item;
}

/**
 *  播放结束
 */
- (void)playFinish{
    
    NSLog(@"播放结束");
}

/**
 *  更新播放进度
 */
- (void)updateProgressView{

    AVPlayerItem *item = self.player.currentItem;
    
    WS(weakself);
    //每一秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
       
        CGFloat current = CMTimeGetSeconds(time);
        CGFloat total = CMTimeGetSeconds([item duration]);
        NSLog(@"当前已经播放%.2fs.",current);
        if (current) {
            [weakself.progressView setProgress:(current/total) animated:YES];
        }

    }];
}

/**
 *  给AVPlayerItem添加监控
 *
 *  @param item AVPlayerItem对象
 */
- (void)addObserverToPlayerItem:(AVPlayerItem *)item{

    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)item{
    [item removeObserver:self forKeyPath:@"status"];
    [item removeObserver:self forKeyPath:@"loadedTimeRanges"];

}

/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);

    }
}

#pragma mark - UIButton_Actions
- (void)playBtn_Pressed:(UIButton *)sender{
    
    if (self.player.rate == 0) {
        
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self.player play];
        
    }else if(self.player.rate == 1){
        
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [self.player pause];
    }
    
}

- (void)oneBtn_Pressed:(UIButton *)sender{

    [self removeObserverFromPlayerItem:self.player.currentItem];
    AVPlayerItem *item = [self getPlayerItemWithName:@"1"];
    [self addObserverToPlayerItem:item];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}

- (void)twoBtn_Pressed:(UIButton *)sender{
    
    [self removeObserverFromPlayerItem:self.player.currentItem];
    AVPlayerItem *item = [self getPlayerItemWithName:@"2"];
    [self addObserverToPlayerItem:item];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
}
@end
