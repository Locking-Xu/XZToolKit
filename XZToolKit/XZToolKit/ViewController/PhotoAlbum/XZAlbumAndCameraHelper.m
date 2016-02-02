//
//  XZAlbumAndCameraHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/2.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAlbumAndCameraHelper.h"
#import "XZUtils.h"

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


@implementation XZAlbumAndCameraHelper

#pragma mark - About Authorization
/**
 *  获取献策权限
 *
 *  @return YES:获得权限 NO:未获得权限
 */
+ (void)getPermissionsSuccessful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
    
    if (DEVICE_VERSION >= 8.0) {
        
        [XZAlbumAndCameraHelper getPermissionsInIOS8Successful:success fail:fail];
    }else{
        
        [XZAlbumAndCameraHelper getPermissionsInIOS7Successful:success fail:fail];
    }
}

/**
 *  IOS8及以上版本系统获取相册权限
 *
 *  @param success 成功获取权限Block
 *  @param fail    没有获取权限Block
 */
+ (void)getPermissionsInIOS8Successful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
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
+ (void)getPermissionsInIOS7Successful:(authorizationSuccessful)success fail:(authorizationFail)fail{
    
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

#pragma mark - About Source
/**
 *  获取相册中的资源(在IOS7系统下)
 */
+ (void)getDataSourceInIOS7{
    
    //http://blog.csdn.net/july_sal/article/details/39433269
    
    NSMutableArray *array = [NSMutableArray array];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    
                    [array addObject:result];
                    XZIntLog(array.count);
                }
                
            }];

        }else{

        NSLog(@"Finish");
        }
        
    }
    failureBlock:^(NSError *error) {
                             
    }];
    
}

/**
 *  获取相册中的资源(在IOS8系统下)
 */
+ (PHFetchResult *)getDataSourceInIOS8{
    
    //http://blog.csdn.net/jeffasd/article/details/49680513
    
        
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    
    return result;
    
}

@end
