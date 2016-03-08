//
//  XZAddressBookHelper.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAddressBookHelper.h"

@implementation XZLocalContactModel



@end

@implementation XZAddressBookHelper
+ (id)shareInstance{
    
    static XZAddressBookHelper *getAddressBook = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        getAddressBook = [[XZAddressBookHelper alloc] init];
    });
    
    return getAddressBook;
}
/**
 *  获取权限
 */
- (void)getPermissions{
    
    CFErrorRef error = NULL;
    
    _addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool greanted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}


- (NSMutableDictionary *)getAddressBookWithProperties:(NSArray *)properties{
    
    [self getPermissions];
    
    if (ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized) {
        return nil;
    }
    
    if (_addressBook) {
        
        NSLog(@"获取通讯录成功");
        
        _contactDic = [NSMutableDictionary dictionary];
        _firstLetterArr = [NSMutableArray array];
        
        NSArray *allContacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(_addressBook));
        
        for (int i = 0 ; i < allContacts.count; i++) {
            
            ABRecordRef person = (__bridge ABRecordRef)(allContacts[i]);
            
            [self createModelWith:person properties:properties];
        }
        
        
        [self sortContactDic];
    }
    else
    {
        NSLog(@"获取通讯录失败");
        
    }
    
    return _contactDic;
}

/**
 *  创建model
 *
 *  @param person     联系人对象
 *  @param properties 所需求的属性
 */
- (void)createModelWith:(ABRecordRef)person properties:(NSArray *)properties{
    
    XZLocalContactModel *model = [[XZLocalContactModel alloc] init];
    
    for (NSString *property in properties) {
        
        if ([property  isEqualToString: FirstName]) {
            
            //名
            model.firstName = [self getContactFirstName:person model:nil];
            
            continue;
            
        }else if ([property isEqualToString:FirstNameWithPhonetic]){
            
            //名的汉语拼音带有音标
            model.firstNameWithPhonetic = [self getContactFirstNameWithPhonetic:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:FirstNameWithoutPhonetic]){
            
            //名的汉语拼音不带有音标
            model.firstNameWithoutPhonetic = [self getContactFirstNameWithoutPhonetic:person model:model];
            
            continue;
            
        }else if([property isEqualToString:FirstNameFirstLetter]){
            
            //名的首字母（大写）PS：需要小写的话，直接在外部转换一下
            model.firstNameFirstLetter = [self getContactFirstNameFirstLetter:person model:model];
            
            continue;
        }
        else if ([property isEqualToString:LastName]){
            
            //姓
            model.lastName = [self getContactLastName:person model:nil];
            
            continue;
            
        }else if([property isEqualToString:LastNameWithPhonetic]){
            
            //姓的汉语拼音带有音标
            model.lastNameWithPhonetic = [self getContactLastNameWithPhonetic:person model:model];
            
            continue;
            
        }else if([property isEqualToString:LastNameWithoutPhonetic]){
            
            //姓的汉语拼音不带有音标
            model.lastNameWithoutPhonetic = [self getContactLastNameWithoutPhonetic:person model:model];
            
            continue;
            
        }else if([property isEqualToString:LastNameFirstLetter]){
            
            //名的首字母（大写）PS：需要小写的话，直接在外部转换一下
            model.lastNameFirstLetter = [self getContactLastNameFirstLetter:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:FullName]){
            
            //全名
            model.fullName = [self getContactFullName:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:FullNameWithPhonetic]){
            
            //全名的汉语拼音带有音标
            model.fullNameWithPhonetic = [self getContactFullNameWithPhonetic:person model:model];
            
            continue;
        }else if([property isEqualToString:FullNameWithoutPhonetic]){
            
            //全名的汉语拼音不带有音标
            model.fullNameWithoutPhonetic = [self getContactFullNameWithoutPhonetic:person model:model];
            
            continue;
            
        }
        else if ([property isEqualToString:PhoneNumber]){
            
            //获取电话号码
            model.phoneNumberDic = [self getContactPhoneNumbers:person model:nil];
            
            continue;
            
        }else if ([property isEqualToString:Email]){
            
            //获得邮箱
            model.emailDic = [self getContactEmails:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:HeadImage]){
            
            model.headImage = [self getContactHeadImage:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:Address]){
            
            model.addressDic =  [self getContactAddress:person model:model];
            
            continue;
            
        }else if ([property isEqualToString:BirthDay]){
            
            model.birthday = [self getContactBirthday:person model:model];
            
            continue;
            
        }else if([property isEqualToString:Url]){
            
            model.urlDic = [self getContactUrl:person model:model];
            
            continue;
            
        }
    }
    
    [self saveContactsToDicByFullNameFirstLetter:person model:model];
    
}

/**
 *  获取联系人名
 */
- (NSString *)getContactFirstName:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    return (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
}

/**
 *  获取名的汉语拼音带有音标
 */
- (NSMutableString *)getContactFirstNameWithPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.firstName) {
        
        inputStr = [NSMutableString stringWithString:model.firstName];
        
    }else{
        
        if ([self getContactFirstName:person model:nil] == nil) {
            
            return nil;
        }
        
        inputStr = [NSMutableString stringWithString:[self getContactFirstName:person model:nil]];
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformMandarinLatin, NO);
    
    return inputStr;
    
    
}

/**
 *  获取名的汉语拼音不带有音标
 */
- (NSMutableString *)getContactFirstNameWithoutPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.firstNameWithPhonetic) {
        
        inputStr = [NSMutableString stringWithString:model.firstNameWithPhonetic];
    }
    else{
        inputStr = [self getContactFirstNameWithPhonetic:person model:model];
    }
    
    if (inputStr == nil) {
        
        return nil;
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformStripCombiningMarks, NO);
    
    return inputStr;
}

/**
 *  获得名的首字母（大写）PS：需要小写的话，直接在外部转换一下
 */
- (NSString *)getContactFirstNameFirstLetter:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSString *firstLetter;
    
    if (model.firstNameWithoutPhonetic) {
        
        firstLetter = [NSString stringWithFormat:@"%@",[[model.firstNameWithoutPhonetic substringToIndex:1] uppercaseString]];
    }else{
        
        NSMutableString *inputStr = [self getContactFirstNameWithoutPhonetic:person model:model];
        
        if (inputStr == nil) {
            
            return nil;
        }
        
        firstLetter = [NSString stringWithFormat:@"%@",[[inputStr substringToIndex:1] uppercaseString]];
    }
    
    return firstLetter;
    
}


/**
 *  获得联系人姓
 */
- (NSString *)getContactLastName:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    return (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
}

/**
 *  获取姓的汉语拼音带有音标
 */
- (NSMutableString *)getContactLastNameWithPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.lastName) {
        
        inputStr = [NSMutableString stringWithString:model.lastName];
        
    }else{
        
        if ([self getContactLastName:person model:nil] == nil) {
            
            return nil;
        }
        
        inputStr = [NSMutableString stringWithString:[self getContactLastName:person model:nil]];
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformMandarinLatin, NO);
    
    return inputStr;
    
    
}

/**
 *  获取姓的汉语拼音不带有音标
 */
- (NSMutableString *)getContactLastNameWithoutPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.lastNameWithPhonetic) {
        
        inputStr = [NSMutableString stringWithString:model.lastNameWithPhonetic];
    }
    else{
        inputStr = [self getContactLastNameWithPhonetic:person model:model];
    }
    
    if (inputStr == nil) {
        
        return nil;
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformStripCombiningMarks, NO);
    
    return inputStr;
}

/**
 *  获得姓的首字母（大写）PS：需要小写的话，直接在外部转换一下
 */
- (NSString *)getContactLastNameFirstLetter:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSString *firstLetter;
    
    if (model.lastNameWithoutPhonetic) {
        
        firstLetter = [NSString stringWithFormat:@"%@",[[model.lastNameWithoutPhonetic substringToIndex:1] uppercaseString]];
    }else{
        
        NSMutableString *inputStr = [self getContactLastNameWithoutPhonetic:person model:model];
        
        if (inputStr == nil) {
            
            return nil;
        }
        
        firstLetter = [NSString stringWithFormat:@"%@",[[inputStr substringToIndex:1] uppercaseString]];
    }
    
    return firstLetter;
    
}

/**
 *  获得全名
 */
- (NSString *)getContactFullName:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSString *fullName;
    
    if (model.firstName != nil && model.lastName != nil) {
        
        fullName = [NSString stringWithFormat:@"%@%@",model.lastName,model.firstName];
    }else{
        
        NSString *firstName = [self getContactFirstName:person model:nil];
        NSString *lastName = [self getContactLastName:person model:nil];
        
        fullName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    }
    
    return fullName;
    
}

/**
 *  获得全名的汉语拼音带有音标
 */
- (NSMutableString *)getContactFullNameWithPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.fullName) {
        
        inputStr = [NSMutableString stringWithString:model.fullName];
    }else{
        
        inputStr = [NSMutableString stringWithString:[self getContactFullName:person model:model]];
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformMandarinLatin, NO);
    
    return inputStr;
}

/**
 *  获得全名的汉语拼音带有音标
 */
- (NSMutableString *)getContactFullNameWithoutPhonetic:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableString *inputStr;
    
    if (model.fullNameWithPhonetic) {
        
        inputStr = [NSMutableString stringWithString:model.fullNameWithPhonetic];
        
        
    }else{
        
        inputStr = [self getContactFullNameWithPhonetic:person model:model];
    }
    
    CFRange inputStrRange = CFRangeMake(0, inputStr.length);
    CFStringTransform((CFMutableStringRef)inputStr, &inputStrRange, kCFStringTransformStripCombiningMarks, NO);
    
    return inputStr;
}

/**
 *  获取全名的首字母（大写）PS：需要小写的话，直接在外部转换一下
 */
- (NSString *)getContactFullNameFirstLetter:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSString *firstLetter;
    
    if (model.fullNameWithoutPhonetic) {
        
        firstLetter = [NSString stringWithFormat:@"%@",[[model.fullNameWithoutPhonetic substringToIndex:1] uppercaseString]];
    }else{
        
        NSMutableString *inputStr = [self getContactFullNameWithoutPhonetic:person model:model];
        
        if (inputStr == nil) {
            
            return nil;
        }
        
        firstLetter = [NSString stringWithFormat:@"%@",[[inputStr substringToIndex:1] uppercaseString]];
    }
    
    return firstLetter;
}

/**
 *  获得电话号码(多值)
 */
- (NSMutableDictionary *)getContactPhoneNumbers:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int j = 0; j< ABMultiValueGetCount(phone); j++) {
        
        NSString *phoneLabel = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, j)));
        
        NSString *phoneNumber = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phone, j));
        
        [dic setObject:phoneNumber forKey:phoneLabel];
        
    }
    
    return dic;
}
/**
 *  获取邮箱地址（多值）
 */
- (NSMutableDictionary *)getContactEmails:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    for (int j = 0; j< ABMultiValueGetCount(email); j++) {
        
        NSString *emailLabel = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, j)));
        
        NSString *emailAddress = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(email, j));
        
        [dic setObject:emailAddress forKey:emailLabel];
        
    }
    
    return dic;
}

/**
 *  获得联系人头像
 */
- (UIImage *)getContactHeadImage:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSData *imageData = (__bridge NSData *)(ABPersonCopyImageData(person));
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}


/**
 *  获得联系人地址
 */
- (NSMutableDictionary *)getContactAddress:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    for (int k = 0; k < ABMultiValueGetCount(address); k++) {
        
        //获得地址Label
        NSString *addressLabel = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(address, k));
        
        //获得该Label下的六个属性
        NSDictionary *addressDic = (__bridge NSDictionary *)(ABMultiValueCopyValueAtIndex(address, k));
        
        [dic setObject:addressDic forKey:addressLabel];
        
    }
    
    return dic;
}

/**
 *  获得生日
 */
- (NSDate *)getContactBirthday:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    
    NSDate *birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
    
    return birthday;
    
    
}

/**
 *  获得联系人链接地址
 */
- (NSMutableDictionary *)getContactUrl:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
    
    for (int m = 0; m < ABMultiValueGetCount(url); m++) {
        
        //获得地址Label
        NSString *urlLabel = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(url, m));
        
        //获得该Label下的六个属性
        NSString *urlStr = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(url, m));
        
        [dic setObject:urlStr forKey:urlLabel];
    }
    
    return dic;
    
}

/**
 *  将联系人按照全名的首字母存入字典
 */
- (void)saveContactsToDicByFullNameFirstLetter:(ABRecordRef)person model:(XZLocalContactModel *)model{
    
    NSString *firstLetter;
    
    firstLetter = [self getContactFullNameFirstLetter:person model:model];
    
    if (firstLetter == nil) {
        
        return;
    }
    
    NSString *rule = @"[A-Z]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule];
    
    if ([predicate evaluateWithObject:firstLetter]) {
        
        NSMutableArray *array;
        
        if ([[_contactDic allKeys] containsObject:firstLetter]) {
            
            array = _contactDic[firstLetter];
        }else{
            
            array = [NSMutableArray array];
        }
        
        [array addObject:model];
        
        [_contactDic setObject:array forKey:firstLetter];
        
    }else{
        
        NSMutableArray *array;
        
        if ([[_contactDic allKeys] containsObject:@"#"]) {
            
            array = _contactDic[@"#"];
        }else{
            
            array = [NSMutableArray array];
        }
        
        [array addObject:model];
        
        [_contactDic setObject:array forKey:@"#"];
    }
    
}

/**
 *  将contactDic按照首字母排序
 */
- (void)sortContactDic{
    
    NSArray *array = [_contactDic allKeys];
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *firstLetterArr = [NSMutableArray arrayWithArray:array];
    if (firstLetterArr.count > 0 && [firstLetterArr[0] isEqualToString:@"#"]) {
        
        [firstLetterArr removeObjectAtIndex:0];
        [firstLetterArr addObject:@"#"];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_contactDic];
    [_contactDic removeAllObjects];
    
    for (NSString *key in firstLetterArr) {
        
        [_contactDic setObject:dic[key] forKey:key];
        
    }
}

@end
