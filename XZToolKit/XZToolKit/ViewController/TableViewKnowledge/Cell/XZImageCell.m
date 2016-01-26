//
//  XZImageCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageCell.h"
#import "XZUtils.h"

@implementation XZImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUpCellWithTitle:(NSString *)title imageName:(NSString *)imageName{
    
    self.titleLabel.text = title;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        UIImage *image = XZGetImageFromBundle(imageName, @"png");
        
        UIImage *newImage = [XZUtils scaleImage:image toProportion:(UISCREEN_WIDTH-5*3)/4/image.size.width];
        
        dispatch_async(dispatch_get_main_queue(), ^{
    
            self.imageView.image = newImage;
        });
        
    });

}

+ (CGFloat)heightOfCell:(NSArray *)imageArray width:(CGFloat)width{
    
    CGFloat scale = 0.0;
    
    for (NSString *imageName in imageArray) {
        
        UIImage *image = XZGetImageFromBundle(imageName, @"png");
        
        CGFloat proportion = image.size.height/image.size.width;
        
        if (proportion >= scale) {
            
            scale = proportion;
        }
    }
    
    return width * scale;
}
@end
