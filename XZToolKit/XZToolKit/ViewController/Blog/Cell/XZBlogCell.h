//
//  XZBlogCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBlogCell : UITableViewCell

- (void)setContentWithDic:(NSDictionary *)dic;

+ (CGFloat)heightForCellWithTitle:(NSString *)title;

@end
