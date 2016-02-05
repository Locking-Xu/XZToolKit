//
//  XZGuideView.h
//  引导页封装
//
//  Created by 徐章 on 15/9/22.
//  Copyright (c) 2015年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FinishGuide)();

typedef enum {

    HiddenEnterButton,          /** 隐藏进入按钮*/
    ShowEnterButtonInLastView,  /** 只在最后一页显示进入按钮*/
    ShowEnterButtonInAllView    /** 所有页面都显示进入按钮*/
    
}ButtonType;

@interface XZGuideView : UIView<UIScrollViewDelegate>{

    /** 前层图片数组*/
    NSArray *_frontImageArray;
    /** 后层图片数组*/
    NSArray *_backgroundImageArray;
    /** 滚动时图*/
    UIScrollView *_scrollView;
    /** pageController*/
    UIPageControl *_pageController;
    /** 背景UIInagView数组*/
    NSMutableArray *_backgroundViewArray;
    /** 是否只在最后一页显示进入按钮*/
    BOOL _isShowEnterButtonInLastView;
}



/** 是否显示pageController,YES：隐藏 NO：显示*/
@property (nonatomic, assign) BOOL isHidePageController;
/** pageController颜色*/
@property (nonatomic, strong) UIColor *pageControllerColor;
/** pageController当前页颜色*/
@property (nonatomic, strong) UIColor *pageControllerCurrentColor;
/** 引导结束Block*/
@property (nonatomic, copy) FinishGuide finishBlock;
/** 进入按钮*/
@property (nonatomic, strong) UIButton *enterButton;
/** 按钮类型*/
@property (nonatomic, assign) ButtonType buttonType;


/**
 *  init
 *
 *  @param frontImageArray      前层图片数组
 *  @param backgroundImageArray 后层图片数组
 */
- (id)initWithFrontImageArray:(NSArray *)frontImageArray backgroundImageArray:(NSArray *)backgroundImageArray;

@end
