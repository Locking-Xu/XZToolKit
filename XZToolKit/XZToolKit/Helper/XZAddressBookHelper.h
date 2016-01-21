//
//  XZAddressBookHelper.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//
/** 名*/
#define FirstName @"firstName"
/** 名的汉语拼音带有音标*/
#define FirstNameWithPhonetic @"firstNameWithPhonetic"
/** 名的汉语拼音不带有音标*/
#define FirstNameWithoutPhonetic @"firstNameWithoutPhonetic"
/** 名的首字母（大写）PS：需要小写的话，直接在外部转换一下*/
#define FirstNameFirstLetter @"firstNameFirstLetter"
/** 姓*/
#define LastName @"lastName"
/** 姓的汉语拼音带有音标*/
#define LastNameWithPhonetic @"lastNameWithPhonetic"
/** 姓的汉语拼音不带有音标*/
#define LastNameWithoutPhonetic @"lastNameWithoutPhonetic"
/** 姓的首字母（大写）PS：需要小写的话，直接在外部转换一下*/
#define LastNameFirstLetter @"lastNameFirstLetter"
/** 全名*/
#define FullName @"fullName"
/** 全名的汉语拼音带有音标*/
#define FullNameWithPhonetic @"fullNameWithPhonetic"
/** 姓的首字母（大写）PS：需要小写的话，直接在外部转换一下*/
#define FullNameWithoutPhonetic @"fullNameWithoutPhonetic"
/** 电话号码*/
#define PhoneNumber @"phoneNumber"
/** 邮箱*/
#define Email @"email"
/** 头像*/
#define HeadImage @"headImage"
/** 地址*/
#define Address @"address"
/** 生日*/
#define BirthDay @"birthDay"
/** 链接地址*/
#define Url @"url"

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>

@interface XZLocalContactModel : NSObject
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSMutableString *firstNameWithPhonetic;
@property (nonatomic, strong) NSMutableString *firstNameWithoutPhonetic;
@property (nonatomic, strong) NSString *firstNameFirstLetter;

@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSMutableString *lastNameWithPhonetic;
@property (nonatomic, strong) NSMutableString *lastNameWithoutPhonetic;
@property (nonatomic, strong) NSString *lastNameFirstLetter;

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSMutableString *fullNameWithPhonetic;
@property (nonatomic, strong) NSMutableString *fullNameWithoutPhonetic;


@property (nonatomic, strong) NSMutableDictionary *phoneNumberDic;

@property (nonatomic, strong) NSMutableDictionary *emailDic;

@property (nonatomic, strong) UIImage *headImage;

@property (nonatomic, strong) NSMutableDictionary *addressDic;

@property (nonatomic, strong) NSDate *birthday;

@property (nonatomic, strong) NSMutableDictionary *urlDic;
@end


@interface XZAddressBookHelper : NSObject
{
    ABAddressBookRef _addressBook;
    
    NSMutableDictionary *_contactDic;
    
    NSMutableArray *_firstLetterArr;
}

/**
 *  单例
 */
+ (id)shareInstance;

- (NSMutableDictionary *)getAddressBookWithProperties:(NSArray *)properties;


@end
