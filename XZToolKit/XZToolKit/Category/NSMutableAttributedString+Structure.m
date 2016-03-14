//
//  NSMutableAttributedString+Structure.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/14.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "NSMutableAttributedString+Structure.h"

@implementation NSMutableAttributedString (Structure)

- (NSMutableAttributedString *)setTextWithColor:(UIColor *)color inRange:(NSRange)range{

     [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithFont:(UIFont *)font inRange:(NSRange)range{

    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithBackgroundColor:(UIColor *)color inRange:(NSRange)range{

    [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithStrokeColor:(UIColor *)color strokeWidth:(CGFloat)width inRange:(NSRange)range{

    [self addAttribute:NSStrokeColorAttributeName value:color range:range];
    [self addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:width] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithShadow:(NSShadow *)shadow inRange:(NSRange)range{

    [self addAttribute:NSShadowAttributeName value:shadow range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithDeleteLine:(NSUnderlineStyle)lineStyle color:(UIColor *)color inRange:(NSRange)range{
    
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:lineStyle] range:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    return self;
    
}

- (NSMutableAttributedString *)setTextWithUnderLine:(NSUnderlineStyle)lineStyle color:(UIColor *)color inRange:(NSRange)range{

    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:lineStyle] range:range];
    [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
    return self;
}
- (NSMutableAttributedString *)setTextWithKern:(CGFloat)kern inRange:(NSRange)range{

    [self addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:kern] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithParagraphStyle:(NSParagraphStyle *)paragraphStyle inRange:(NSRange)range{
    
     [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithEffect:(NSString *)effect inRange:(NSRange)range{

    [self addAttribute:NSTextEffectAttributeName value:effect range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithLigature:(BOOL)isLigature inRange:(NSRange)range{

    [self addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInteger:isLigature] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithObliqueness:(CGFloat)obliqueness inRange:(NSRange)range{
    
    [self addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:obliqueness] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithBaseLineOffset:(CGFloat)offset inRange:(NSRange)range{

    [self addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:offset] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithExpansion:(CGFloat)expansion inRange:(NSRange)range{

    [self addAttribute:NSExpansionAttributeName value:[NSNumber numberWithFloat:expansion] range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithURL:(NSURL *)url inRange:(NSRange)range{

    [self addAttribute:NSLinkAttributeName value:url range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithAttacment:(NSTextAttachment *)attachment inRange:(NSRange)range{

     [self addAttribute:NSAttachmentAttributeName value:attachment range:range];
    return self;
}

- (NSMutableAttributedString *)setTextWithAttributes:(NSDictionary *)dic inRange:(NSRange)range{

    [self addAttributes:dic range:range];
    return self;
}
@end
