//
//  NSData-AES.m
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import "NSData-AES.h"
#import "rijndael.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData(AES)

- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSData *)AESEncryptWithPassphrase:(NSString *)pass
{
	NSMutableData *ret = [NSMutableData dataWithCapacity:[self length]];
	unsigned long rk[RKLENGTH(KEYBITS)];
	unsigned char key[KEYLENGTH(KEYBITS)];
	const char *password = [pass UTF8String];
	
	for (int i = 0; i < sizeof(key); i++)
		key[i] = password != 0 ? *password++ : 0;
	
	int nrounds = rijndaelSetupEncrypt(rk, key, KEYBITS);
	
	unsigned char *srcBytes = (unsigned char *)[self bytes];
	int index = 0;
	
	while (1) 
	{
		unsigned char plaintext[16];
		unsigned char ciphertext[16];
		int j;
		for (j = 0; j < sizeof(plaintext); j++)
		{
			if (index >= [self length])
				break;
            
			plaintext[j] = srcBytes[index++];
		}
        
		if (j == 0)
        {
            for (int i = 0 ; i < 16; i++) 
                plaintext[i] = 16;
            
            rijndaelEncrypt(rk, nrounds, plaintext, ciphertext);
            [ret appendBytes:ciphertext length:sizeof(ciphertext)];
            break;
        }
        
        int addin = sizeof(plaintext) - j;
        if (j < sizeof(plaintext)) 
        {
            for (; j < sizeof(plaintext); j++)
                plaintext[j] = addin;
            
            rijndaelEncrypt(rk, nrounds, plaintext, ciphertext);
            [ret appendBytes:ciphertext length:sizeof(ciphertext)];
            break;
        }
        
		rijndaelEncrypt(rk, nrounds, plaintext, ciphertext);
		[ret appendBytes:ciphertext length:sizeof(ciphertext)];
	}
	return ret;
}

- (NSData *)AESDecryptWithPassphrase:(NSString *)pass
{
	NSMutableData *ret = [NSMutableData dataWithCapacity:[self length]];
	unsigned long rk[RKLENGTH(KEYBITS)];
	unsigned char key[KEYLENGTH(KEYBITS)];
	const char *password = [pass UTF8String];
	for (int i = 0; i < sizeof(key); i++)
		key[i] = password != 0 ? *password++ : 0;
    
	int nrounds = rijndaelSetupDecrypt(rk, key, KEYBITS);
	unsigned char *srcBytes = (unsigned char *)[self bytes];
	int index = 0;
	while (index < [self length])
	{
		unsigned char plaintext[16];
		unsigned char ciphertext[16];
		int j;
		for (j = 0; j < sizeof(ciphertext); j++)
		{
			if (index >= [self length])
				break;
			
			ciphertext[j] = srcBytes[index++];
		}
        
		rijndaelDecrypt(rk, nrounds, ciphertext, plaintext);
        int endIndex=0;
        for(;endIndex < 16; endIndex++)
        {
            if(plaintext[endIndex]==16-endIndex){
                break;
            }
        }
		[ret appendBytes:plaintext length:endIndex];
	}
    
	return ret;
}

- (NSData *)newAESEncryptWithPassphrase:(NSString *)pass
{
    NSData* originalData = [self AESEncryptWithPassphrase:pass];
    
    NSMutableString *pStr = [[NSMutableString alloc] initWithCapacity:1];
    UInt8 *p = (UInt8*)[originalData bytes];
    NSUInteger len = [originalData length];
    for (int i = 0; i < len; i++)
        [pStr appendFormat:@"%02x", *(p + i)];
    
    const char* finalStr = [pStr UTF8String];
    [pStr release];
    NSData* finalData = [NSData dataWithBytes:finalStr length:strlen(finalStr)];
	return [finalData retain];//燕
}

- (NSData *)newAESDecryptWithPassphrase:(NSString *)pass
{
    NSString* hexStr = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    NSUInteger len = [hexStr length] / 2;
    UInt8* encryptStr = malloc(len);
    for (int i = 0; i < len; i++)
    {
        char *subChar = (char *)[[hexStr substringWithRange:NSMakeRange((i * 2), 2)] UTF8String];
        int subValue = 0;
        sscanf(subChar, "%x", &subValue);
        encryptStr[i] = (UInt8)subValue;
    }
    [hexStr release];
    
    NSData* encryptData = [NSData dataWithBytes:(const char*)encryptStr length:len];
    NSData* finalData = [encryptData AESDecryptWithPassphrase:pass];
    return [finalData copy];//燕
}
- (NSData *)newAESDecryptWithPassphraseNSUTF16LittleEndianStringEncoding:(NSString *)pass
{
    NSString* hexStr = [[NSString alloc] initWithData:self encoding:NSUTF16LittleEndianStringEncoding];
    NSUInteger len = [hexStr length] / 2;
    UInt8* encryptStr = malloc(len);
    for (int i = 0; i < len; i++)
    {
        char *subChar = (char *)[[hexStr substringWithRange:NSMakeRange((i * 2), 2)] UTF8String];
        int subValue = 0;
        sscanf(subChar, "%x", &subValue);
        encryptStr[i] = (UInt8)subValue;
    }
    [hexStr release];
    
    NSData* encryptData = [NSData dataWithBytes:(const char*)encryptStr length:len];
    NSData* finalData = [encryptData AESDecryptWithPassphrase:pass];
    return [finalData copy];//燕
}


static char Base64encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

- (NSString *) base64Encode
{
	if ([self length] == 0)
		return @"";
	
    char *characters = malloc((([self length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	NSUInteger i = 0;
	
	while (i < [self length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [self length])
			buffer[bufferLength++] = ((char *)[self bytes])[i++];
		
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = Base64encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = Base64encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = Base64encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = Base64encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';
	}
    
	return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] autorelease];
}

@end

@implementation NSString(md5)

- (NSString *)MD5Encrypt;
{	
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString 
			stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1],
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15]
			];
}

@end

@implementation NSString(Base64)
#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

- (NSString*)Base64
{
	if ([self length] == 0)
		return @"";
	
    char *characters = malloc((([self length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (i < [self length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [self length])
			buffer[bufferLength++] = ((char *)[self UTF8String])[i++];
		
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';	
	}
	
	return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] autorelease];
}

@end
