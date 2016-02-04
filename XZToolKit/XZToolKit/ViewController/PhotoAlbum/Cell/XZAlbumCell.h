//
//  XZAlbumCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/4.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZAlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

- (void)setUpCellWithDic:(NSDictionary *)dic;

@end
