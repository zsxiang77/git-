//
//  ErWeiMaView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/29.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ErWeiMaView.h"
#import "CheDianZhangCommon.h"

@implementation ErWeiMaView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        UIView *backV = [[UIView alloc]init];
        [backV.layer setMasksToBounds:YES];
        [backV.layer setCornerRadius:3];
        backV.backgroundColor = [UIColor whiteColor];
        [self addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(250);
        }];
        
        
        self.mainImageView = [[UIImageView alloc]init];
        [backV addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(backV);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(200);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(disMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

-(void)disMissView
{
    self.hidden = YES;
}

@end
