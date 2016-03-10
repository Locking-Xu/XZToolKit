//
//  XZNumberCircleConfig.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberCircleConfig.h"

@implementation XZNumberCircleConfig
- (id)init{
    
    self = [super init];
    if (self) {
        self.index = 0;
        self.itemBorderWidth = 1.0f;
        self.itemBorderColor = [UIColor redColor];
        self.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.itemHorizontalSpace = 20.0f;
        self.itemVerticalSpace = 20.0f;
    }
    return self;
}
@end
