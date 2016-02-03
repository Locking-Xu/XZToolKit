//
//  XZAlbumAndCameraHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/2.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAlbumHelper.h"
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


@implementation XZAlbumHelper{
    
    ALAssetsLibrary *_library;
}

+ (XZAlbumHelper *)shareInstance{
    
    static XZAlbumHelper *albumHelper = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        albumHelper = [[XZAlbumHelper alloc] init];
    });
    return albumHelper;
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

#pragma mark - About GetSource

- (void)getAlbumSourceSuccessful:(getSourceSuccessful)success fail:(getSourceFail)fail{
    
    if (DEVICE_VERSION >= 8.0) {

        [self getDataSourceInIOS8Successful:success fail:fail];

    }else{
    
    [self getDataSourceInIOS7Successful:success fail:fail];
    }
}


/**
 *  获取相册中的资源(在IOS7系统下)
 */
- (void)getDataSourceInIOS7Successful:(getSourceSuccessful)success fail:(getSourceFail)fail{
    
    NSMutableArray *array = [NSMutableArray array];
    
    _library = [[ALAssetsLibrary alloc] init];
    
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

        if (group) {
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    
                    [array addObject:result];
                }
                
            }];
            
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
- (PHFetchResult *)getDataSourceInIOS8Successful:(getSourceSuccessful)success fail:(getSourceFail)fail{
    
    PHAsset *asset = [[PHAsset alloc] init];
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    
    return result;
    
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
    
    if (!_library) {
        
        _library = [[ALAssetsLibrary alloc] init];
    }
    
    [_library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
       
        if (error) {
            fail(error.description);
        }else{
            
            success(assetURL);
        }
        
    }];

}



@end
