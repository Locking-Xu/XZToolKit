//
//  XZEmojiKeyBoard.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmojiKeyBoard.h"
#import "XZEmoji.h"
#import "UIView+Frame.h"
#import "XZEmojiCollectionView.h"


#define KeyBoardHeight  262.0f

@interface XZEmojiKeyBoard()

@property (nonatomic, strong) XZEmojiCollectionView *emojiCollectionView;

@end

@implementation XZEmojiKeyBoard

+ (XZEmojiKeyBoard *)shareInstance{

    static XZEmojiKeyBoard *emojiKeyBoard = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       
        emojiKeyBoard = [[XZEmojiKeyBoard alloc] init];
    });
    return emojiKeyBoard;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, KeyBoardHeight)];
    if (self) {
        [self addEmojiCollectionView];
    }
    return self;
}


- (void)addEmojiCollectionView{
    self.emojiCollectionView = [[XZEmojiCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];

    [self addSubview:self.emojiCollectionView];
}

- (void)setTextView:(UITextView *)textView{
    _textView = textView;
    self.emojiCollectionView.textView = _textView;
}

#pragma mark - UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible{
    return YES;
}
@end
