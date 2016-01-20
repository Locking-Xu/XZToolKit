//
//  UIView+Frame.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/**
 *  原点
 */
- (void)setOrigin:(CGPoint)origin{
    
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGPoint)origin{
    
    return self.frame.origin;
}

/**
 *  大小
 */
- (void)setSize:(CGSize)size{
    
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size{
    
    return self.frame.size;
}

/**
 *  原点－X
 */
- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    
    return self.frame.origin.x;
}

/**
 *  原点－Y
 */
- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    
    return self.frame.origin.y;
}

/**
 *  大小－宽度
 */
- (void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

- (CGFloat)width{
    
    return self.frame.size.width;
}

/**
 *  大小－高度
 */
- (void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    
    return self.frame.size.height;
}

/**
 *  最小－X
 */
- (void)setMinX:(CGFloat)minX{
    
    CGRect rect = self.frame;
    rect.origin.x = minX;
    self.frame = rect;
}

- (CGFloat)minX{
    
    return self.frame.origin.x;
}

/**
 *  最小－Y
 */
- (void)setMinY:(CGFloat)minY{
    
    CGRect rect = self.frame;
    rect.origin.y = minY;
    self.frame = rect;
}

- (CGFloat)minY{
    
    return self.frame.origin.y;
}

/**
 *  中间－X
 */
- (void)setMidX:(CGFloat)midX{
    
    self.center = CGPointMake(midX, self.center.y);
}

- (CGFloat)midX{
    
    return self.center.x;
}

/**
 *  中间－Y
 */
- (void)setMidY:(CGFloat)midY{
    
    self.center = CGPointMake(self.center.x, midY);
}

- (CGFloat)midY{
    
    return self.center.y;
}

/**
 *  最大－X
 */
- (void)setMaxX:(CGFloat)maxX{
    
    CGRect rect = self.frame;
    rect.origin.x = maxX - self.width;
    self.frame = rect;
}

- (CGFloat)maxX{
    
    return self.x + self.width;
}

/**
 *  最大－Y
 */
- (void)setMaxY:(CGFloat)maxY{
    
    CGRect rect = self.frame;
    rect.origin.y = maxY - self.height;
    self.frame = rect;
}

- (CGFloat)maxY{
    
    return self.y + self.height;
}
@end
