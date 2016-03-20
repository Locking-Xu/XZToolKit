//
//  XZEmojiSectionScrollView.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZEmojiSectionScrollView <NSObject>

- (void)touchesBeganWithPoint:(CGPoint)point;

- (void)touchesMovedWithPoint:(CGPoint)point;

- (void)touchesEnded;

- (void)touchesCancelled;

@end

@interface XZEmojiSectionScrollView : UIScrollView

@property (weak, nonatomic) id<XZEmojiSectionScrollView> touchDelegate;
@end
