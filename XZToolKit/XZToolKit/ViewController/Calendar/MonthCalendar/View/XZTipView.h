//
//  XZTipView.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZTipView : UIView

@property (nonatomic, strong) UILabel *label;

- (void)hideWithTime:(CGFloat)time;

- (void)showWithTime:(CGFloat)time;
@end
