//
//  XZEmoji.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmoji.h"

@implementation XZEmoji
+ (NSDictionary *)emojiDic{
    
    static NSDictionary *emojiDic = nil;
    if (!emojiDic) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        emojiDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return emojiDic;
}

+ (instancetype)peopleEmoji{
    
    XZEmoji *emoji = [XZEmoji new];
    emoji.title = @"人物";
    emoji.emojis = [self emojiDic][@"people"];
    emoji.type = EmojiTypePeople;
    
    return emoji;
}

+ (instancetype)flowerEmoji{
    XZEmoji *emoji = [XZEmoji new];
    emoji.title = @"自然";
    emoji.emojis = [self emojiDic][@"flower"];
    emoji.type = EmojiTypeFlower;
    return emoji;
}

+ (instancetype)bellEmoji{
    XZEmoji *emoji = [XZEmoji new];
    emoji.title = @"日常";
    emoji.emojis = [self emojiDic][@"bell"];
    emoji.type = EmojiTypeBell;
    return emoji;
}

+ (instancetype)vehicleEmoji{
    XZEmoji *emoji = [XZEmoji new];
    emoji.title = @"交通";
    emoji.emojis = [self emojiDic][@"vehicle"];
    emoji.type = EmojiTypeVehicle;
    return emoji;
}

+ (instancetype)numberEmoji{
    XZEmoji *emoji = [XZEmoji new];
    emoji.title = @"符号";
    emoji.emojis = [self emojiDic][@"number"];
    emoji.type = EmojiTypeNumber;
    return emoji;
}

+ (NSArray *)allEmojis{
    return @[[self peopleEmoji], [self flowerEmoji], [self bellEmoji], [self vehicleEmoji], [self numberEmoji]];
}

@end
