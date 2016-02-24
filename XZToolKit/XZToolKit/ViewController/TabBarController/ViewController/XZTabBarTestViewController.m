//
//  XZTabBarTestViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTabBarTestViewController.h"
#import "XZTableViewDataSource.h"
#import "XZTableViewDelegate.h"
#import "XZBaseModel.h"
#import "XZStandardTabBarController.h"
#import "XZTestOneViewController.h"
#import "XZTestTwoViewController.h"
#import "XZTestThreeViewController.h"
#import "XZCustomTabBarController.h"


@interface XZTabBarTestViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XZTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) XZTableViewDelegate *tableViewDelegate;
@end

@implementation XZTabBarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[@"标准TabBar",@"自定义TabBar"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<titleArray.count; i++) {
        
        XZBaseModel *model = [[XZBaseModel alloc] init];
        model.title = titleArray[i];
        [array addObject:model];
    }
    
    self.tableViewDataSource = [[XZTableViewDataSource alloc] initWithItems:array cellClass:[UITableViewCell class] configCellBlock:^(XZBaseModel *model, UITableViewCell *cell, NSIndexPath *indexPath) {
        
        cell.textLabel.text = model.title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    
    self.tableViewDelegate = [[XZTableViewDelegate alloc] initWithItems:array cellClass:[UITableViewCell class] selectCellBlock:^(XZBaseModel *model, UITableViewCell *cell, NSIndexPath *indexPath) {
        
        switch (indexPath.row) {
            case 0:
                [self setUpStandardTabBar];
                break;
            case 1:
                [self setUpCustomTabBar];
                break;
            default:
                break;
        }
    }];
    
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.delegate = self.tableViewDelegate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - Private_Methods
- (void)setUpStandardTabBar{

    XZTestOneViewController *oneVc = [[XZTestOneViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:oneVc];
    
    XZTestTwoViewController *twoVc = [[XZTestTwoViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:twoVc];
    
    XZTestThreeViewController *threeVc = [[XZTestThreeViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:threeVc];
    
    XZStandardTabBarController *standardTabBarVc = [XZStandardTabBarController shareInstance];
    
    [standardTabBarVc setViewControllers:@[nav1,nav2,nav3]];
    
    standardTabBarVc.items = @[@{
                         @"title":@"分布",
                         @"image":@"tabbar1_unselect"
                         },
                     @{
                         @"title":@"评估",
                         @"image":@"tabbar2_unselect"
                         },
                     @{
                         @"title":@"车行",
                         @"image":@"tabbar3_unselect"
                         },

                     ];
    standardTabBarVc.tabbarBackgroundColor = [UIColor whiteColor];
    standardTabBarVc.itemSelectColor = [UIColor colorWithRed:97/255.f green:173/255.f blue:219/255.f alpha:1];
    [standardTabBarVc setTabbar];

    [self.navigationController pushViewController:standardTabBarVc animated:YES];
}

- (void)setUpCustomTabBar{
    
    XZTestOneViewController *oneVc = [[XZTestOneViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:oneVc];
    
    XZTestTwoViewController *twoVc = [[XZTestTwoViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:twoVc];
    
    XZCustomTabBarController *customTabBarVc = [XZCustomTabBarController shareInstance];
    
    //需先设置UITabbarItem的属性
    NSDictionary *dic1 = @{
                           XZTabBarItemTitle:@"分布",
                           XZTabBarItemImage:@"tabbar1_unselect",
                           XZTabBarItemSelectImage:@"tabbar1_select"
                           };
    NSDictionary *dic2 = @{
                           XZTabBarItemTitle:@"评估",
                           XZTabBarItemImage:@"tabbar2_unselect",
                           XZTabBarItemSelectImage:@"tabbar2_select"
                           };
    customTabBarVc.itemsAttributes = @[dic1,dic2];
    customTabBarVc.viewControllers = @[nav1,nav2];
    customTabBarVc.customTabbar.itemsCounts = 2;
    
    [self.navigationController pushViewController:customTabBarVc animated:YES];
}
@end
