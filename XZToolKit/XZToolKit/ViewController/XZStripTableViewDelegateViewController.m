//
//  XZStripTableViewDelegateViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZStripTableViewDelegateViewController.h"
#import <Masonry/Masonry.h>
#import "XZBaseModel.h"
#import "NSString+Format.h"
#import "XZTableViewDataSource.h"
#import "XZTestCell.h"

@interface XZStripTableViewDelegateViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XZTableViewDataSource *tableViewDataSource;
@end

@implementation XZStripTableViewDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor redColor];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<20; i++) {
        
        XZBaseModel *model = [[XZBaseModel alloc] init];
        model.title = [NSString stringFromInt:i];
        [array addObject:model];
    }
    
    TableViewCellConfigureBlock tableViewCellConfigure = ^(XZBaseModel *model,XZBaseCell *cell){
    
        XZTestCell *testCell = (XZTestCell *)cell;
        [testCell setUpCellWith:model];
    };
    
    //配置tableView数据源
    self.tableViewDataSource = [[XZTableViewDataSource alloc] initWithItems:array cellClass:[XZTestCell class] configCellBlock:tableViewCellConfigure];
    
    self.tableView.dataSource = self.tableViewDataSource;
    
    
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
