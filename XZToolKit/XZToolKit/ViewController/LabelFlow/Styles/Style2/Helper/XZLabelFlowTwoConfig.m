//
//  XZLabelFlowTwoConfig.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowTwoConfig.h"

@implementation XZLabelFlowTwoConfig
+ (XZLabelFlowTwoConfig *)shareInstance{
    
    static XZLabelFlowTwoConfig *labelFlowConfig =nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        labelFlowConfig =[[XZLabelFlowTwoConfig alloc] init];
    });
    return labelFlowConfig;
}

- (id)init{
    
    self = [super init];
    if (self) {
        
        self.contentInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        self.itemSpace = 5.0;
        self.lineSpace = 5.0;
        self.textMargin = 10.0f;
        self.textFont = 15.0f;
        self.textHeight = 20.0f;
    }
    return self;
}
@end
