//
//  XZShuffFigureViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZShuffFigureViewController.h"
#import "XZScrollView.h"

@interface XZShuffFigureViewController ()<XZScrollViewDelegate>
@property (nonatomic, strong) XZScrollView *scollView;
@end

@implementation XZShuffFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scollView.imageUrlArr = @[@"1",@"2",@"3",@"4",@"5"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (XZScrollView *)scollView{
    
    if (!_scollView) {
        
        _scollView = [[XZScrollView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT/2)];
        _scollView.delegate = self;
        [self.view addSubview:_scollView];
    }
    return _scollView;
}

#pragma mark - XZScrollView_Delegate
- (void)XZScrollView:(XZScrollView *)scrollView didSelectAtIndex:(NSUInteger)index{
    
    XZIntLog(index);
}
@end
