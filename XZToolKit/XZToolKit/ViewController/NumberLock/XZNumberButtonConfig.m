//
//  XZNumberButtonConfig.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberButtonConfig.h"

@implementation XZNumberButtonConfig
- (id)init{
    
    self = [super init];
    if (self) {
        self.index = 0;
        self.itemBorderWidth = 1.0f;
        self.itemBorderColor = [UIColor redColor];
    }
    return self;
}
@end
