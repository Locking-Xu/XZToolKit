//
//  XZAlbumCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/4.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAlbumCell.h"
#import <Photos/Photos.h>

@implementation XZAlbumCell

- (void)awakeFromNib {
    // Initialization code
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellWithDic:(NSDictionary *)dic{
    
    self.nameLab.text = dic[@"name"];
    
    self.countLab.text = [NSString stringWithFormat:@"%@张",dic[@"count"]];

    if (DEVICE_VERSION >= 8.0) {

        //IOS8

        PHAsset *asset = dic[@"asset"];
        
        if ([asset isKindOfClass:[NSNull class]]) {
            
            self.mainImageView.image = [UIImage imageNamed:@"noPhoto"];
            return;
        }

        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

           dispatch_async(dispatch_get_main_queue(), ^{

               self.mainImageView.image = result;

           });

        }];

    }else{
    
        self.mainImageView.image = dic[@"posterImage"];
    }
}

@end
