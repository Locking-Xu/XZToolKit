//
//  UIImage+File.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/6.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIImage+File.h"

@implementation UIImage (File)
/**
 *  保存图片
 *
 *  @param path 保存路径
 *  @param type 保存类型
 */
- (void)imageSaveToPath:(NSString *)path type:(Type)type{

    switch (type) {
        case PNG:
            [UIImagePNGRepresentation(self) writeToFile:path atomically:YES];
            break;
        case JPG:
            //1.0图片的压缩比例
            [UIImageJPEGRepresentation(self, 1.0) writeToFile:path atomically:YES];
            break;
        default:
            break;
    }
}
@end
