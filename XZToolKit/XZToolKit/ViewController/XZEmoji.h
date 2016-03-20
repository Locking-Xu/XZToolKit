//
//  XZEmoji.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZEmoji : NSObject
typedef NS_ENUM(NSUInteger, EmojiType){
    
    EmojiTypePeople,
    EmojiTypeFlower,
    EmojiTypeBell,
    EmojiTypeVehicle,
    EmojiTypeNumber
};

@property (nonatomic, assign) EmojiType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *emojis;

+ (NSArray *)allEmojis;
@end
