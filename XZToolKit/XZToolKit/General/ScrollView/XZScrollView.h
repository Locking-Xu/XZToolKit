//
//  XZScrollView.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZPageControl.h"

@class XZScrollView;

@protocol XZScrollViewDelegate <NSObject>

- (void)XZScrollView:(XZScrollView *)scrollView didSelectAtIndex:(NSUInteger) index;

@end

@interface XZScrollView : UIView<UIScrollViewDelegate>{
    
    NSInteger _lastIndex;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageUrlArr;
@property (nonatomic, strong) XZPageControl *pageControl;
@property (nonatomic, assign) BOOL autoScroll;

@property (nonatomic, weak) id<XZScrollViewDelegate> delegate;

@end
