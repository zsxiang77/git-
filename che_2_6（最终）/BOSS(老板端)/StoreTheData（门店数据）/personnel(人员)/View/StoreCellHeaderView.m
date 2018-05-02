//
//  StoreCellHeaderView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreCellHeaderView.h"

@implementation StoreCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        UIView *shangview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW,130/2)];
        [self  addSubview:shangview];
        UILabel * line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [shangview addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
         touImgview = [[UIImageView alloc]init];
        [shangview addSubview:touImgview];
        [touImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(shangview);
            make.height.mas_equalTo(56/2);
            make.width.mas_equalTo(66/2);
        }];
        shunxuLable = [[UILabel alloc]init];
        shunxuLable.font =[UIFont systemFontOfSize:17];
        [shunxuLable setTextColor:kRGBColor(74, 74, 74)];
        [shangview addSubview:shunxuLable];
        [shunxuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(shangview);
        }];
        
        renYuanimgview = [[UIImageView alloc]init];
        [renYuanimgview.layer setMasksToBounds:YES];
        [renYuanimgview.layer setCornerRadius:18];
        [shangview addSubview:renYuanimgview];
        [renYuanimgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(touImgview.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(shangview);
            make.height.mas_equalTo(72/2);
            make.width.mas_equalTo(72/2);
        }];
        
        nameLable= [[UILabel alloc]init];
        nameLable.font =[UIFont systemFontOfSize:16];
        [nameLable setTextColor:kRGBColor(132, 148, 165)];
        [shangview addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renYuanimgview.mas_right).mas_equalTo(9);
            make.centerY.mas_equalTo(shangview);
        }];
       
        xingZhiLable = [[UILabel alloc]init];
        [xingZhiLable.layer setMasksToBounds:YES];
        [xingZhiLable.layer setCornerRadius:38/4];
        xingZhiLable.textAlignment = NSTextAlignmentCenter;
        xingZhiLable.font = [UIFont systemFontOfSize:14];
        [xingZhiLable setTextColor:kRGBColor(255,255,255)];
        xingZhiLable.backgroundColor = kRGBColor(74,144,226);
        [shangview addSubview:xingZhiLable];
        [xingZhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(13);
            make.height.mas_equalTo(38/2);
            make.width.mas_equalTo(166/4);
        }];
        
        timeLable = [[UILabel alloc]init];
        timeLable.font = [UIFont systemFontOfSize:14];
        [timeLable setTextColor:kRGBColor(155,155,155)];
        [shangview addSubview:timeLable];
        [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-9);
        }];
        //绘画图形
        self.drawView = [[DrawView alloc] initWithFrame:CGRectMake(0,130/2,kWindowW,492/2)];
        self.drawView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.drawView];
        
        UIView * rectView = [[UIView alloc]init];
        [rectView.layer setMasksToBounds:YES];
        [rectView.layer  setCornerRadius:5];
        [rectView.layer setBorderWidth:0.1];
        [rectView.layer setBorderColor:(kRGBColor(74, 74, 74)).CGColor];
        [self addSubview:rectView];
        [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.drawView.mas_bottom).mas_equalTo(0);
            make.bottom.mas_equalTo(-21);
        }];
        
        yueFenYejiLable = [[UILabel alloc]init];
        yueFenYejiLable.font = [UIFont boldSystemFontOfSize:17];
        
        [yueFenYejiLable setTextColor:kRGBColor(74, 74, 74)];
        [rectView addSubview:yueFenYejiLable ];
        [yueFenYejiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(9);
        }];
        yejiZhiLable =  [[UILabel alloc]init];
        yejiZhiLable.font = [UIFont systemFontOfSize:20];
        [yejiZhiLable setTextColor:kRGBColor(228,84,71)];
        [rectView addSubview:yejiZhiLable ];
        [yejiZhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(yueFenYejiLable);
        }];
        
        UILabel * jiecheCar = [[UILabel alloc]init];
        jiecheCar.font = [UIFont systemFontOfSize:14];
        [jiecheCar setTextColor:kRGBColor(155, 155, 155)];
        jiecheCar.textAlignment = NSTextAlignmentRight;
        jiecheCar.text = @"接车台次:";
        [rectView addSubview:jiecheCar ];
        [jiecheCar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
            make.top.mas_equalTo(yueFenYejiLable.mas_bottom).mas_equalTo(10);
        }];
        jiecheTaishuLable = [[UILabel alloc]init];
        jiecheTaishuLable.font = [UIFont systemFontOfSize:14];
        [jiecheTaishuLable setTextColor:kRGBColor(155, 155, 155)];
        jiecheTaishuLable.textAlignment = NSTextAlignmentRight;
        [rectView addSubview:jiecheTaishuLable ];
        [jiecheTaishuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(jiecheCar);
        }];
        
        
        
        
        
        UILabel * kedanJia = [[UILabel alloc]init];
        kedanJia.font = [UIFont systemFontOfSize:14];
        [kedanJia setTextColor:kRGBColor(155, 155, 155)];
        kedanJia.textAlignment = NSTextAlignmentRight;
        kedanJia.text = @"客单价:";
        [rectView addSubview:kedanJia ];
        [kedanJia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
            make.top.mas_equalTo(jiecheCar.mas_bottom).mas_equalTo(10);
        }];
        keDanjiaLable = [[UILabel alloc]init];
        keDanjiaLable.font = [UIFont systemFontOfSize:14];
        [keDanjiaLable setTextColor:kRGBColor(155, 155, 155)];
        keDanjiaLable.textAlignment = NSTextAlignmentRight;
        [rectView addSubview:keDanjiaLable ];
        [keDanjiaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(kedanJia);
        }];
        
       UILabel * wanchengdu = [[UILabel alloc]init];
        wanchengdu.font = [UIFont systemFontOfSize:16];
        [wanchengdu setTextColor:kRGBColor(74, 74, 74)];
        wanchengdu.text = @"事件完成度";
        [rectView addSubview:wanchengdu ];
        [wanchengdu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-6);
        }];
   
        wancheduZhiLable = [[UILabel alloc]init];
        wancheduZhiLable.font = [UIFont systemFontOfSize:17];
        [wancheduZhiLable setTextColor:kRGBColor(89,216,160)];
        wancheduZhiLable.textAlignment = NSTextAlignmentRight;
        [rectView addSubview:wancheduZhiLable ];
        [wancheduZhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(wanchengdu);
        }];
        passJinduTiao = [[UIView alloc]init];
        passJinduTiao.backgroundColor = kLineBgColor;
        [rectView addSubview:passJinduTiao];
        [passJinduTiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(wanchengdu.mas_right).mas_equalTo(75);
            make.right.mas_equalTo(wancheduZhiLable.mas_left).mas_equalTo(-10);
            make.centerY.mas_equalTo(wancheduZhiLable);
            make.height.mas_equalTo(2);
        }];
        jinduLable = [[UILabel alloc]init];
        jinduLable.backgroundColor = kRGBColor(89,216,160);
        jinduLable.frame = CGRectMake(0, 0, passJinduTiao.frame.size.width, passJinduTiao.frame.size.height);
        [passJinduTiao addSubview:jinduLable];
    }
    return self;
}

-(void)reloadData
{
    if(self.indexRow == 1){
        touImgview.image = [UIImage imageNamed:@"huangGuan1"];
        shunxuLable.hidden = YES;
    }else if(self.indexRow ==2){
        touImgview.image = [UIImage imageNamed:@"huangGuan2"];
        shunxuLable.hidden = YES;
    }else if(self.indexRow ==3){
        touImgview.image = [UIImage imageNamed:@"huangGuan3"];
        shunxuLable.hidden = YES;
    }else{
        shunxuLable.hidden = NO;
        shunxuLable.text = [NSString stringWithFormat:@"%ld",self.indexRow];
    }
    nameLable.text = self.modes.real_name;
    [renYuanimgview sd_setImageWithURL:[NSURL URLWithString:self.modes.avatar] placeholderImage:DJImageNamed(@"Boss_fond_beijing_new")];
    if([self.dataModel.ability.abilitynum integerValue]>90 ){
        xingZhiLable.text = @"五星";
    }else if([self.dataModel.ability.abilitynum integerValue]>70){
        xingZhiLable.text = @"四星";
    }else if([self.dataModel.ability.abilitynum integerValue]>60){
        xingZhiLable.text = @"三星";
    }else{
        xingZhiLable.text = @"二星";
    }
    timeLable.text = [NSString stringWithFormat:@"评估时间:%@",self.dataModel.time];
    yejiZhiLable.text = [NSString stringWithFormat:@"%@元",self.dataModel.achievement.total_price];
    jiecheTaishuLable.text = [NSString stringWithFormat:@"%@台",self.dataModel.achievement.car_num];
    keDanjiaLable.text = [NSString stringWithFormat:@"%@元",self.dataModel.achievement.price];
    wancheduZhiLable.text = [NSString stringWithFormat:@"%@",self.dataModel.task];
    NSString *a = [NSString stringWithFormat:@"%@",self.dataModel.task];
    NSString *b = [a substringToIndex:[a length]-1];
    jinduLable.frame = CGRectMake(0, 0, passJinduTiao.frame.size.width*[b floatValue]/100, passJinduTiao.frame.size.height);
    NSString * str = [NSString stringWithFormat:@"%@",self.dataModel.time];
    NSString *str2 = [str substringWithRange:NSMakeRange(5,2)];
    NSInteger shuzi = [str2 integerValue]+1;
    yueFenYejiLable.text =[NSString stringWithFormat:@"%ld月业绩",shuzi];
    self.drawView.nameArr = @[@"销售业绩",@"客户拉新",@"客户维系",@"业务挖掘",@"工作完成"];
    NSString * xiaoshou = self.dataModel.ability.abilitydetail.sales;
    NSString * kehuNew =  self.dataModel.ability.abilitydetail.newconsumer;
    NSString * kehuWeixi =  self.dataModel.ability.abilitydetail.customer;
    NSString * yeWuWajue =  self.dataModel.ability.abilitydetail.excavate;
    NSString * workWajue =  self.dataModel.ability.abilitydetail.work;
    self.drawView.progressArr = @[xiaoshou,kehuNew,kehuWeixi,yeWuWajue,workWajue];
    self.drawView.nengLizhi =[NSString stringWithFormat:@"%@",self.dataModel.ability.abilitynum];
}
@end
