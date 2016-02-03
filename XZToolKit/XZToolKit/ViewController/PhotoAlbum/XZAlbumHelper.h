//
//  XZAlbumAndCameraHelper.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/2.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

//获取权限成功Block
typedef void(^authorizationSuccessful)(NSString *message);
//获取权限失败Block
typedef void(^authorizationFail)(NSString *message);

//获取相册文件成功Block
typedef void(^getSourceSuccessful)(NSMutableArray *fileArray);
//获取相册文件成功Block
typedef void(^getSourceFail)(void);

//保存图片相册成功Block
typedef void(^saveImageSuccessful)(NSURL *url);
//保存图片相册失败Block
typedef void(^saveImagefail)(NSString *error);


@interface XZAlbumHelper : NSObject

+ (XZAlbumHelper *)shareInstance;

/**
 *  获取相册权限
 *
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)getAlbumPermissionsSuccessful:(authorizationSuccessful)success fail:(authorizationFail)fail;

/**
 *  获取相册资源
 *
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)getAlbumSourceSuccessful:(getSourceSuccessful)success fail:(getSourceFail)fail;

/**
 *  保存图片到本地相册(IOS7及其以上)
 *
 *  @param image  需要保存的图片
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)saveImageToAblumWithImage:(UIImage *)image successful:(saveImageSuccessful)success fail:(saveImagefail)fail;


@end
