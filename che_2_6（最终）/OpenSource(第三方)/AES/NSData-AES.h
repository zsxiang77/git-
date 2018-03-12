//
//  NSData-AES.h
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

// Supported keybit values are 128, 192, 256
#define KEYBITS		(128)
#define AESEncryptionErrorDescriptionKey	@"description"

@interface NSData(AES)
- (NSString *)md5String;

- (NSData *)AESEncryptWithPassphrase:(NSString *)pass;
- (NSData *)AESDecryptWithPassphrase:(NSString *)pass;
- (NSData *)newAESEncryptWithPassphrase:(NSString *)pass;
- (NSData *)newAESDecryptWithPassphrase:(NSString *)pass;
- (NSData *)newAESDecryptWithPassphraseNSUTF16LittleEndianStringEncoding:(NSString *)pass;

- (NSString*)base64Encode;

@end

@interface NSString(MD5)

- (NSString*)MD5Encrypt;

@end

@interface NSString(Base64)

- (NSString*)Base64;

@end






