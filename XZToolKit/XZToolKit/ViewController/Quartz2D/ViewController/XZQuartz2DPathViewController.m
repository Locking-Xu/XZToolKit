//
//  XZQuartz2DPathViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DPathViewController.h"
#import "XZQuartz2DPathView.h"
#import <Masonry/Masonry.h>

@interface XZQuartz2DPathViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) XZQuartz2DPathView *pathView;

@end

@implementation XZQuartz2DPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.pathView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setter && Getter
- (UISegmentedControl *)segmentedControl{
    WS(weakSelf);
    if (!_segmentedControl) {
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"圆弧"]];
        _segmentedControl.tintColor = RGBA(94, 105, 203, 1);
        [self.view addSubview:_segmentedControl];
        [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakSelf.view).offset(20);
            make.right.equalTo(weakSelf.view).offset(-20);
            make.top.equalTo(weakSelf.view).offset(20);
            make.height.mas_equalTo(@30);
        }];
        
    }
    return _segmentedControl;
}

- (XZQuartz2DPathView *)pathView{
    WS(weakSelf);
    if (!_pathView) {
        
        _pathView = [[XZQuartz2DPathView alloc] init];
        _pathView.type = ARC;
        [self.view addSubview:_pathView];
        [_pathView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.segmentedControl.mas_bottom).offset(20);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
    }
    return _pathView;
}
@end
