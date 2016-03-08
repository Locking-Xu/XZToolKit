//
//  XZQuartz2DDashView.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZQuartz2DDashView : UIView{

    CGFloat _dashPattern[10];
    size_t _dashCount;
}

@property (nonatomic, assign) CGFloat dashPase;

- (void)setDashPattern:(CGFloat *)pattern count:(size_t)count;
@end
