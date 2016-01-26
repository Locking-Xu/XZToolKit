//
//  XZImageCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


+ (CGFloat)heightOfCell:(NSArray *)imageArray width:(CGFloat)width;

- (void)setUpCellWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
