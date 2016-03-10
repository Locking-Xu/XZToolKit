
//
//  XZLabelFlowThreeConfig.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowThreeConfig.h"

@implementation XZLabelFlowThreeConfig
- (id)init{
    
    self = [super init];
    if (self) {
        self.lineType = SingleLine;
        self.titleArray = @[];
        self.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.itemSpace = 5.0f;
        self.itemTextSpace = 5.0f;
        self.itemHeigth = 20.0f;
        self.itemTextFont = 15.0f;
        self.itemTextColor = [UIColor blackColor];
        self.itemRadius = 2.0f;
        self.itemBorderColor = [UIColor yellowColor];
        self.itemBorderWidth = 1.0f;
        self.itemBackgroundColor = [UIColor whiteColor];
        self.lineSpace = 5.0f;
    }
    return self;
}
@end
