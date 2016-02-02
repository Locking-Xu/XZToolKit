//
//  XZTableViewKnowledgeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTableViewKnowledgeViewController.h"
#import "XZCodeViewController.h"
#import "XZDemoViewController.h"
#import "UINavigationController+Common.h"

#define TitleArray @[@"TableView下划线左右间距",@"TableView不显示多余Cell",@"TableView索引"]

@interface XZTableViewKnowledgeViewController ()

@end

@implementation XZTableViewKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TableView相关知识";
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return TitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = TitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - TableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];

    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = TitleArray[indexPath.row];
    [self.navigationController pushViewController:codeVc animated:YES];
}


@end