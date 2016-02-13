//
//  XZImageBrowserCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/27.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageBrowserCell.h"
#import "XZUtils.h"
#import "UIView+Frame.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@implementation XZImageBrowserCell{
    
    UIImageView *_imageView;
    UIScrollView *_scrollView;
}

- (void)awakeFromNib {
    // Initialization code
    
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.delegate = self;
    
    _scrollView.minimumZoomScale = 1.0f;
    _scrollView.maximumZoomScale = 2.0f;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] init];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_imageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self addGestureRecognizer:tapGesture];
    
}

- (void)layoutSubviews{
    
    _scrollView.frame = self.bounds;
    
    _imageView.frame = _scrollView.bounds;
    
}

- (void)setUpWithImage:(id)imageObject{
    
    if (_scrollView.zoomScale != 1.0) {
        
        [_scrollView setZoomScale:1.0 animated:NO];
    }
    
    if (DEVICE_VERSION >= 8.0) {
        
        PHAsset *asset = (PHAsset *)imageObject;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.bounds.size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _imageView.image = result;
                
            });
            
        }];

        
    }else{
    
        ALAsset *asset = (ALAsset *)imageObject;
    
        ALAssetRepresentation *representation = asset.defaultRepresentation;
        _imageView.image =  [UIImage imageWithCGImage:representation.fullScreenImage] ;
    
    }

}

- (void)close{
    
    UIViewController *vc = [XZUtils getCurrentViewController];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
//缩放系数(倍数)
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
    [scrollView setZoomScale:scale animated:YES];
}
@end
