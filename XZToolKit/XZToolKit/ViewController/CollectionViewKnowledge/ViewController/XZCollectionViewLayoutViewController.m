//
//  XZCollectionViewLayoutViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/2.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCollectionViewLayoutViewController.h"
#import "XZCollectionDemoViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"

#define TitleArray @[@"UICollectionViewLayout",@"Layout样式一",@"Layout样式二",@"Layout样式三"]

@interface XZCollectionViewLayoutViewController ()

@end

@implementation XZCollectionViewLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return TitleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"MY_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = TitleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    if (indexPath.row == 0) {
        
        XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
        codeVc.knowledgeTitle = TitleArray[indexPath.row];
        [self.navigationController pushViewController:codeVc animated:YES];
        
        return;
    }
    
    XZCollectionDemoViewController *collectionViewDemoVc = [[XZCollectionDemoViewController alloc] init];
    
    collectionViewDemoVc.title = TitleArray[indexPath.row];

    [self.navigationController pushViewController:collectionViewDemoVc animated:YES];
}

@end
