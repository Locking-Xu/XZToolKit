//
//  XZQuartz2DViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DViewController.h"
#import <Masonry/Masonry.h>
#import "XZTableViewDataSource.h"

#import "XZBaseModel.h"
#import "XZTableViewDelegate.h"
#import "XZQuartz2DBasicViewController.h"
#import "UINavigationController+Common.h"
#import "XZQuartz2DLineDashViewController.h"
#import "XZQuartz2DTextViewController.h"
#import "XZQuartz2DShadowViewController.h"
#import "XZQuartz2DPathViewController.h"
#import "XZQuartz2DPolygonViewController.h"
#import "XZQuartz2DDrawImageViewController.h"
#import "XZQuartz2DDrawBoardViewController.h"

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
    
    NSArray *titleArray = @[@"绘制几何图形",@"点线模式",@"绘制文本",@"绘制阴影",@"绘制路径",@"绘制多边形",@"绘制图片",@"绘图板"];
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
        _tableViewCellConfigureBlock = ^(XZBaseModel *model,UITableViewCell *cell,NSIndexPath *indexPath){
    
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
        _tableViewCellSelectBlock = ^(XZBaseModel *model,UITableViewCell *cell,NSIndexPath *indexPath){
            [weakSelf.navigationController setBackItemTitle:@"" viewController:weakSelf];
            switch (indexPath.row) {
                case 0:
                {
                    XZQuartz2DBasicViewController *quartz2DBasicVc = [[XZQuartz2DBasicViewController alloc] init];
                    quartz2DBasicVc.title = @"绘制几何图形";
                    [weakSelf.navigationController pushViewController:quartz2DBasicVc animated:YES];
                }
                    break;
                case 1:
                {
                    XZQuartz2DLineDashViewController *quartz2DLineDash = [[XZQuartz2DLineDashViewController alloc] init];
                    quartz2DLineDash.title = @"点线模式";
                    [weakSelf.navigationController pushViewController:quartz2DLineDash animated:YES];
                    
                }
                    break;
                case 2:
                {
                    XZQuartz2DTextViewController *quartz2DTextVc = [[XZQuartz2DTextViewController alloc] init];
                    quartz2DTextVc.title = @"绘制文本";
                    [weakSelf.navigationController pushViewController:quartz2DTextVc animated:YES];
                }
                    break;
                case 3:
                {
                    XZQuartz2DShadowViewController *quartz2DShadowVc = [[XZQuartz2DShadowViewController alloc] init];
                    quartz2DShadowVc.title = @"绘制阴影";
                    [weakSelf.navigationController pushViewController:quartz2DShadowVc animated:YES];
                }
                    break;
                case 4:
                {
                    XZQuartz2DPathViewController *quartz2DPathVc = [[XZQuartz2DPathViewController alloc] init];
                    quartz2DPathVc.title = @"绘制路径";
                    [weakSelf.navigationController pushViewController:quartz2DPathVc animated:YES];
                }
                    break;
                case 5:
                {
                    XZQuartz2DPolygonViewController *quartz2DPolygonVc = [[XZQuartz2DPolygonViewController alloc] init];
                    quartz2DPolygonVc.title = @"绘制多边形";
                    [weakSelf.navigationController pushViewController:quartz2DPolygonVc animated:YES];
                }
                    break;
                case 6:
                {
                    XZQuartz2DDrawImageViewController *quartz2DDrawImageVc = [[XZQuartz2DDrawImageViewController alloc] init];
                    quartz2DDrawImageVc.title = @"绘制图片";
                    [weakSelf.navigationController pushViewController:quartz2DDrawImageVc animated:YES];
                }
                    break;
                case 7:
                {
                    XZQuartz2DDrawBoardViewController *quartz2DDrawBoardVc = [[XZQuartz2DDrawBoardViewController alloc] initWithNibName:NSStringFromClass([XZQuartz2DDrawBoardViewController class]) bundle:[NSBundle mainBundle]];
                    quartz2DDrawBoardVc.title = @"绘图板";
                    [weakSelf.navigationController pushViewController:quartz2DDrawBoardVc animated:YES];
                }
                    break;
                default:
                    break;
            }

        };
    }
    return _tableViewCellSelectBlock;
}
@end
