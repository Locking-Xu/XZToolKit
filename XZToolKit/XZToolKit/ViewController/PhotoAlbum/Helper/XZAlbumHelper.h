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

//获取相册Group成功Block
typedef void(^getGroupSuccessful)(NSMutableArray *fileArray);
//获取相册Group成功Block
typedef void(^getGroupFail)(void);

//获取相册Asset成功Block
typedef void(^getAssetSuccessful)(NSMutableArray *fileArray);
//获取相册Asset成功Block
typedef void(^getAssetFail)(NSString *error);

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
 *  获取相册Group
 *
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)getAlbumGroupSuccessful:(getGroupSuccessful)success fail:(getGroupFail)fail;

/**
 *  获得Group的Asset
 *
 *  @param url     Group的Url(IOS7只能通过Url来获取Group)
 *  @param identifier Group的identifier(IOS7只能通过identifier来获取Group)
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)getAlbumAssetWithGroupUrl:(NSURL *)url identifier:(NSString *)identifier successful:(getAssetSuccessful)success fail:(getAssetFail)fail;


/**
 *  保存图片到本地相册(IOS7及其以上)
 *
 *  @param image  需要保存的图片
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)saveImageToAblumWithImage:(UIImage *)image successful:(saveImageSuccessful)success fail:(saveImagefail)fail;


@end
