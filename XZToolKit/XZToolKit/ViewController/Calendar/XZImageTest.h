//
//  XZImageTest.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZImageTest : NSObject

+ (XZImageTest *)shareInstance;

- (UIImage *)getMonthImageWithDate:(NSDate *)date size:(CGSize)size;
@end
