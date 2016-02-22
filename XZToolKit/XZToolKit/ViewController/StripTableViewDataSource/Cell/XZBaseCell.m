//
//  XZBaseCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBaseCell.h"

@implementation XZBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        
    }
    return self;
}

+ (instancetype)cellAllocWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle{
    
    XZBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        
        cell = [[[self class] alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (instancetype)cellLoadXibWithTableView:(UITableView *)tableView{
    
    XZBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
