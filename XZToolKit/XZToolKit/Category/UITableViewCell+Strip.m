//
//  UITableViewCell+Strip.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UITableViewCell+Strip.h"

@implementation UITableViewCell (Strip)

+ (instancetype)cellAllocWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        
        cell = [[[self class] alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (instancetype)cellLoadXibWithTableView:(UITableView *)tableView{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
