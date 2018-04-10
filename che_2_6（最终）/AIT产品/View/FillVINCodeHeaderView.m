//
//  FillVINCodeHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillVINCodeHeaderView.h"

@implementation FillVINCodeHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.zhuLabel = [[UILabel alloc]init];
        self.zhuLabel.font = [UIFont systemFontOfSize:16];
        self.zhuLabel.textColor = kRGBColor(74, 74, 74);
        [self addSubview:self.zhuLabel];
        [self.zhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(54/2);
        }];
        
        kWeakSelf(weakSelf)
        self.codeView = [[GTVerifyCodeView alloc] initWithFrame:CGRectMake(0, 44, kWindowW, 33) onFinishedEnterCode:^(NSString *code) {
            weakSelf.codeChange(code);
            if (code.length>=17) {
                weakSelf.shengLabel.hidden = YES;
            }else{
                weakSelf.shengLabel.hidden = NO;
            }
            weakSelf.shengLabel.text = [NSString stringWithFormat:@"还有%ld位",17-code.length];
            if (code.length == 17) {
                weakSelf.renTishilabel.hidden = NO;
            }else{
                weakSelf.renTishilabel.hidden = YES;
            }
        }];
//        self.codeView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.codeView];
        
        self.shengLabel = [[UILabel alloc]init];
        self.shengLabel.textColor = [UIColor grayColor];
        self.shengLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.shengLabel];
        [self.shengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.codeView.mas_bottom).mas_equalTo(5);
        }];
        
        self.renTishilabel = [[UILabel alloc]init];
        self.renTishilabel.hidden = YES;
        self.renTishilabel.text = @"请确认VIN码无误，否则无法接收报告";
        self.renTishilabel.textColor = [UIColor redColor];
        self.renTishilabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.renTishilabel];
        [self.renTishilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.codeView.mas_bottom).mas_equalTo(5);
        }];
    }
    return self;
}

@end
