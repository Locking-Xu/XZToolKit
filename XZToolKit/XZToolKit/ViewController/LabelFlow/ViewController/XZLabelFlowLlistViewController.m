//
//  XZLabelFlowLlistViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowLlistViewController.h"
#import "XZLabelFlowOneViewController.h"
#import "UINavigationController+Common.h"
#import "XZLabelFlowTwoViewController.h"
#import "XZLabelFlowThreeViewController.h"


@interface XZLabelFlowLlistViewController (){

    NSArray *_titleArray;
}

@end

@implementation XZLabelFlowLlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleArray = @[@"样式一",@"样式二",@"样式三"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController setBackItemTitle:@"" viewController:self];
    switch (indexPath.row) {
        case 0:
        {
            XZLabelFlowOneViewController *labelFlowOneVc = [[XZLabelFlowOneViewController alloc] init];
            labelFlowOneVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:labelFlowOneVc animated:YES];
        }
            break;
        case 1:
        {
            XZLabelFlowTwoViewController *labelFlowTwoVc = [[XZLabelFlowTwoViewController alloc] initWithNibName:@"XZLabelFlowTwoViewController" bundle:[NSBundle mainBundle]];
            labelFlowTwoVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:labelFlowTwoVc animated:YES];
        }
            break;
        case 2:
        {
            XZLabelFlowThreeViewController *labelFlowThreeVc = [[XZLabelFlowThreeViewController alloc] init];
            labelFlowThreeVc.title = _titleArray[indexPath.row];
            [self.navigationController pushViewController:labelFlowThreeVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
