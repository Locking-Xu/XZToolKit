//
//  UIImage+File.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/6.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , Type) {

    PNG,
    JPG
};

@interface UIImage (File)
/**
 *  保存图片
 *
 *  @param path 保存路径
 *  @param type 保存类型
 */
- (void)imageSaveToPath:(NSString *)path type:(Type)type;
@end
