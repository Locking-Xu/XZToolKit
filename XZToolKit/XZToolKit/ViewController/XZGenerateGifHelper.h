//
//  XZGenerateGifHelper.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompleteBlock)(NSURL *url);

@interface XZGenerateGifHelper : NSObject

- (void)generateGifFromUrl:(NSURL *)url loopCount:(NSInteger)loopCount FPS:(NSInteger)fps completeBlock:(CompleteBlock)completeBlock;

@end
