//
//  XZEmojiKeyBoard.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZEmojiKeyBoard : UIView<UIInputViewAudioFeedback>

@property (nonatomic, strong) UITextView *textView;

+ (XZEmojiKeyBoard *)shareInstance;


@end
