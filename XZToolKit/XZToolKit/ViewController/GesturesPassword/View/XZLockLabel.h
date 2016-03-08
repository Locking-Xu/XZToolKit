//
//  XZLockLabel.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZLockLabel : UILabel
/**
 *  普通提示信息
 *
 *  @param message 提示信息
 */
- (void)showNormalMessage:(NSString *)message;

/**
 *  警告信息
 *
 *  @param message 提示信息
 */
- (void)showWarningMessage:(NSString *)message;

@end
