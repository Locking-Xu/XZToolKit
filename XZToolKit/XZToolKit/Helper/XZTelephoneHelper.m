//
//  XZTelephoneHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTelephoneHelper.h"
#import "AppDelegate.h"

@implementation XZTelephoneHelper{
    
    CallBlock _callBlock;
    CancelCallBlock _cancelCallBlock;
    NSDate *_callTime;
}

+ (instancetype)shareInstance{
    
    static XZTelephoneHelper *telephoneManager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        telephoneManager = [[XZTelephoneHelper alloc] init];
    });
    
    return telephoneManager;
}

#pragma mark-
#pragma mark- Private_Methods
- (void) callPhoneNumber:(NSString *)phoneNumber
                    call:(CallBlock)callBlock
                  cancel:(CancelCallBlock)cancelCallBlock
{
    
    //注册监听
    [self setNotifications];
    
    _callBlock = callBlock;
    _cancelCallBlock = cancelCallBlock;
    
    
    NSString *simplePhoneNumber =
    [[phoneNumber componentsSeparatedByCharactersInSet:
      [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    NSString *stringURL = [@"tel://" stringByAppendingString:simplePhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
    
}

/**
 *  注册监听
 */
- (void)setNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}


#pragma mark - Events
- (void)applicationWillResignActive:(NSNotification *)notification
{
    // save the time of the call
    
    _callTime = [NSDate date];
    
    if (_callTime != nil && _callBlock != nil) {
        
        _callBlock();
    }
    
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    //     now it's time to remove the observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //
    if (_cancelCallBlock != nil) {
        
        _cancelCallBlock(_callTime);
    }
    
    _callTime = nil;
}


@end
