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

- (void)setUpWithImageName:(NSString *)imageName{
    
    if (_scrollView.zoomScale != 1.0) {
        
        [_scrollView setZoomScale:1.0 animated:NO];
    }
    
    UIImage *image = XZGetImageFromBundle(imageName, @"png");
    
    _imageView.image = image;
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
