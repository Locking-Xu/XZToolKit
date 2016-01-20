//
//  XZGlyphsHelper.m
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

/**
 *  该类的主要作用是将每个月1号到31号(至于没有30号或者31号的月份会在后面再处理)作为一个整体的符号串，并且将它的字体，每个字符的所占的size封装在一起
 */
#import "XZGlyphsHelper.h"
/** 代表1号～31号*/
static NSString *const dayChars = @"12345678910111213141516171819202122232425262728293031";

@implementation XZGlyphsHelper

+ (XZGlyphsHelper*)glyphsHelperWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize{
    
    XZGlyphsHelper *glyphsHelper = [[XZGlyphsHelper alloc] init];
    //符号串的长度
    glyphsHelper.length = dayChars.length;
    
    //设置字体
    glyphsHelper.font = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
    
    //定义字符数组characters用于接受dayChars中所有的字符
    UniChar characters[glyphsHelper.length];
    CFStringGetCharacters((__bridge CFStringRef) dayChars, CFRangeMake(0, glyphsHelper.length), characters);
    //给glyphs分配空间
    glyphsHelper.glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * glyphsHelper.length);
    //从characters获得Glyph
    CTFontGetGlyphsForCharacters(glyphsHelper.font, characters, glyphsHelper.glyphs, glyphsHelper.length);
    
    //给glyphsAdvances分配空间
    glyphsHelper.glyphsAdvances = (CGSize *)malloc(sizeof(CGSize) * glyphsHelper.length);
    //将每个对象的size存到glyphsAdvances中
    CTFontGetAdvancesForGlyphs(glyphsHelper.font, kCTFontHorizontalOrientation, glyphsHelper.glyphs, glyphsHelper.glyphsAdvances, glyphsHelper.length);
    
    return glyphsHelper;
}

@end
