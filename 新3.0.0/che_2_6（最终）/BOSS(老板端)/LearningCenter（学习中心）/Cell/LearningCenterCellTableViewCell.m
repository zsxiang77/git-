//
//  LearningCenterCellTableViewCell.m
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningCenterCellTableViewCell.h"

@implementation LearningCenterCellTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        leftuImgView=[[UIImageView alloc]init];
        [self.contentView addSubview:leftuImgView];
        leftuImgView.backgroundColor=[UIColor redColor];
        if(kWindowW>320){
            [leftuImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8);
                make.centerY.mas_equalTo(self.contentView);
                make.width.mas_equalTo(158);
                make.height.mas_equalTo(113);
            }];
        }else{
            [leftuImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8*0.8);
                make.centerY.mas_equalTo(self.contentView);
                make.width.mas_equalTo(158*0.8);
                make.height.mas_equalTo(113*0.8);
            }];
        }
        
        titleUilable=[[UILabel alloc]init];
        [self.contentView addSubview:titleUilable];
        titleUilable.numberOfLines=0;
        titleUilable.font=[UIFont systemFontOfSize:16];
        [titleUilable setTextColor:kRGBColor(74, 74, 74)];
        if(kWindowW>320){
            [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24);
                make.top.mas_equalTo(11);
                make.right.mas_equalTo(-12);
            }];
        }else{
            [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24*0.8);
                make.top.mas_equalTo(11*0.8);
                make.right.mas_equalTo(-12*0.8);
            }];
        }
        
        zuixinImgView=[[UIImageView alloc]init];
        zuixinImgView.image=[UIImage imageNamed:@"zuixin"];
        [titleUilable addSubview:zuixinImgView];
        if(kWindowW>320){
            [zuixinImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2);
                make.top.mas_equalTo(2);
                make.height.mas_equalTo(14);
                make.width.mas_equalTo(20);
            }];
        }else{
            [zuixinImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2*0.8);
                make.top.mas_equalTo(2*0.8);
                make.height.mas_equalTo(14*0.8);
                make.width.mas_equalTo(20*0.8);
            }];
        }
     
        zhujiangUilable=[[UILabel alloc]init];
        [self.contentView addSubview:zhujiangUilable];
        zhujiangUilable.font=[UIFont systemFontOfSize:13];
        [zhujiangUilable setTextColor:kRGBColor(153, 153, 153)];
        if(kWindowW>320){
            [zhujiangUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24);
                make.bottom.mas_equalTo(-55);
                make.top.mas_equalTo(titleUilable.mas_bottom).mas_equalTo(12);
            }];
        }else{
            [zhujiangUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24*0.8);
                make.bottom.mas_equalTo(-55*0.8);
                make.top.mas_equalTo(titleUilable.mas_bottom).mas_equalTo(12*0.8);
            }];
        }
        
        UIImageView *reimg=[[UIImageView alloc]init];
        reimg.image=[UIImage imageNamed:@"remen"];
        [self.contentView addSubview:reimg];
        if(kWindowW>320){
            [reimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zhujiangUilable.mas_right).mas_equalTo(16);
                make.centerY.mas_equalTo(zhujiangUilable);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(14);
            }];
        }else{
            [reimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zhujiangUilable.mas_right).mas_equalTo(16*0.8);
                make.centerY.mas_equalTo(zhujiangUilable);
                make.width.mas_equalTo(30*0.8);
                make.height.mas_equalTo(14*0.8);
            }];
        }
        
        redioshuUilable=[[UILabel alloc]init];
        redioshuUilable.font=[UIFont systemFontOfSize:13];
        [redioshuUilable setTextColor:kRGBColor(208, 2, 27)];
        [self.contentView addSubview:redioshuUilable];
        if(kWindowW>320){
            [redioshuUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(reimg.mas_right).mas_equalTo(5);
                make.centerY.mas_equalTo(reimg);
                // make.right.mas_equalTo(-48);
            }];
        }else{
            [redioshuUilable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(reimg.mas_right).mas_equalTo(5*0.8);
                make.centerY.mas_equalTo(reimg);
                // make.right.mas_equalTo(-48);
            }];
        }
        
        
        dianzanImgView=[[UIImageView alloc]init];
        [self.contentView addSubview:dianzanImgView];
        if(kWindowW>320){
            [dianzanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24);
                make.bottom.mas_equalTo(-14);
                make.width.mas_equalTo(20);
                make.height.mas_equalTo(18);
            }];
        }else{
            [dianzanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24*0.8);
                make.bottom.mas_equalTo(-14*0.8);
                make.width.mas_equalTo(20*0.8);
                make.height.mas_equalTo(18*0.8);
            }];
        }
        
        dianzanCount=[[UILabel alloc]init];
        dianzanCount.font=[UIFont systemFontOfSize:16];
        [dianzanCount setTextColor:kRGBColor(155, 155, 155)];
        [self.contentView addSubview:dianzanCount];
        if(kWindowW>320){
            [dianzanCount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dianzanImgView.mas_right).mas_equalTo(4);
                make.centerY.mas_equalTo(dianzanImgView);
                
            }];
        }else{
            [dianzanCount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dianzanImgView.mas_right).mas_equalTo(4*0.8);
                make.centerY.mas_equalTo(dianzanImgView);
                
            }];
        }
        
        UIButton *shoucangBtn=[[UIButton alloc]init];
        [self.contentView addSubview:shoucangBtn];
        [shoucangBtn addTarget:self action:@selector(shoucangClick:) forControlEvents:UIControlEventTouchUpInside];
        if(kWindowW>320){
            [shoucangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24);
                make.bottom.mas_equalTo(-14);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(30);
            }];
        }else{
            [shoucangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftuImgView.mas_right).mas_equalTo(24*0.8);
                make.bottom.mas_equalTo(-14*0.8);
                make.width.mas_equalTo(100*0.8);
                make.height.mas_equalTo(30*0.8);
            }];
        }
        
        shoucangImgView=[[UIImageView alloc]init];
        shoucangImgView.image=[UIImage imageNamed:@"shoucangchenggong"];
        shoucangImgView.hidden=YES;
        [self.contentView addSubview:shoucangImgView];
        if(kWindowW>320){
            [shoucangImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dianzanCount.mas_right).mas_equalTo(1);
                make.centerY.mas_equalTo(dianzanCount);
                make.width.mas_equalTo(90);
                make.height.mas_equalTo(24);
            }];
        }else{
            [shoucangImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dianzanCount.mas_right).mas_equalTo(1*0.8);
                make.centerY.mas_equalTo(dianzanCount);
                make.width.mas_equalTo(90*0.8);
                make.height.mas_equalTo(24*0.8);
            }];
        }
        
        jiageLable=[[UILabel alloc]init];
        jiageLable.font=[UIFont systemFontOfSize:12];
        [jiageLable setTextColor:kRGBColor(230, 67, 64)];
        [self.contentView addSubview:jiageLable];
        if(kWindowW>320){
            [jiageLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(dianzanCount);
                make.right.mas_equalTo(-14);
            }];
        }else{
            [jiageLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(dianzanCount);
                make.right.mas_equalTo(-14*0.8);
            }];
        }
        
        
        UILabel*line=[[UILabel alloc]init];
        line.backgroundColor=kRGBColor(200, 199, 204);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)refleshData:(LearningModel*)dict withIndex:(NSIndexPath*)index{
    self.zhuModel=dict;
    self.indexPath=index;
    [leftuImgView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing_new")];
    if([dict.is_new boolValue]==YES){
        titleUilable.text=[NSString stringWithFormat:@"     %@",dict.title];
        zuixinImgView.hidden=NO;
    }else{
       titleUilable.text=[NSString stringWithFormat:@"%@",dict.title];
        zuixinImgView.hidden=YES;
    }
    if([dict.user_coll boolValue]==YES){
          dianzanImgView.image=[UIImage imageNamed:@"shoucang"];
          [dianzanCount setTextColor:kRGBColor(208, 2, 27)];
    }else{
          dianzanImgView.image=[UIImage imageNamed:@"bushoucang"];
          [dianzanCount setTextColor:kRGBColor(155, 155, 155)];
    }
    zhujiangUilable.text=[NSString stringWithFormat:@"主讲人:%@",dict.teacher];
    redioshuUilable.text=[NSString stringWithFormat:@"%@万",dict.playnum];
    dianzanCount.text=dict.likenum;
    jiageLable.text=[NSString stringWithFormat:@"¥%@",dict.price];
    if(dict.chuanzhiMain==YES){
        shoucangImgView.hidden=NO;
        dict.chuanzhiMain=NO;
        //    倒计时时间
        __block NSInteger timeOut = 1;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //    每秒执行一次
        dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(source, ^{
            
            //倒计时结束，关闭
            if (timeOut <= 0) {
                dispatch_source_cancel(source);
                dispatch_async(dispatch_get_main_queue(), ^{
                    shoucangImgView.hidden=YES;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                });
                timeOut--;
            }
        });
        dispatch_resume(source);
    }
}
-(void)shoucangClick:(UIButton*)sender{
    self.changePartst(self.zhuModel,self.indexPath);
}
@end
