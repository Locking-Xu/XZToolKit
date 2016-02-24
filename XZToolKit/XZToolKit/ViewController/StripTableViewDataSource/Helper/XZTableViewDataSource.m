//
//  XZTableViewDataSource.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTableViewDataSource.h"
#import "UITableViewCell+Strip.h"

@interface XZTableViewDataSource(){

    TableViewCellConfigureBlock _configureCellBlock;
    Class _cellClass;
    NSArray *_itemArray;
}

@end

@implementation XZTableViewDataSource

- (instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass configCellBlock:(TableViewCellConfigureBlock)configCellblock{
    
    self = [super init];
    if (self) {
        
        _itemArray = items;
        _cellClass = cellClass;
        _configureCellBlock = [configCellblock copy];
    }
    return self;
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[_cellClass class] cellAllocWithTableView:tableView style:UITableViewCellStyleDefault];
    id item = _itemArray[indexPath.row];
    _configureCellBlock(item,cell,indexPath);
    return cell;
}

@end
