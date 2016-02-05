//
//  XZAlbumAndCameraHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/2.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAlbumHelper.h"
#import "XZUtils.h"
#import "NSString+Format.h"

//拍照

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authStatus == AVAuthorizationStatusDenied) {//AVAuthorizationStatusDenied
//            RCSUIAlertView* alertView=[[RCSUIAlertView alloc] initWithTitle:NSInternational(@"General_AccessFailed") message:NSInternational(@"general_camerapemission") callBack:Nil cancelButtonTitle:NSInternational(@"General_Ok") otherButtonTitles:Nil];
//            [alertView show];
//            [alertView release];
//            return;
//        }
//    }


@interface XZAlbumHelper ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation XZAlbumHelper

+ (XZAlbumHelper *)shareInstance{
    
    static XZAlbumHelper *albumHelper = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        albumHelper = [[XZAlbumHelper alloc] init];
    });
    return albumHelper;
}

- (ALAssetsLibrary *)library{
    
    if (!_library) {
        
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

#pragma mark - About Authorization
/**
 *  获取献策权限
 *
 *  @return YES:获得权限 NO:未获得权限
 */
- (void)getAlbumPermissionsSuccessful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
    
    if (DEVICE_VERSION >= 8.0) {
        
        [self getPermissionsInIOS8Successful:success fail:fail];
    }else{
        
        [self getPermissionsInIOS7Successful:success fail:fail];
    }
}

/**
 *  IOS8及以上版本系统获取相册权限
 *
 *  @param success 成功获取权限Block
 *  @param fail    没有获取权限Block
 */
- (void)getPermissionsInIOS8Successful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
    //相册权限判断
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {
        //相册权限未开启
        
        fail(@"相册没有授权");
        
    }else if (status == PHAuthorizationStatusNotDetermined){
        //相册进行授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            //授权回调
            if (status == PHAuthorizationStatusAuthorized) {
                
                success(@"授权成功");
            }
            else{
                fail(@"相册没有授权");
            }
        }];
        
    }else if (status == PHAuthorizationStatusAuthorized){
        //相册已授权
        
        success(@"授权成功");
    }
}

/**
 *  IOS7系统获取相册权限
 *
 *  @param success 成功获取权限Block
 *  @param fail    没有获取权限Block
 */
- (void)getPermissionsInIOS7Successful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        //相册权限未开启
        
        fail(@"相册没有授权");
        
    }else if (status == ALAuthorizationStatusNotDetermined){
        
        fail(@"请去设置中心授权");
        
    }else if (status == ALAuthorizationStatusAuthorized){
        //相册已授权
        
        success(@"授权成功");
    }
}

#pragma mark - About GetGroup
/**
 *  获取相册Group
 *
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)getAlbumGroupSuccessful:(getGroupSuccessful)success fail:(getGroupFail)fail{
    
    if (DEVICE_VERSION >= 8.0) {

        [self getGroupInIOS8Successful:success fail:fail];

    }else{
    
        [self getGroupInIOS7Successful:success fail:fail];
    }
}


/**
 *  获取相册中的资源(在IOS7系统下)
 */
- (void)getGroupInIOS7Successful:(getGroupSuccessful)success fail:(getGroupFail)fail{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            
            NSURL *url = [group valueForProperty:ALAssetsGroupPropertyURL];
            NSNumber *type = [group valueForProperty:ALAssetsGroupPropertyType];
            NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
            NSString *objectID = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
            NSString *count = [NSString stringFromInt:[group numberOfAssets]];
            UIImage *posterImage = [UIImage imageWithCGImage:[group posterImage]];
            
            NSDictionary *dic = @{
                                  @"url":url,
                                  @"type":type,
                                  @"name":name,
                                  @"objectID":objectID,
                                  @"count":count,
                                  @"posterImage":posterImage,
                                  };
            [array addObject:dic];
            
        }else{
            
            success(array);
        }
        
        }
          failureBlock:^(NSError *error) {
              
              fail();
          }];
    
}

/**
 *  获取相册中的资源(在IOS8系统下)
 */
- (void)getGroupInIOS8Successful:(getGroupSuccessful)success fail:(getGroupFail)fail{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableArray *albumArray = [NSMutableArray array];
    
    //获得Camera Roll相册
    PHFetchResult *result1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    [albumArray addObject:result1.firstObject];
    
    //获得出Camera Roll之外的其他相册
    PHFetchResult *result2 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    
    for (PHAssetCollection *collection in result2) {
        
        [albumArray addObject:collection];
    }
    
    for (PHAssetCollection *collection in albumArray) {
        
        NSString *name = collection.localizedTitle;
        NSString *objectID = collection.localIdentifier;
        NSString *type = [NSString stringFromInt:collection.assetCollectionType];
        
        PHFetchResult *imageResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        
        NSUInteger count = imageResult.count;
        
        PHAsset *asset = (count == 0) ? [NSNull null] : imageResult.lastObject;
        
        NSDictionary *dic = @{
                              @"type":type,
                              @"name":name,
                              @"objectID":objectID,
                              @"count":[NSString stringFromInt:count],
                              @"asset":asset
                              };
        [array addObject:dic];
    }
    
    success(array);
}


#pragma mark - About GetAsset
/**
 *  获得Group的Asset
 *
 *  @param url     Group的Url
 *  @param success 成功Block
 *  @param fail    失败Block
 */

- (void)getAlbumAssetWithGroupUrl:(NSURL *)url identifier:(NSString *)identifier successful:(getAssetSuccessful)success fail:(getAssetFail)fail{

    if (DEVICE_VERSION >= 8.0) {

        [self getAlbumAssetInIOS8WithGroupID:identifier successful:success fail:fail];

    }else{
    
        [self getAlbumAssetInIOS7WithGroupUrl:url successful:success fail:fail];
    }
}

- (void)getAlbumAssetInIOS7WithGroupUrl:(NSURL *)url successful:(getAssetSuccessful)success fail:(getAssetFail)fail{
    
    if (!url) {
        
        fail(@"URL无效");
        
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.library groupForURL:url resultBlock:^(ALAssetsGroup *group) {
        
        if (group) {
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result)
                    [array addObject:result];
                
                if (index == group.numberOfAssets-1) {
            
                    *stop = YES;
                    
                    success(array);
                }
                    
            }];
            
            
        }else{
            
            fail(@"没有找到该相册");
        }
        
    } failureBlock:^(NSError *error) {
        
        fail(error.description);
    }];
}

- (void)getAlbumAssetInIOS8WithGroupID:(NSString *)identifier successful:(getAssetSuccessful)success fail:(getAssetFail)fail{
    
    if (!identifier) {
        
        fail(@"identifier无效");
        return;
    }
    
    PHFetchResult *collectionResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil];
    
    PHAssetCollection *collection = collectionResult.firstObject;
    
    if (!collection) {
        
        fail(@"没有找到该相册");
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    PHFetchResult *assstResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    
    [assstResult enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj)
            [array addObject:obj];
        
        if (idx == assstResult.count - 1)
            success(array);
    }];
}












#pragma mark - Save Source
/**
 *  保存图片到本地相册(IOS7及其以上)
 *
 *  @param image  需要保存的图片
 *  @param isReverse 是否逆序保存(即从最后一个开始添加)
 *  @param isReplace 是否替换当前位置的图片文件
 *  @param success 成功Block
 *  @param fail    失败Block
 */
- (void)saveImageToAblumWithImage:(UIImage *)image successful:(saveImageSuccessful)success fail:(saveImagefail)fail;{
    
    [self.library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
       
        if (error) {
            fail(error.description);
        }else{
            
            success(assetURL);
        }
        
    }];

}



@end
