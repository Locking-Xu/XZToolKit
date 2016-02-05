//
//  XZEventsThroughView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEventsThroughView.h"

@implementation XZEventsThroughView{

    BOOL _hits;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (_hits) {
        return nil;
    }
    
    if (!self.eventsThroughViews ||(self.eventsThroughViews && self.eventsThroughViews.count == 0)) {
        return self;
    }
    else{
        
        UIView *hitView = [super hitTest:point withEvent:event];
        
        if (hitView == self) {
            
            _hits = YES;
            CGPoint superPoint = [self.superview convertPoint:point fromView:self];
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            _hits = NO;
            
            if ([self isPassthroughView:superHitView]) {
                hitView = superHitView;
            }
        }
        
        return hitView;
    }
}

- (BOOL)isPassthroughView:(UIView *)view {
    
    if (view == nil) {
        return NO;
    }
    
    if ([self.eventsThroughViews containsObject:view]) {
        return YES;
    }
    
    return [self isPassthroughView:view.superview];
}

@end
