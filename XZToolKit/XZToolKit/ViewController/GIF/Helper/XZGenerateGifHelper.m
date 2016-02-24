//
//  XZGenerateGifHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGenerateGifHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation XZGenerateGifHelper

- (void)generateGifFromUrl:(NSURL *)url loopCount:(NSInteger)loopCount FPS:(NSInteger)fps completeBlock:(CompleteBlock)completeBlock{
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    CGFloat duration = CMTimeGetSeconds(asset.duration);

    CGFloat time = 0.0;
    NSMutableArray *times = [[NSMutableArray alloc] init];
    while (time < duration) {
        [times addObject:[NSNumber numberWithFloat:time]];
        time += 0.1;
    }
    
    __block NSURL *resultUrl;
    
    dispatch_group_t groupQueue = dispatch_group_create();
    dispatch_group_enter(groupQueue);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        resultUrl = [self createGifWithAVURLAsset:asset times:times FPS:fps loopCount:loopCount];
        
        dispatch_group_leave(groupQueue);
    });
    
    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{
        
        completeBlock(resultUrl);
    });
}

- (NSURL *)createGifWithAVURLAsset:(AVURLAsset *)asset times:(NSMutableArray *)times FPS:(NSInteger)fps loopCount:(NSInteger)loopCount{
    
    //设置属性
    NSDictionary *loopCountDic = @{(__bridge NSString*)kCGImagePropertyGIFLoopCount:[NSNumber numberWithInteger:loopCount]};
    NSDictionary *delaytimeDic = @{(__bridge NSString*)kCGImagePropertyGIFDelayTime:[NSNumber numberWithFloat:1.0/fps]};
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"create.gif"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }else{
        
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)url, kUTTypeGIF, times.count, nil);
    
    if (destination) {
        
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generator.appliesPreferredTrackTransform = true;
        generator.requestedTimeToleranceAfter = kCMTimeZero;
        generator.requestedTimeToleranceBefore = kCMTimeZero;
        
        for (NSNumber *time in times) {
            
            CMTime cmTime = CMTimeMakeWithSeconds(time.floatValue, (int32_t)times.count);
            
            CGImageRef imageRef = [generator copyCGImageAtTime:cmTime actualTime:nil error:nil];
            CGImageDestinationAddImage(destination, imageRef, (__bridge CFDictionaryRef)delaytimeDic);
        }

        CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)loopCountDic);
        CGImageDestinationFinalize(destination);
        
        
        return url;
    }
    
    return nil;
}
@end
