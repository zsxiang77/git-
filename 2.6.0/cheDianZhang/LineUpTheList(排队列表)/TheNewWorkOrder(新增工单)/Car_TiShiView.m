//
//  Car_TiShiView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "Car_TiShiView.h"
#import "CheDianZhangCommon.h"

@implementation Car_TiShiView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        self.beiJingView = [[UIView alloc]init];
        self.beiJingView.backgroundColor = kRGBColor(244, 245, 246);
        [_beiJingView.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_beiJingView.layer setCornerRadius:3];
        [self addSubview:_beiJingView];
        [_beiJingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(100);
            make.height.mas_equalTo(320);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"提示信息";
        [_beiJingView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        for (int i = 0; i<3; i++) {
            UIView *bujuView = [[UIView alloc]init];
            bujuView.backgroundColor = [UIColor whiteColor];
            [self.beiJingView addSubview:bujuView];
            if (i== 0) {
                [bujuView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(40);
                    make.left.right.mas_equalTo(0);
                    make.height.mas_equalTo(90);
                }];
            }else if (i== 1) {
                [bujuView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(135);
                    make.left.right.mas_equalTo(0);
                    make.height.mas_equalTo(90);
                }];
            }else if (i== 2) {
                [bujuView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(230);
                    make.left.right.mas_equalTo(0);
                    make.height.mas_equalTo(90);
                }];
            }
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleLabel.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
            [titleLabel.layer setCornerRadius:25/2];
            [bujuView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(5);
                make.height.mas_equalTo(25);
                make.width.mas_equalTo(60);
            }];
            titleLabel.textColor = [UIColor whiteColor];
            if (i == 0) {
                titleLabel.backgroundColor = [UIColor greenColor];
                titleLabel.text = @"保险";
            }else if (i == 1) {
                titleLabel.backgroundColor = [UIColor blueColor];
                titleLabel.text = @"记录";
            }else if (i == 2) {
                titleLabel.backgroundColor = [UIColor orangeColor];
                titleLabel.text = @"保养";
            }
            
            UILabel *shangLabel = [[UILabel alloc]init];
            shangLabel.font = [UIFont systemFontOfSize:13];
            [bujuView addSubview:shangLabel];
            [shangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(titleLabel.mas_bottom);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(100);
            }];
            
            if (i == 0) {
                shangLabel.text =  @"商业险到期时间";
                
                self.label1 = [[UILabel alloc]init];
                self.label1.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label1];
                [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shangLabel.mas_right);
                    make.centerY.mas_equalTo(shangLabel);
                }];
                
            }else if (i == 1) {
                shangLabel.text =  @"上次来店时间";
                self.label3 = [[UILabel alloc]init];
                self.label3.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label3];
                [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shangLabel.mas_right);
                    make.centerY.mas_equalTo(shangLabel);
                }];
            }else if (i == 2) {
                shangLabel.text =  @"下次保养时间";
                self.label5 = [[UILabel alloc]init];
                self.label5.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label5];
                [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shangLabel.mas_right);
                    make.centerY.mas_equalTo(shangLabel);
                }];
            }
            
            UILabel *xiaLabel = [[UILabel alloc]init];
            xiaLabel.font = [UIFont systemFontOfSize:13];
            [bujuView addSubview:xiaLabel];
            [xiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(shangLabel.mas_bottom);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(100);
            }];
            
            if (i == 0) {
                xiaLabel.text =  @"交强险到期时间";
                self.label2 = [[UILabel alloc]init];
                self.label2.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label2];
                [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(xiaLabel.mas_right);
                    make.centerY.mas_equalTo(xiaLabel);
                }];
            }else if (i == 1) {
                xiaLabel.text =  @"维修记录";
                self.label4 = [[UILabel alloc]init];
                self.label4.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label4];
                [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(xiaLabel.mas_right);
                    make.centerY.mas_equalTo(xiaLabel);
                }];
            }else if (i == 2) {
                xiaLabel.text =  @"需保养里程";
                self.label6 = [[UILabel alloc]init];
                self.label6.font = [UIFont systemFontOfSize:13];
                [bujuView addSubview:self.label6];
                [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(xiaLabel.mas_right);
                    make.centerY.mas_equalTo(xiaLabel);
                }];
            }
            
        }
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(vietualViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

-(void)sheZhiDataWithDict:(NSDictionary *)dict
{
    NSDictionary *insurance = KISDictionaryHaveKey(dict, @"insurance");
    NSDictionary *maintain = KISDictionaryHaveKey(dict, @"maintain");
    NSDictionary *repair = KISDictionaryHaveKey(dict, @"repair");
    
    self.label1.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(insurance, @"VCI_expire")];
    self.label2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(insurance, @"TCI_expire")];
    
    self.label3.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(repair, @"last_repair_date")];
    self.label4.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(repair, @"count")];
    
    self.label5.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(maintain, @"next_maintain_date")];
    self.label6.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(maintain, @"next_maintain_km")];
}

-(void)vietualViewTouch:(id)sender
{
    
    [self dismissYingCang];
}
-(void)dismissYingCang
{
    self.hidden = YES;
}

@end
