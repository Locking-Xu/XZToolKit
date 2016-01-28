//
//  XZCollectionKnowledgeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCollectionKnowledgeViewController.h"
#import "XZCollectionDemoViewController.h"
#import "UINavigationController+Common.h"

#define TitleArray @[@"Layout样式一",@"Layout样式二",@"Layout样式三"]

@interface XZCollectionKnowledgeViewController ()

@end

@implementation XZCollectionKnowledgeViewController

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
    
    XZCollectionDemoViewController *collectionViewDemoVc = [[XZCollectionDemoViewController alloc] init];
    
    collectionViewDemoVc.title = TitleArray[indexPath.row];
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    [self.navigationController pushViewController:collectionViewDemoVc animated:YES];
}

@end
