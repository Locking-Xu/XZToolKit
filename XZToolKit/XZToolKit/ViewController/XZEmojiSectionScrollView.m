//
//  XZEmojiSectionScrollView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmojiSectionScrollView.h"

@interface XZEmojiSectionScrollView ()

@end

@implementation XZEmojiSectionScrollView

#pragma mark - Touch_Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];

    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchesBeganWithPoint:)]) {
        
        [self.touchDelegate touchesBeganWithPoint:point];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchesMovedWithPoint:)]) {
        
        [self.touchDelegate touchesMovedWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchesEnded)]) {
        
        [self.touchDelegate touchesEnded];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchesCancelled)]) {
        
        [self.touchDelegate touchesCancelled];
    }
}
@end
