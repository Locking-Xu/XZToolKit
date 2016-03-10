//
//  XZNumberCircle.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNumberCircle.h"
@interface XZNumberCircle(){

    XZNumberCircleConfig *_config;
}
@end
@implementation XZNumberCircle

- (instancetype)initWithConfig:(XZNumberCircleConfig *)config{
    
    self = [super init];
    if (self) {
        
        _config = config;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
