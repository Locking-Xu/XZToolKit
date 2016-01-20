//
//  XZTelephoneHelper.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallBlock)();
typedef void (^CancelCallBlock)(NSDate *callTime);
typedef void(^FailBlock)(void);

@interface XZTelephoneHelper : NSObject

+ (instancetype) shareInstance;

/**
 *  打电话
 *
 *  @param phoneNumber     号码
 *  @param callBlock       开始打电话
 *  @param cancelCallBlock 电话结束
 *  @param failBlock       打电话失败（号码非法）
 */
- (void) callPhoneNumber:(NSString *)phoneNumber
                    call:(CallBlock)callBlock
                  cancel:(CancelCallBlock)cancelCallBlock;

@end
