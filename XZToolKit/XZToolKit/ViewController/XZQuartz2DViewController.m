//
//  XZQuartz2DViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DViewController.h"
#import "XZQuartz2DView.h"
#import <Masonry/Masonry.h>
#import "XZTableViewDataSource.h"

#import "XZBaseModel.h"
#import "XZTableViewDelegate.h"
#import "XZQuartz2DBasicViewController.h"
#import "UINavigationController+Common.h"

@interface XZQuartz2DViewController ()

@property (nonatomic, strong) XZTableViewDataSource *tableViewDataSource;
@property (nonatomic, copy) TableViewCellConfigureBlock tableViewCellConfigureBlock;

@property (nonatomic, strong) XZTableViewDelegate *tableViewDelegate;
@property (nonatomic, copy) TableViewSelectCellBlock tableViewCellSelectBlock;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation XZQuartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[@"绘制几何图形",@"点线模式"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *title in titleArray) {
        
        XZBaseModel *model = [[XZBaseModel alloc] init];
        model.title = title;
        [array addObject:model];
    }
    
    //配置tableView数据源
    self.tableViewDataSource = [[XZTableViewDataSource alloc] initWithItems:array
                                                                  cellClass:[UITableViewCell class]
                                                            configCellBlock:self.tableViewCellConfigureBlock];
    self.tableViewDelegate = [[XZTableViewDelegate alloc] initWithItems:array
                                                              cellClass:[UITableViewCell class] selectCellBlock:self.tableViewCellSelectBlock];
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.delegate = self.tableViewDelegate;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UITableView *)tableView{
    WS(weakSelf);
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(weakSelf.view);
        }];
        
    }
    return _tableView;
}

- (TableViewCellConfigureBlock)tableViewCellConfigureBlock{

    if (!_tableViewCellConfigureBlock) {
        _tableViewCellConfigureBlock = ^(XZBaseModel *model,UITableViewCell *cell){
    
            UITableViewCell *testCell = (UITableViewCell *)cell;
            testCell.textLabel.text = model.title;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        };
    }
    return _tableViewCellConfigureBlock;
}

- (TableViewSelectCellBlock)tableViewCellSelectBlock{
    WS(weakSelf);
    if (!_tableViewCellSelectBlock) {
        _tableViewCellSelectBlock = ^(XZBaseModel *model,UITableViewCell *cell){
            
            XZQuartz2DBasicViewController *quartz2DBasicVc = [[XZQuartz2DBasicViewController alloc] init];
            quartz2DBasicVc.title = @"绘制几何图形";
            [weakSelf.navigationController setBackItemTitle:@"" viewController:weakSelf];
            [weakSelf.navigationController pushViewController:quartz2DBasicVc animated:YES];
        };
    }
    return _tableViewCellSelectBlock;
}
@end
