//
//  XZSoundEffectViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/14.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZSoundEffectViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XZSoundEffectViewController ()

@end

@implementation XZSoundEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemBookmarks delegate:self action:@selector(detailBtn_Pressed)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}


#pragma mark - UIButtons_Action
- (void)detailBtn_Pressed{

    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = self.title;
    [self.navigationController pushViewController:codeVc animated:YES];
}

- (IBAction)playBtn_Pressed:(id)sender {
    
    //获取资源URL
    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //获得系统声音的ID
    SystemSoundID soundID =0;
    
    //将音效加入到系统音频服务中并返回一个长整型的ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //注册一个播放结束回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    //播放音效
    AudioServicesPlaySystemSound(soundID);
    //播放音效并震动
//    AudioServicesPlayAlertSound(soundID);
}




@end
