//
//  XZGPUImageViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/10.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImageViewController.h"
#import "UINavigationController+Common.h"
#import "XZGPUImagePhotoViewController.h"
#import "XZGPUImageVideoViewController.h"
#import "XZGPUImageImageViewController.h"
#import "XZGPUImageFilterOverlayViewController.h"
#import "XZGPUImageMovieViewController.h"

@interface XZGPUImageViewController (){

    NSArray *_titleArray;
}
@end

@implementation XZGPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _titleArray = @[@"滤镜拍照",@"滤镜摄像",@"图片渲染",@"滤镜叠加",@"视屏渲染"];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - TableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            XZGPUImagePhotoViewController *gpuImagePhotoVc = [[XZGPUImagePhotoViewController alloc] init];
            gpuImagePhotoVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:gpuImagePhotoVc animated:YES];
        }
            break;
        case 1:
        {
            XZGPUImageVideoViewController *gpuImageVideoVc = [[XZGPUImageVideoViewController alloc] init];
            gpuImageVideoVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:gpuImageVideoVc animated:YES];
        }
            break;
        case 2:
        {
            XZGPUImageImageViewController *gpuImageImageVc = [[XZGPUImageImageViewController alloc] init];
            gpuImageImageVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:gpuImageImageVc animated:YES];
        }
            break;
        case 3:
        {
            XZGPUImageFilterOverlayViewController *gpuImageFilterOverlayVc = [[XZGPUImageFilterOverlayViewController alloc] init];
            gpuImageFilterOverlayVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:gpuImageFilterOverlayVc animated:YES];
        }
            break;
        case 4:
        {
            XZGPUImageMovieViewController *gpuImageMoviewVc = [[XZGPUImageMovieViewController alloc] init];
            gpuImageMoviewVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:gpuImageMoviewVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
