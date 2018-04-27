//
//  WorkQingKuangView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WorkQingKuangView.h"

@implementation WorkQingKuangView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setCornerRadius:10];
        self.layer.shadowColor = kRGBColor(192, 218, 254).CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2;// 阴影扩散的范围控制
        self.layer.shadowOffset = CGSizeMake(0, 0);// 阴影的范围
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
}

@end
