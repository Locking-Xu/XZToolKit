//
//  XZInputBarView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZInputBarView.h"
#import <Masonry/Masonry.h>
#import "UIView+Frame.h"
#import "XZEmojiKeyBoard.h"

#define InputBarHeight  44.0f

@interface XZInputBarView()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *keyBoardTypeBtn;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UILabel *placeHolderLab;

@end

@implementation XZInputBarView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.keyBoardTypeBtn.backgroundColor = [UIColor redColor];
        self.sendBtn.backgroundColor = [UIColor greenColor];
        self.textView.backgroundColor = [UIColor clearColor];
        self.placeHolderLab.text = @" 请输入...";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Setter && Getter
- (UIButton *)keyBoardTypeBtn{
    WS(weakself);
    if (!_keyBoardTypeBtn) {
        _keyBoardTypeBtn  = [[UIButton alloc] init];
        [_keyBoardTypeBtn setTitle:@"Emoji" forState:UIControlStateNormal];
        [_keyBoardTypeBtn setTitle:@"键盘" forState:UIControlStateSelected];
        [_keyBoardTypeBtn addTarget:self action:@selector(keyBoardTypeBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_keyBoardTypeBtn];
        [_keyBoardTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself).offset(5.0f);
            make.bottom.equalTo(weakself).offset(-5.0f);
            make.height.mas_equalTo(@34);
            make.width.mas_equalTo(@50);
        }];
    }
    return _keyBoardTypeBtn;
}

- (UIButton *)sendBtn{
    WS(weakself);
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        [self addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(weakself.keyBoardTypeBtn);
            make.right.equalTo(weakself).offset(-5);
            make.width.equalTo(weakself.keyBoardTypeBtn);
            make.height.mas_equalTo(@34);
        }];
    }
    return _sendBtn;
}

- (UITextView *)textView{
    WS(weakself);
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor whiteColor];
        _textView.tintColor = [UIColor whiteColor];
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakself).offset(5.0f);
            make.left.equalTo(weakself.keyBoardTypeBtn.mas_right).offset(5.0f);
            make.right.equalTo(weakself.sendBtn.mas_left).offset(-5.0f);
            make.bottom.equalTo(weakself).offset(-5.0f);
        }];
    }
    return _textView;
}

- (UILabel *)placeHolderLab{
    WS(weakself);
    if (!_placeHolderLab) {
        _placeHolderLab = [[UILabel alloc] init];
        _placeHolderLab.textColor = [UIColor lightGrayColor];
        _placeHolderLab.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_placeHolderLab];
        [_placeHolderLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakself.textView);
        }];
    }
    return _placeHolderLab;
}

#pragma mark - UIButton_Actions
- (void)keyBoardTypeBtn_Pressed:(UIButton *)sender{
    //YES:是Emoji NO:键盘
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.textView.inputView = [XZEmojiKeyBoard shareInstance];
        [XZEmojiKeyBoard shareInstance].textView = self.textView;
    }else{
    
        self.textView.inputView = nil;
    }
    
    [self.textView reloadInputViews];
    if (![self.textView isFirstResponder]) {
        [self.textView becomeFirstResponder];
    }
}

#pragma mark - Notification_Methods
- (void)keyBoardWillShow:(NSNotification *)notification{

    NSDictionary *info = notification.userInfo;
    CGSize size = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateKeyframesWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:0 animations:^{
        
        self.y = UISCREEN_HEIGHT - InputBarHeight- 64.0f - size.height;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyBoardWillHidden:(NSNotification *)notification{

    NSDictionary *info = notification.userInfo;
    [UIView animateKeyframesWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:0 animations:^{
        
        self.y = UISCREEN_HEIGHT - InputBarHeight - 64.0f;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITextView_Delegate
- (void)textViewDidChange:(UITextView *)textView{
 [[UIDevice currentDevice] playInputClick];
    [self layout];

}

#pragma mark - Private_Methods
- (void)layout{
    
    self.sendBtn.enabled = ![@"" isEqualToString:self.textView.text];
    self.placeHolderLab.hidden = self.sendBtn.enabled;
    
    CGSize size = [self.textView sizeThatFits:CGSizeMake(self.textView.width,1000.0f)];
    
    if (size.height != self.textView.height) {
        self.y = self.y - (size.height -self.textView.height);
        self.height = size.height + 10.0f;
    }
}


@end
