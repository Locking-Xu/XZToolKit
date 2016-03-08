//
//  XZLabelFlowCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowCell.h"
#import "XZUtils.h"

@implementation XZLabelFlowCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLab.clipsToBounds = YES;
    self.titleLab.layer.cornerRadius = 10.0f;
    self.titleLab.backgroundColor = [UIColor redColor];
}

- (CGSize)sizeForCell:(NSString *)title{
    //宽度加 heightForCell 为了两边圆角。
    _titleLab.text = title;
    
    CGSize size = [XZUtils stringAdaptive:title height:20.0f lineSpace:0 font:15 mode:NSLineBreakByCharWrapping];
    
    size.width += 20;
    
    return size;
}

@end
