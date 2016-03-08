//
//  XZBlogCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBlogCell.h"
#import "XZUtils.h"

@interface XZBlogCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation XZBlogCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentWithDic:(NSDictionary *)dic{
    
    self.titleLab.text =dic[@"title"];
}

+ (CGFloat)heightForCellWithTitle:(NSString *)title{

    CGSize title_Size = [XZUtils stringAdaptive:title width:UISCREEN_WIDTH-30-37 lineSpace:0 font:15 mode:NSLineBreakByCharWrapping];
    return title_Size.height+20.0+0.5f;
}
@end
