//
//  XZTabBar.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTabBar.h"
#import "UIImage+Color.h"
#import "UIView+Frame.h"

@interface XZTabBar ()
@property (nonatomic, strong) UIButton *middleBtn;
@end

@implementation XZTabBar

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTranslucent:NO];
        //去除顶部的黑线
        [self setBackgroundImage:[UIImage new]];
        [self setShadowImage:[UIImage new]];
        
        self.middleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        [self.middleBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_middle"] forState:UIControlStateNormal];
        [self.middleBtn addTarget:self action:@selector(middleBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.middleBtn];
        [self bringSubviewToFront:self.middleBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.middleBtn.midX= self.width * 0.5;
    
    CGFloat distance = self.middleBtn.height - self.height;
    
    if (distance<=0) {
        self.middleBtn.midY = self.height * 0.5;
    }else{
        
        self.middleBtn.y = -distance;
    }
    
    //重新布局tabBar上的tabBarItem
    CGFloat tabBarItemWidth = self.width / (self.itemsCounts+1);
    CGFloat tabBarItemIndex = 0;
    
    for (UIView *childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            childItem.width = tabBarItemWidth;
            childItem.backgroundColor = [UIColor greenColor];
            childItem.x = tabBarItemIndex * tabBarItemWidth;
            
            tabBarItemIndex ++;
            
            if (tabBarItemIndex == self.itemsCounts/2) {
                tabBarItemIndex ++;
            }
        }
    }
}

- (void)middleBtn_Pressed{
    
    NSLog(@"middleBtn Click");
    
}

/*
 *
 Capturing touches on a subview outside the frame of its superview
 *
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        } else {
            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subview convertPoint:point fromView:self];
                result = [subview hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}

@end
