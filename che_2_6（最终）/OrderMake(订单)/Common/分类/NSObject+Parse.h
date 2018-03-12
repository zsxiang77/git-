//
//  NSObject+Parse.h
//  live
//
//  Created by BigData on 16/5/9.
//  Copyright © 2016年 bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"
#import "YYClassInfo.h"

@interface NSObject (Parse)

/** 复制协议 */
#define kCopyZoneMethod \
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }

/** 归档解档协议 */
#define kCodingMethod \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super initWithCoder:aDecoder]; return [self modelInitWithCoder:aDecoder]; }

/** 判断对象相等方法 */
#define kEqualObjMethod \
- (BOOL)isEqual:(id)object {\
return [self modelIsEqual:object];\
}

/** 自动完成对象描述 */
#define kDescriptionMethod \
- (NSString *)description { return [self modelDescription]; }

/** 对象Hash */
#define kHashMethod \
- (NSUInteger)hash { return [self modelHash]; }

+ (id)parseJSON:(id)json;

@end







