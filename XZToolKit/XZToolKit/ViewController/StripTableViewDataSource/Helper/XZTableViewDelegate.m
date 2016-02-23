//
//  XZTableViewDelegate.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTableViewDelegate.h"

@implementation XZTableViewDelegate{
    
    TableViewSelectCellBlock _selectCellBlock;
    Class _cellClass;
    NSArray *_itemArray;
}

- (instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass selectCellBlock:(TableViewSelectCellBlock)selectCellBlock{
    self = [super init];
    if (self) {
        
        _itemArray = items;
        _cellClass = cellClass;
        _selectCellBlock = [selectCellBlock copy];
    }
    return self;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    id model = _itemArray[indexPath.row];
    _selectCellBlock(model,cell);
}

@end
