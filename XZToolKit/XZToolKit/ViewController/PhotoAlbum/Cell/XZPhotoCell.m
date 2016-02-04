//
//  XZPhotoCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/4.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPhotoCell.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation XZPhotoCell{
    
    CGFloat _sideLength;
    CGFloat _scale;
    
}

- (void)awakeFromNib {
    // Initialization code
    
    _sideLength = (UISCREEN_WIDTH-1*3)/4;
    _scale = [UIScreen mainScreen].scale;
}

- (void)setUpCellWithObject:(id)object{
    
    if (DEVICE_VERSION >= 8.0) {
    
        PHAsset *asset = (PHAsset *)object;
    
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(_sideLength*_scale, _sideLength*_scale) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.imageView.image = result;
                
            });
            
        }];
    
    }else{
    
        ALAsset *asset = (ALAsset *)object;
        
        CGImageRef imageRef = asset.thumbnail;
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        self.imageView.image = image;
        
    }
}

@end
