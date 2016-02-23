//
//  XZGifPlayerView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGifPlayerView.h"
#import <ImageIO/ImageIO.h>

@interface XZGifPlayerView(){
    
    CGFloat _totalTime;
    NSMutableArray *_imageArray;
    UIImageView *_imageView;
}

@end

@implementation XZGifPlayerView


- (instancetype)initWithFrame:(CGRect)frame fileUrl:(NSURL *)url{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageArray = [NSMutableArray array];
        
        [self getGifInfo:url];
        
    }
    return self;
}

/**
 *  获取GIF的信息
 *
 *  @param url GIF路径
 */
- (void)getGifInfo:(NSURL *)url{
    
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)url, nil);
    
    if (!imageSourceRef)
        return;
    
    NSInteger count = CGImageSourceGetCount(imageSourceRef);
    
    for (NSInteger i = 0; i<count; i++) {
        
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, i, nil);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        CGImageRelease(imageRef);
        
        [_imageArray addObject:image];
        
        CFDictionaryRef dicRef = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, i, nil);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:(__bridge NSDictionary * _Nonnull)(dicRef)];
        
//        NSNumber *height = [dic valueForKey:(__bridge NSString * _Nonnull)kCGImagePropertyPixelHeight];
//        NSNumber *width = [dic valueForKey:(__bridge NSString * _Nonnull)kCGImagePropertyPixelWidth];
        
        NSDictionary *gifDic = [dic valueForKey:(__bridge NSString *_Nonnull)kCGImagePropertyGIFDictionary];
        
        NSNumber *delayTime = [gifDic valueForKey:(__bridge NSString * _Nonnull)kCGImagePropertyGIFDelayTime];
        
        _totalTime += delayTime.floatValue;
        
    }
}

/**
 *  开始播放GIF
 */
- (void)startAnimation{

    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];

    _imageView.animationImages = _imageArray;
    _imageView.animationDuration = _totalTime;
    _imageView.animationRepeatCount = 999;
    [_imageView startAnimating];
}

/**
 *  停止播放GIF
 */
- (void)stopAnimation{
    
    if (_imageView.isAnimating) {
        [_imageView stopAnimating];
    }
}
@end
