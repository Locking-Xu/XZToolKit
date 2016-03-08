//
//  XZLabelFlowCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZLabelFlowCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (CGSize)sizeForCell:(NSString *)string;
@end
