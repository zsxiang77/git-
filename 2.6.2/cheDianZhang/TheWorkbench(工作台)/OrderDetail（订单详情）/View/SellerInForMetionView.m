//
//  SellerInForMetionView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SellerInForMetionView.h"
#import "CheDianZhangCommon.h"
#import "UIImageView+WebCache.h"

@implementation SellerInForMetionView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        CGFloat jiSuanGao = 0;
        zhuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 170)];
        [zhuView.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [zhuView.layer setCornerRadius:5];
        zhuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:zhuView];
        
        UILabel *titLa = [[UILabel alloc]init];
        titLa.text = @"销售人员";
        titLa.textAlignment = NSTextAlignmentCenter;
        [zhuView addSubview:titLa];
        [titLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        jiSuanGao+= 40;
        
        zhuImageView = [[UIImageView alloc]init];
        [zhuView addSubview:zhuImageView];
        [zhuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.width.height.mas_equalTo(50);
            make.centerX.mas_equalTo(zhuView);
        }];
        
        jiSuanGao+= 50;
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [zhuView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(90);
            make.centerX.mas_equalTo(zhuView);
            make.height.mas_equalTo(25);
        }];
        
        jiSuanGao+= 25;


        
        phonebt = [[UIButton alloc]init];
        phonebt.titleLabel.font = [UIFont systemFontOfSize:13];
        [zhuView addSubview:phonebt];
        [phonebt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(jiSuanGao);
        }];
        
        jiSuanGao+= 30;
        
        zhuView.frame = CGRectMake(20, (kWindowH-jiSuanGao)/2, kWindowW-40, jiSuanGao+5);
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(disMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)setYeMianWithOrderDetailModel:(OrderDetailModel *)zhuModel
{
    NSDictionary *dict = zhuModel.seller;
    [zhuImageView  sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(dict, @"images")] placeholderImage:DJImageNamed(@"")];
    nameLabel.text = KISDictionaryHaveKey(dict, @"real_name");
    [phonebt setTitle:KISDictionaryHaveKey(dict, @"mobile") forState:(UIControlStateNormal)];
    [phonebt setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
}

-(void)disMissView
{
    self.hidden = YES;
}

@end
