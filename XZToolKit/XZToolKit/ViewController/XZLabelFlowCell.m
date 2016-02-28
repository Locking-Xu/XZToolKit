//
//  XZLabelFlowCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowCell.h"

@implementation XZLabelFlowCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLab.clipsToBounds = YES;
    self.titleLab.layer.cornerRadius = 10.0f;
}

- (CGSize)sizeForCell:(NSString *)title{
    //宽度加 heightForCell 为了两边圆角。
    _titleLab.text = title;
    return CGSizeMake([_titleLab sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 20, 20);
}

@end
