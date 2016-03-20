//
//  XZEmojiView.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZEmojiView : UIImageView

- (void)setEmoji:(NSString *)emoji;
+ (CGSize)emojiSize:(NSString *)emoji;
@end
