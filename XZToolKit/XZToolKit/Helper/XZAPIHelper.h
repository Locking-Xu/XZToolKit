//
//  XZAPIHelper.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZAPIHelper : NSObject
/**
 *  单例创建实例方法
 *
 *  @return 实例
 */
+ (instancetype)shareInstance;
/**
 *  post请求
 *
 *  @param url        请求url
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion;
/**
 *  get请求
 *
 *  @param url        请求URL
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion;
/**
 *  上传图片
 *
 *  @param image      上传的图片
 *  @param params     上传额外参数
 *  @param completion 请求完成回调
 */
- (void)uploadImage:(UIImage *)image withParams:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion;

/**
 *  下载
 *
 *  @param url 下载地址
 */
- (void)downloadWith:(NSString *)url callback:(void(^)(id response, NSString *filePath))completion;
@end
