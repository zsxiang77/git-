//
//  zuoYouViewButton.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "zuoYouViewButton.h"
#import "CheDianZhangCommon.h"

@implementation zuoYouViewButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:self.frame.size.height/2];
    }
    return self;
}

-(void)setZuoYouBackColor:(UIColor *)color withZuoText:(NSString *)zuoText withYouText:(NSString *)youText
{
    self.backgroundColor = color;
    zuoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2+10, self.frame.size.height)];
    zuoLabel.font = [UIFont systemFontOfSize:14];
    zuoLabel.textAlignment = NSTextAlignmentCenter;
    zuoLabel.text = zuoText;
    [self addSubview:zuoLabel];
    
    youLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-10, 0, self.frame.size.width/2+10, self.frame.size.height)];
    youLabel.font = [UIFont systemFontOfSize:14];
    youLabel.text = zuoText;
    youLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:youLabel];
    
    mainBt = [[UIButton alloc]init];
    [mainBt addTarget:self action:@selector(mainBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:mainBt];
    [mainBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}

-(void)mainBtChick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

@end
