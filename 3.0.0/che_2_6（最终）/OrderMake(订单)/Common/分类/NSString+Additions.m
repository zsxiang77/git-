//
//  NSString+Additions.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)isEmptyOrWhitespace {
    return self == nil ||
    !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ||
    [self isEqual:[NSNull null]] ||
    [self isEqual:@"(null)"];
}

@end
