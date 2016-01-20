//
//  XZScrollView.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZScrollView.h"
#import "UIView+Frame.h"

#define AutoScrollTime 2.0f

@implementation XZScrollView

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
    }
    
    return self;
    
}

#pragma mark - Set_Methods
- (void)setImageUrlArr:(NSArray *)imageUrlArr{
    
    _imageUrlArr = imageUrlArr;
    
    [self initScrollView];
    
}

- (void)setAutoScroll:(BOOL)autoScroll{
    
    _autoScroll = autoScroll;
    if (_autoScroll) {
        
        [self createTimer];
    }
    
}

#pragma mark - Private_Methods
/**
 *  创建ScrollView
 */
- (void)initScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_WIDTH * 7/16)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH * (self.imageUrlArr.count+2), _scrollView.height);
    _scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH, 0);
    
    for (int i=0; i<self.imageUrlArr.count ; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH * (i+1), 0, UISCREEN_WIDTH, _scrollView.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        
#warning Set image Here
        imageView.backgroundColor = [UIColor redColor];

        [_scrollView addSubview:imageView];
    }
    
    //无限循环--最后一张图
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH * (self.imageUrlArr.count + 1), 0, UISCREEN_WIDTH, _scrollView.height)];
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastImageView.layer.masksToBounds = YES;

#warning Set image Here
    lastImageView.backgroundColor = [UIColor greenColor];
    
    [_scrollView addSubview:lastImageView];
    
    //无限循环--最前一张图
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, _scrollView.height)];
    firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    firstImageView.layer.masksToBounds = YES;
    
#warning Set image Here
    firstImageView.backgroundColor = [UIColor greenColor];
    
    [_scrollView addSubview:firstImageView];
    
    [self initPageController];
    
    [self addTapGesture];
}

/**
 *  创建pageControl
 */
- (void)initPageController{
    
    self.pageControl = [[XZPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.height - 20, UISCREEN_WIDTH, 20)];
    self.pageControl.numberOfPages = self.imageUrlArr.count;
    self.pageControl.currentPage = 0;
    
    [self addSubview:self.pageControl];
}

- (void)addTapGesture{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnImageView)];
    [self addGestureRecognizer:tapGesture];
}

- (void)didTapOnImageView{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YCScrollView:didSelectAtIndex:)]) {
        
        [self.delegate YCScrollView:self didSelectAtIndex:_pageControl.currentPage];
    }
}

/**
 *  创建定时器
 */
- (void)createTimer{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:AutoScrollTime target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

/**
 *  自动换页
 */
- (void)changePage{
    
    NSInteger index = self.pageControl.currentPage;
    index++;
    //无缝切换
    [_scrollView scrollRectToVisible:CGRectMake(UISCREEN_WIDTH* (index + 1), 0, UISCREEN_WIDTH, _scrollView.height) animated:YES];
}

#pragma mark UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat index = scrollView.contentOffset.x/UISCREEN_WIDTH;
    
    
    if (index == self.imageUrlArr.count + 1) {
        
        _scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH,0);
        _pageControl.currentPage = 0;
        return;
    }else if (index == 0){
        
        _scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH * self.imageUrlArr.count, 0);
        
        _pageControl.currentPage = self.imageUrlArr.count - 1;
        
        return;
    }
    
    self.pageControl.currentPage = index - 1;
    
}


@end
