//
//  XZNumberButton.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberButton.h"

@implementation XZNumberButton

- (XZNumberButton *)initWithFram:(CGRect)frame config:(XZNumberButtonConfig *)config{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = config.itemBorderColor.CGColor;
        self.layer.borderWidth = config.itemBorderWidth;
    }
    return self;
}

@end
