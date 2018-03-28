//
//  NSObject+Parse.m
//  live
//
//  Created by BigData on 16/5/9.
//  Copyright © 2016年 bigdata. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+ (id)parseJSON:(id)json{
    if ([json isKindOfClass:[NSArray class]]) {
        
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    return [self modelWithJSON:json];
}

@end
