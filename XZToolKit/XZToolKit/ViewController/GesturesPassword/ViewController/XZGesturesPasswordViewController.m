//
//  XZGesturesPasswordViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGesturesPasswordViewController.h"
#import "XZCircleInfoView.h"
#import "XZLockLabel.h"
#import <Masonry/Masonry.h>
#import "XZGesturesPasswordConfig.h"
#import "XZCircleLockView.h"

@interface XZGesturesPasswordViewController ()
@property (nonatomic, strong) XZLockLabel *lockLabel;
@property (nonatomic, strong) XZCircleInfoView *circleInfoView;
@property (nonatomic, strong) XZCircleLockView *circleLockView;
@end

@implementation XZGesturesPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(13,52,89,1);
    
    self.circleInfoView.backgroundColor = [UIColor clearColor];
    self.lockLabel.backgroundColor = [UIColor clearColor];
    [self.lockLabel showNormalMessage:TextPrepareToSet];
    self.circleLockView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (XZLockLabel *)lockLabel{
    WS(weakself);
    if (!_lockLabel) {
        _lockLabel = [[XZLockLabel alloc] init];
        [self.view addSubview:_lockLabel];
        [_lockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.top.equalTo(weakself.circleInfoView.mas_bottom).offset(15);
            make.height.mas_equalTo(@20);
        }];
        
    }
    return _lockLabel;
}

- (XZCircleInfoView *)circleInfoView{
    WS(weakself);
    if (!_circleInfoView) {
        
        _circleInfoView = [[XZCircleInfoView alloc] init];
        [self.view addSubview:_circleInfoView];
        [_circleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(weakself.view);
            make.top.equalTo(weakself.view).offset(30);
            make.height.mas_equalTo(@50);
            make.width.mas_equalTo(@50);
        }];
    }
    return _circleInfoView;
}

- (XZCircleLockView *)circleLockView{
    WS(weakself);
    if (!_circleLockView) {
        
        _circleLockView = [[XZCircleLockView alloc] init];
        _circleLockView.lockLabel = self.lockLabel;
        _circleLockView.circleInfoView = self.circleInfoView;
        [self.view addSubview:_circleLockView];
        [_circleLockView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.lockLabel.mas_bottom);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.view);
        }];
    }
    return _circleLockView;
}
@end
