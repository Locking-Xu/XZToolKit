//
//  XZBlogListViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBlogListViewController.h"
#import "XZBlogCell.h"
#import "XZBlogWebViewController.h"
#import "UINavigationController+Common.h"

@interface XZBlogListViewController (){
    
    NSArray *_array;
}

@end

@implementation XZBlogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setBackItemTitle:@"" viewController:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:self.listName ofType:@"plist"];
    _array = [NSArray arrayWithContentsOfFile:path];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _array[indexPath.row];
    CGFloat height = [XZBlogCell heightForCellWithTitle:dic[@"title"]];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"XZBlogCell";
    XZBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XZBlogCell" owner:self options:nil] lastObject];
    }
    
    [cell setContentWithDic:_array[indexPath.row]];

    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _array[indexPath.row];
    XZBlogWebViewController *blogWebvc = [[XZBlogWebViewController alloc] init];
    blogWebvc.title = dic[@"title"];
    blogWebvc.url = dic[@"url"];
    [self.navigationController pushViewController:blogWebvc animated:YES];
}
@end
