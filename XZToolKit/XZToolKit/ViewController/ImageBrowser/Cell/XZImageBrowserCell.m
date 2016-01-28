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
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self addGestureRecognizer:tapGesture];
}

- (void)setUpWithImageName:(NSString *)imageName{

    UIImage *image = XZGetImageFromBundle(imageName, @"png");
    
    self.imageView.image = image;
}

- (void)close{
    
    UIViewController *vc = [XZUtils getCurrentViewController];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}
@end
