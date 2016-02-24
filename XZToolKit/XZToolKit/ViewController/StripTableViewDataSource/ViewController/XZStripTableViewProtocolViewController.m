//
//  XZStripTableViewProtocolViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZStripTableViewProtocolViewController.h"
#import <Masonry/Masonry.h>
#import "XZBaseModel.h"
#import "NSString+Format.h"
#import "XZTableViewDataSource.h"
#import "XZTableViewDelegate.h"
#import "XZTestCell.h"

@interface XZStripTableViewProtocolViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XZTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) XZTableViewDelegate *tableViewDelegate;
@end

@implementation XZStripTableViewProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<20; i++) {
        
        XZBaseModel *model = [[XZBaseModel alloc] init];
        model.title = [NSString stringFromInt:i];
        [array addObject:model];
    }
    
    TableViewCellConfigureBlock tableViewCellConfigure = ^(XZBaseModel *model,UITableViewCell *cell,NSIndexPath *indexPath){
        
        XZTestCell *testCell = (XZTestCell *)cell;
        [testCell setUpCellWith:model];
    };
    
    TableViewSelectCellBlock tableViewCellSelect = ^(XZBaseModel *model,UITableViewCell *cell,NSIndexPath *indexPath){
        
        NSLog(@"%@",model.title);
    };
    
    //配置tableView数据源
    self.tableViewDataSource = [[XZTableViewDataSource alloc] initWithItems:array cellClass:[XZTestCell class] configCellBlock:tableViewCellConfigure];
    //配置tableView的代理
    self.tableViewDelegate = [[XZTableViewDelegate alloc] initWithItems:array cellClass:[XZTestCell class] selectCellBlock:tableViewCellSelect];
    
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.delegate = self.tableViewDelegate;
    // Do any additional setup after loading the view.
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
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakSelf.view);
        }];
    }
    return _tableView;
}

@end
