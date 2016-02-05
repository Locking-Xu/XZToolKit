//
//  XZGuideView.m
//  引导页封装
//
//  Created by 徐章 on 15/9/22.
//  Copyright (c) 2015年 xuzhang. All rights reserved.
//

#import "XZGuideView.h"

@implementation XZGuideView

/**
 *  init XZGuideView
 *
 *  @param frontImageArray      前层图片
 *  @param backgroundImageArray 后层图片
 *
 *  @return XZGuideView
 */
- (id)initWithFrontImageArray:(NSArray *)frontImageArray backgroundImageArray:(NSArray *)backgroundImageArray{
    
    self = [super init];
    
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        _frontImageArray = frontImageArray;
        _backgroundImageArray = backgroundImageArray;
        
        //默认显示pageController
        _isHidePageController = NO;
        
        [self addBackgroundImage];
        [self addScrollView];
        [self addPageController];
        
        //默认情况下进入按钮只在随后一页显示
        
        _isShowEnterButtonInLastView = YES;
        
        [self addEnterButton];
    }
    
    return self;
}

/**
 *  添加背景图片，图片采用重叠方式布局，数组中的第一个位于最上层，切换时，设置上层图片的Alpha为0.0
 */
- (void)addBackgroundImage{
    
    if (_backgroundImageArray) {
        
        _backgroundViewArray = [NSMutableArray array];
        
        for (int i = (int)(_backgroundImageArray.count - 1) ; i >= 0; i--) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            imageView.image = [UIImage imageNamed:_backgroundImageArray[i]];
            
            [_backgroundViewArray addObject:imageView];
            
            [self addSubview:imageView];
        }
    }
}

/**
 *  添加滚动视图
 */
- (void)addScrollView{
    
    if (_frontImageArray) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH * _frontImageArray.count, UISCREEN_HEIGHT);
        
        for (int i = 0; i < _frontImageArray.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * UISCREEN_WIDTH, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
            
            imageView.image = [UIImage imageNamed:_frontImageArray[i]];
            [_scrollView addSubview:imageView];
            
        }
        
        [self addSubview:_scrollView];
    }
}

/**
 *  添加pageController
 */
- (void)addPageController{
    
    CGFloat pageControllerWidth = 20*_frontImageArray.count;
    
    
    _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake((UISCREEN_WIDTH - pageControllerWidth)/2, UISCREEN_HEIGHT *0.95, pageControllerWidth, 20)];
    _pageController.numberOfPages = _frontImageArray.count;
    
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    [self addSubview:_pageController];
}

/**
 *  添加进入按钮
 */
- (void)addEnterButton{
    
    CGFloat buttonWidth = UISCREEN_WIDTH * 0.8;
    
    self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH * 0.1, UISCREEN_HEIGHT *0.9, buttonWidth, 30)];
    [self.enterButton setTitle:@"进入" forState:UIControlStateNormal];
    [self.enterButton setTintColor:[UIColor whiteColor]];
    self.enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.enterButton.layer.borderWidth = 1.0f;
    self.enterButton.layer.cornerRadius = 2.5f;
    
    [self.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];

    self.enterButton.hidden = YES;
    
    [self addSubview:self.enterButton];
    
}

/**
 *  设置pageController颜色
 */
- (void)setPageControllerColor:(UIColor *)pageControllerColor{
    
    _pageController.pageIndicatorTintColor = pageControllerColor;
}

/**
 *  设置pageController当前页颜色
 */
- (void)setPageControllerCurrentColor:(UIColor *)pageControllerCurrentColor{
    
    _pageController.currentPageIndicatorTintColor = pageControllerCurrentColor;
}

/**
 *  设置是否显示pageController
 */
- (void)setIsHidePageController:(BOOL)isHidePageController{
    
    _pageController.hidden = isHidePageController;
}

- (void)setButtonType:(ButtonType)buttonType{
    
    switch (buttonType) {
        case HiddenEnterButton:
            _isShowEnterButtonInLastView = NO;
            break;
            
        case ShowEnterButtonInLastView:
            _isShowEnterButtonInLastView = YES;
            break;
            
        case ShowEnterButtonInAllView:
            _isShowEnterButtonInLastView = NO;
            self.enterButton.hidden = NO;
            break;
    }
}

#pragma mark UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset_X = scrollView.contentOffset.x;
    
    NSInteger index = offset_X / UISCREEN_WIDTH;
    
    //计算的透明值
    CGFloat alpha = 1 - (offset_X - index*UISCREEN_WIDTH)/UISCREEN_WIDTH;
    
    //默认情况下在最后一页显示进入按钮,调整按钮alpha值
    if (_isShowEnterButtonInLastView) {
        
        if (index == _frontImageArray.count - 1) {
            
            self.enterButton.hidden = NO;
            
            self.enterButton.alpha = alpha;
        }else{
            
            self.enterButton.hidden = YES;
        }
    }
    
   //调整背景图片alpha值
    if (_backgroundViewArray.count > index) {
        
        UIImageView *imageView = _backgroundViewArray[_backgroundViewArray.count - index - 1];
        imageView.alpha = alpha;
    }
    
    //当前page
    _pageController.currentPage = index;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x > (_frontImageArray.count - 1) * UISCREEN_WIDTH + 50) {
        
        //完成引导页
        self.finishBlock();
    }
}

#pragma mark UIButton_Actions
- (void)enter:(UIButton *)sender{

    self.finishBlock();
}
@end
