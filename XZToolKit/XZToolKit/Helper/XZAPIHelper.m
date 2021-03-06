//
//  XZAPIHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAPIHelper.h"
#import <AFNetworking/AFNetworking.h>

NSString *const YCNetworkErr = @"网络错误";
NSString *const YCUploadURL  = @"<#上传URL#>";

@implementation XZAPIHelper{
    AFHTTPSessionManager *_manager;
    BOOL _isProcessing;
}

+ (instancetype)shareInstance{
    static XZAPIHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[XZAPIHelper alloc] init];
    });
    
    return helper;
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _isProcessing = NO;
        
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer setTimeoutInterval:40.f];
    }
    
    return self;
}

- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{
    
    if (_isProcessing == YES) {
        
        return completion(nil, @"There is another request in process.");
    }
    _isProcessing = YES;
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _isProcessing = NO;
        
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"status"];
        
        if (statusCode.intValue == 0) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isProcessing = NO;
        completion(nil, error.localizedDescription);
    }];
}

- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{
    
    if (_isProcessing == YES) {
        
        return completion(nil, @"There is another request in process.");
    }
    _isProcessing = YES;
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _isProcessing = NO;
        
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"status"];
        
        if (statusCode.intValue == 0) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isProcessing = NO;
        completion(nil, error.localizedDescription);
    }];
    
}

- (void)uploadImage:(UIImage *)image withParams:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{
    NSData *data = UIImageJPEGRepresentation(image, .6f);
    
    [_manager POST:YCUploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:@"file.jpeg"
                                mimeType:@"image/jpeg"];
    }progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"status"];
        
        if (statusCode.intValue == 0) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error.localizedDescription);
    }];
}

- (void)downloadWith:(NSString *)url callback:(void (^)(id, NSString *))completion{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath,
    NSError * _Nullable error) {
        
        completion(nil,filePath.absoluteString);
        
        
    }];
    [downloadTask resume];
}


@end
