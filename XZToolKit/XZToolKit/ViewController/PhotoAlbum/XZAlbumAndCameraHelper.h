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

typedef void(^authorizationSuccessful)(NSString *message);
typedef void(^authorizationFail)(NSString *message);

@interface XZAlbumAndCameraHelper : NSObject

+ (void)getPermissionsSuccessful:(authorizationSuccessful)success fail:(authorizationFail)fail;

+ (PHFetchResult *)getDataSourceInIOS8;

@end
