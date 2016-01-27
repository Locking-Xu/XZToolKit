//
//  XZImageBrowserCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/27.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageBrowserCell.h"
#import "XZUtils.h"

@implementation XZImageBrowserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUpWithImageName:(NSString *)imageName{

    UIImage *image = XZGetImageFromBundle(imageName, @"png");
    
    UIImage *newImage = [XZUtils scaleImage:image toProportion:UISCREEN_WIDTH/2/image.size.width];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.imageView.image = newImage;
    });
}
@end
