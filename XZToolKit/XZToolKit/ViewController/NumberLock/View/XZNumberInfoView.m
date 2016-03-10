//
//  XZNumberInfoView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberInfoView.h"
#import "XZNumberCircle.h"

@implementation XZNumberInfoView
- (id)init{
    
    self = [super init];
    if (self) {
        [self addCircle];
    }
    return self;
}

- (void)addCircle{

    XZNumberCircleConfig *config = [[XZNumberCircleConfig alloc] init];
    for (NSInteger index = 0; index < 10; index ++) {
        
        XZNumberCircle *circle = [[XZNumberCircle alloc] initWithConfig:config];
        
        circle.tag = index;
        
        [self addSubview:circle];
        
    }
}

- (void)layoutSubviews{
    
    
}
@end
