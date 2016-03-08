//
//  NSData+AES256.h
//  Decathlon
//
//  Created by 徐章 on 15/11/25.
//  Copyright © 2015年 夏文强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES256)

//加密
- (NSData *)aes256_encrypt:(NSString *)key;
//解密
- (NSData *)aes256_decrypt:(NSString *)key;


@end
