//
//  NSMutableAttributedString+Structure.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/14.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Structure)
/**
 *  设置Range内字体的颜色
 *
 *  @param color 字体颜色
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithColor:(UIColor *)color inRange:(NSRange)range;
/**
 *  设置Range内字体的大小
 *
 *  @param font 字体大小
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithFont:(UIFont *)font inRange:(NSRange)range;

/**
 *  设置Range内字体的背景色
 *
 *  @param color 背景色
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithBackgroundColor:(UIColor *)color inRange:(NSRange)range;

/**
 *  设置Range内字体中空
 *
 *  @param color 线条颜色
 *  @param width 线条宽度
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithStrokeColor:(UIColor *)color strokeWidth:(CGFloat)width inRange:(NSRange)range;

/**
 *  设置Range内字体阴影
 *
 *  @param shadow 阴影
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithShadow:(NSShadow *)shadow inRange:(NSRange)range;

/**
 *  设置Range内字体删除线
 *
 *  @param deleteLineStyle 删除线样式
 *  @param color           删除线颜色
 *  @param range           范围
 */
- (NSMutableAttributedString *)setTextWithDeleteLine:(NSUnderlineStyle)lineStyle color:(UIColor *)color inRange:(NSRange)range;

/**
 *  设置Range内字体下滑线
 *
 *  @param deleteLineStyle 下滑线样式
 *  @param color           下滑线颜色
 *  @param range           范围
 */
- (NSMutableAttributedString *)setTextWithUnderLine:(NSUnderlineStyle)lineStyle color:(UIColor *)color inRange:(NSRange)range;

/**
 *  设置字符之间间距
 *
 *  @param kern  间距
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithKern:(CGFloat)kern inRange:(NSRange)range;

/**
 *  设置Range的段落
 *
 *  @param paragraphStyle 段落
 *  @param range          范围
 */
- (NSMutableAttributedString *)setTextWithParagraphStyle:(NSParagraphStyle *)paragraphStyle inRange:(NSRange)range;

/**
 *  设置Range内文字效果
 *
 *  @param effect 效果
 *  @param range  范围
 */
- (NSMutableAttributedString *)setTextWithEffect:(NSString *)effect inRange:(NSRange)range;

/**
 *  设置字符连体
 *
 *  @param isLigature 是否连体
 *  @param range      范围
 */
- (NSMutableAttributedString *)setTextWithLigature:(BOOL)isLigature inRange:(NSRange)range;

/**
 *  设置倾斜度
 *
 *  @param obliqueness 倾斜度
 *  @param range       范围
 */
- (NSMutableAttributedString *)setTextWithObliqueness:(CGFloat)obliqueness inRange:(NSRange)range;

/**
 *  设置基线便宜
 *
 *  @param offset 偏移量
 *  @param range  范围
 */
- (NSMutableAttributedString *)setTextWithBaseLineOffset:(CGFloat)offset inRange:(NSRange)range;

/**
 *  设置压缩
 *
 *  @param expansion 压缩量
 *  @param range     范围
 */
- (NSMutableAttributedString *)setTextWithExpansion:(CGFloat)expansion inRange:(NSRange)range;

/**
 *  设置链接
 *
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithURL:(NSURL *)url inRange:(NSRange)range;
/**
 *  设置图片
 *
 *  @param attachment 图片
 *  @param range      范围
 */
- (NSMutableAttributedString *)setTextWithAttacment:(NSTextAttachment *)attachment inRange:(NSRange)range;

/**
 *  设置属性
 *
 *  @param dic   属性字典
 *  @param range 范围
 */
- (NSMutableAttributedString *)setTextWithAttributes:(NSDictionary *)dic inRange:(NSRange)range;
@end
