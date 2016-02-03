//
//  XZPhotoAblumCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPhotoAblumCell.h"
#import "XZUtils.h"

@implementation XZPhotoAblumCell{
    
    __weak IBOutlet UIImageView *_imageView;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUpCellWithImage:(UIImage *)image{
    
//    UIImage *image = XZGetImageFromBundle(imageName, @"png");
//    
//    UIImage *newImage = [XZUtils scaleImage:image toProportion:(UISCREEN_WIDTH)/4/image.size.width];
    
    _imageView.image = image;
}

@end
