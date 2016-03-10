//
//  XZLabelFlowThreeView.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZLabelFlowThreeConfig.h"

@protocol XZLabelFlowThreeViewDelegate <NSObject>

- (void)clickTagAtIndex:(NSInteger)index title:(NSString *)title;

@end

@interface XZLabelFlowThreeView : UIScrollView

@property (nonatomic, weak) id<XZLabelFlowThreeViewDelegate> labelFlowThreeDelegate;

- (instancetype)initWithFrame:(CGRect)frame config:(XZLabelFlowThreeConfig *)config;
@end
