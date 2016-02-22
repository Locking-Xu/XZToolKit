//
//  XZTestCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTestCell.h"

@implementation XZTestCell

- (void)setUpCellWith:(XZBaseModel *)model{
    
    self.textLabel.text = model.title;
}

@end
