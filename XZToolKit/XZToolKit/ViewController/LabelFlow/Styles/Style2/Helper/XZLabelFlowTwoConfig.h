//
//  XZLabelFlowTwoConfig.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XZLabelFlowTwoConfig : NSObject
+ (XZLabelFlowTwoConfig *)shareInstance;

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, assign) CGFloat textMargin;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, assign) CGFloat textFont;
@property (nonatomic, assign) CGFloat textHeight;
@end
