//
//  XZGraphicsTransformViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/6.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGraphicsTransformViewController.h"
#import "XZGraphicsTransformView.h"
#import "XZSnowView.h"
#import <Masonry/Masonry.h>
#import "XZGraphicsTransformDetailViewController.h"
#import "UINavigationController+Common.h"

@interface XZGraphicsTransformViewController ()<UITableViewDataSource, UITableViewDelegate>{

    NSArray *_titleArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XZGraphicsTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArray = @[@"坐标变换",@"坐标变换与路径",@"矩阵变换",@"叠加模式"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZGraphicsTransformDetailViewController *graphicsTransformDetailVc = [[XZGraphicsTransformDetailViewController alloc] init];
    graphicsTransformDetailVc.title = _titleArray[indexPath.row];
    [self.navigationController pushViewController:graphicsTransformDetailVc animated:YES];
}

@end
