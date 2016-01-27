//
//  XZImageBrowserCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/27.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZImageBrowserCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setUpWithImageName:(NSString *)imageName;
@end
