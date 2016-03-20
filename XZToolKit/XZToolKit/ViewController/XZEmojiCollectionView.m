//
//  XZEmojiCollectionView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmojiCollectionView.h"
#import "XZEmoji.h"
#import "UIView+Frame.h"
#import "XZEmojiView.h"
#import "UIButton+FillColor.h"
#import "XZEmojiSectionScrollView.h"
#import "XZEmojiPreview.h"

#define EmojiToolBarHeight  30.0f
#define EmojiRows           5
#define EmojiTitleViewHeight    25.0f

@interface XZEmojiCollectionView()<UIScrollViewDelegate,XZEmojiSectionScrollView>{

    NSArray *_allEmojiArray;
    CGSize _emojiSize;
    CGFloat _itemSpace;
    NSMutableArray *_titleLabelArray;
    NSMutableArray *_sectionViewArray;
    NSMutableArray *_sectionButtonArray;
    /** 当前手指触摸的位置*/
    CGPoint _currentLocation;

}

@property (nonatomic, strong) UIView *emojiToolBar;
@property (nonatomic, strong) XZEmojiSectionScrollView *scrollView;
@property (nonatomic, strong) XZEmojiPreview *preview;

@end

@implementation XZEmojiCollectionView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _allEmojiArray = [XZEmoji allEmojis];
        _emojiSize = [XZEmojiView emojiSize:@"😄"];
        
        CGFloat minSpace = 20.0f;
        
        NSInteger column = 0;
        CGFloat w = minSpace;
        while (w < self.width) {
            column++;
            w += minSpace + _emojiSize.width;
        }
        //emoji水平间距
        _itemSpace = (self.width - column*_emojiSize.width)/(column + 1);
        
        [self addScrollView];
        [self addEmojiToolBar];
    }
    return self;
}

#pragma mark - Setter && Getter
- (XZEmojiPreview *)preview{
    
    if (!_preview) {
        _preview = [[XZEmojiPreview alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _preview.hidden = YES;
        [self.scrollView addSubview:_preview];
    }
    return _preview;
}

#pragma mark - Load_UI
- (void)addScrollView{

    self.scrollView = [[XZEmojiSectionScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - EmojiToolBarHeight)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.touchDelegate = self;
    
    CGFloat sectionLeft = 0.0f;
    _titleLabelArray = [NSMutableArray array];
    _sectionViewArray = [NSMutableArray array];
    
    for (NSInteger section = 0; section < _allEmojiArray.count; section++) {
        
        XZEmoji *emoji = _allEmojiArray[section];
        
        //titleView
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = emoji.title;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(sectionLeft + _itemSpace, 0, titleLabel.width, EmojiTitleViewHeight);
        [self.scrollView addSubview:titleLabel];
        [_titleLabelArray addObject:titleLabel];
        
        //ContentView
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(sectionLeft, 0, 0, self.scrollView.height)];
        sectionView.userInteractionEnabled = NO;
        [self.scrollView addSubview:sectionView];
        [_sectionViewArray addObject:sectionView];
        
        CGFloat left = 0.0f;
        CGFloat top = 0.0f;
        
        for (NSInteger i = 0; i < emoji.emojis.count; i++) {
            
            if (i%EmojiRows == 0) {
                
                top = 0.0f;
                left = (_itemSpace + _emojiSize.width)*(i/5)+_itemSpace;
                
            }
            
            XZEmojiView *emojiView = [[XZEmojiView alloc] initWithFrame:CGRectMake(left, top, _emojiSize.width, _emojiSize.height)];
            top += _emojiSize.height;
            [emojiView setEmoji:emoji.emojis[i]];
            [sectionView addSubview:emojiView];
        }
        
        sectionLeft += left+_emojiSize.width;
        sectionView.frame = CGRectMake(CGRectGetMinX(sectionView.frame), EmojiTitleViewHeight, sectionLeft-CGRectGetMinX(sectionView.frame), CGRectGetHeight(self.bounds));
    
    }
    
    [self addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(sectionLeft+_itemSpace, self.scrollView.height);
}

- (void)addEmojiToolBar{
    
    self.emojiToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - EmojiToolBarHeight, self.width, EmojiToolBarHeight)];
    
    CGFloat width = self.width/(_allEmojiArray.count + 1);

    _sectionButtonArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<=_allEmojiArray.count; i++) {

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, EmojiToolBarHeight)];

        [self.emojiToolBar addSubview:button];
        if (i == _allEmojiArray.count) {

            [button setTitle:@"删除" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(deleteBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            XZEmoji *emoji = _allEmojiArray[i];
            [button setTitle:emoji.title forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor redColor] forState:UIControlStateSelected];
            if (i == 0)
                button.selected = YES;;
            [button addTarget:self action:@selector(sectionBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
            [_sectionButtonArray addObject:button];
        }
    }
    
    [self addSubview:self.emojiToolBar];
}

#pragma mark - UIScorllView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self updateTitleLabelLocation:scrollView.contentOffset.x];
    [self updateSectionButton:scrollView.contentOffset.x];
}

#pragma mark - Private_Methods
/**
 *  更新TitleView的位置
 *
 *  @param offset 位移
 */
- (void)updateTitleLabelLocation:(CGFloat)offset{

    for (NSInteger section = 0; section < _allEmojiArray.count; section++) {
    
        UILabel *titleLabel = _titleLabelArray[section];
        UIView *sectionView = _sectionViewArray[section];
        
        CGFloat x = MIN(sectionView.maxX - titleLabel.width - _itemSpace, MAX(sectionView.minX, offset+_itemSpace));
        
        titleLabel.frame = CGRectMake(x, 0, titleLabel.width, EmojiTitleViewHeight);
        
    }
}

/**
 *  更新section按钮
 */
- (void)updateSectionButton:(CGFloat)offset{

    for (NSInteger section = 0; section < _sectionViewArray.count; section++) {
        UIView *sectionView = _sectionViewArray[section];
        if (offset< sectionView.maxX-0.1 && offset >= sectionView.minX-0.1) {
            
            [self updateSectionButtonState:_sectionButtonArray[section]];
            
            return;
        }
    }
}

/**
 *  更新按钮的状态
 *
 *  @param sender 当前的为selected的按钮
 */
- (void)updateSectionButtonState:(UIButton *)sender{

    for (UIButton *button in _sectionButtonArray) {
        button.selected = button == sender ? YES : NO;
    }
}

/**
 *  根据当前手指触摸的位置获得emoji
 */
- (void)getEmojiFromCurrentLocation:(void(^)(NSString *string,CGPoint centerPoing))getEmojiBlock{

    if (_currentLocation.y > EmojiTitleViewHeight) {
        
        //获得手指位置所在的section
        NSInteger section = 0;
        
        for (NSInteger i=0; i<_sectionViewArray.count; i++) {
            
            UIView *sectionView = _sectionViewArray[i];
            if (CGRectContainsPoint(sectionView.frame, _currentLocation)) {
                section = i;
                break;
            }
        }

        CGPoint point = [self.scrollView convertPoint:_currentLocation toView:_sectionViewArray[section]];
        
        NSInteger row = ceilf(point.y / _emojiSize.height);
        if (row >5) row = 5;
        
        NSInteger column = ceilf(point.x / (_itemSpace + _emojiSize.width));
        
        NSInteger index = (column - 1)*EmojiRows + row - 1;
        
        XZEmoji *emoji = _allEmojiArray[section];
        
        if (index > emoji.emojis.count -1)
            getEmojiBlock(nil,CGPointZero);
        else
            getEmojiBlock(emoji.emojis[index],[self convertPoint:CGPointMake((_itemSpace + _emojiSize.width)*(column - 1) + _emojiSize.width/2.0f, _emojiSize.height*(row -1)+_emojiSize.height/2.0f) fromView:_sectionViewArray[section]]);
        
    }else{
    
        getEmojiBlock(nil,CGPointZero);
    }
}

/**
 *  结束emoji表情选择
 */
- (void)finishSelectEmoji{
    WS(weakself);
    self.preview.hidden = YES;
    [self getEmojiFromCurrentLocation:^(NSString *string,CGPoint centerPoing) {
        weakself.scrollView.scrollEnabled = YES;
        //设置键盘音
        [[UIDevice currentDevice] playInputClick];
        [weakself.textView insertText:string];
        
    }];
}

/**
 *  显示Emoji预览view
 */
- (void)showEmojiPreview{
    WS(weakself);
    [self getEmojiFromCurrentLocation:^(NSString *string,CGPoint centerPoing) {
       
        if (string) {
            weakself.scrollView.scrollEnabled = NO;
            weakself.preview.hidden = NO;
            weakself.preview.label.text = string;
            [weakself.preview setCenter:centerPoing];
        }
        else{
            
            weakself.preview.hidden = YES;
        }
    }];
}

#pragma mark - UIButton_Actions
- (void)sectionBtn_Pressed:(UIButton *)sender{

    NSInteger section = [_sectionButtonArray indexOfObject:sender];

    UIView *sectionView = _sectionViewArray[section];
    
    [self.scrollView setContentOffset:CGPointMake(sectionView.minX, 0) animated:NO];

}

- (void)deleteBtn_Pressed:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    [self.textView deleteBackward];
}

#pragma mark - XZEmojiSectionScrollView_Delegate
- (void)touchesBeganWithPoint:(CGPoint)point{
    _currentLocation = point;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [self showEmojiPreview];
    });
}

- (void)touchesMovedWithPoint:(CGPoint)point{
    _currentLocation = point;
    [self showEmojiPreview];
}

- (void)touchesEnded{
    [self finishSelectEmoji];
}

- (void)touchesCancelled{
    [self finishSelectEmoji];  
}
@end
