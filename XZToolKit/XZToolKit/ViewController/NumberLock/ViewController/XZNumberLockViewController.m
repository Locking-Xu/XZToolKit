//
//  XZNumberLockViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberLockViewController.h"
#import "XZNumberLockView.h"
#import <Masonry/Masonry.h>
#import "XZNumberInfoView.h"
@interface XZNumberLockViewController ()
@property (nonatomic, strong) UILabel *alertLabel;
@property (nonatomic, strong) XZNumberInfoView *infoView;
@property (nonatomic, strong) XZNumberLockView *lockView;
@end

@implementation XZNumberLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.infoView.backgroundColor = [UIColor redColor];
    self.alertLabel.text = @"请输入密码";
    self.lockView.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UILabel *)alertLabel{
    WS(weakself);
    if (!_alertLabel) {
        
        _alertLabel = [[UILabel alloc] init];
        [self.view addSubview:_alertLabel];
        [_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.infoView.mas_bottom).offset(10);
            make.centerX.equalTo(weakself.view);
        }];
    }
    return _alertLabel;
}

- (XZNumberInfoView *)infoView{
    WS(weakself);
    if (!_infoView) {
       
        _infoView = [[XZNumberInfoView alloc] init];
        [self.view addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.view).offset(20);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.height.mas_equalTo(@20);
            
        }];
    }
    return _infoView;
}

- (XZNumberLockView *)lockView{
    WS(weakself);
    if (!_lockView) {
        _lockView = [[XZNumberLockView alloc] init];
        [self.view addSubview:_lockView];
        [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself.alertLabel.mas_bottom);
            make.left.equalTo(weakself.view);
            make.right.equalTo(weakself.view);
            make.bottom.equalTo(weakself.view);
        }];
    }
    return _lockView;
}
@end
