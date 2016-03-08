//
//  XZLockLabel.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLockLabel.h"
#import "XZGesturesPasswordConfig.h"
#import "CALayer+Animation.h"

@implementation XZLockLabel

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:14.0f];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

/**
 *  普通提示信息
 *
 *  @param message 提示信息
 */
- (void)showNormalMessage:(NSString *)message{
    
    self.text = message;
    self.textColor = TextColorNotmalColor;
}

/**
 *  警告信息
 *
 *  @param message 提示信息
 */
- (void)showWarningMessage:(NSString *)message{
    
    self.text = message;
    self.textColor = TextColorWarningColor;
    [self.layer shakeWithDirection:Horizontal];
}
@end
