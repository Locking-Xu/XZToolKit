//
//  XZPhotoCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/4.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZPhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setUpCellWithObject:(id)object;
@end
