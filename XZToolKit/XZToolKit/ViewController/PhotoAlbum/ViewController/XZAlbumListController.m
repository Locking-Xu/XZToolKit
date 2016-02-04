//
//  XZAlbumListController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/4.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAlbumListController.h"
#import "XZAlbumHelper.h"
#import "XZUtils.h"
#import "XZPhotoAlbumViewController.h"
#import "UINavigationController+Common.h"
#import "XZAlbumCell.h"

@interface XZAlbumListController (){
    
    NSMutableArray *_dataArray;
}

@end

@implementation XZAlbumListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 60.0f;
    
    [[XZAlbumHelper shareInstance] getAlbumGroupSuccessful:^(NSMutableArray *fileArray) {
        
        _dataArray = fileArray;
           
        [self.tableView reloadData];
        
    } fail:^{
       
        [XZUtils showAlertView:@"获取相册失败"];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView_DataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString *identifier = @"ALBUM_CELL";
    
    XZAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XZAlbumCell" owner:self options:0] lastObject];
    }
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    [cell setUpCellWithDic:dic];

    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZPhotoAlbumViewController *photoAlbumVc = [[XZPhotoAlbumViewController alloc] initWithNibName:@"XZPhotoAlbumViewController" bundle:[NSBundle mainBundle]];
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    if (DEVICE_VERSION >= 8.0)
        photoAlbumVc.groupID = dic[@"objectID"];
    else
        photoAlbumVc.groupUrl = dic[@"url"];

    photoAlbumVc.title = dic[@"name"];
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    [self.navigationController pushViewController:photoAlbumVc animated:YES];
}
@end
