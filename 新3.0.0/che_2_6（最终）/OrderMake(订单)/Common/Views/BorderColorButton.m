//
//  BorderColorButton.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "BorderColorButton.h"

@implementation BorderColorButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderWidth = CGFloatFromPixel(1);
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"FFFFFF"]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
    }
    else {
        self.layer.borderColor = [UIColor colorWithHexString:@"979797"].CGColor;
    }
}

@end
