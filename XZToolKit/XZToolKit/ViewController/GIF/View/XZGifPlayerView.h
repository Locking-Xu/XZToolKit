//
//  XZGifPlayerView.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZGifPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame fileUrl:(NSURL *)url;

- (void)startAnimation;

- (void)stopAnimation;

@end
