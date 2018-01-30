//
//  JobBoardDeltailChuLICell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/20.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardDeltailChuLICell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardDeltailChuLICell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont systemFontOfSize:17];
        dateLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(32);
            make.top.mas_equalTo(7);
        }];
        
        zuiXinImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_detail_zuiXin")];
        [self.contentView addSubview:zuiXinImageView];
        [zuiXinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(dateLabel);
        }];
        
        xianquFenImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_detail_zuiXin")];
        [self.contentView addSubview:xianquFenImageView];
        [xianquFenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(19);
            make.left.mas_equalTo(8);
            make.centerY.mas_equalTo(dateLabel);
        }];
        
        shangXianLine = [[UILabel alloc]init];
        shangXianLine.backgroundColor = kZhuTiColor;
        [self.contentView addSubview:shangXianLine];
        [shangXianLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(2);
            make.top.mas_equalTo(-1);
            make.bottom.mas_equalTo(xianquFenImageView.mas_top);
            make.centerX.mas_equalTo(xianquFenImageView);
        }];
        
        
        xiaXianLine = [[UILabel alloc]init];
        xiaXianLine.backgroundColor = kZhuTiColor;
        [self.contentView addSubview:xiaXianLine];
        [xiaXianLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(2);
            make.top.mas_equalTo(xianquFenImageView.mas_bottom);
            make.bottom.mas_equalTo(1);
            make.centerX.mas_equalTo(xianquFenImageView);
        }];
        
        jiXueLabel = [[UILabel alloc]init];
        jiXueLabel.font = [UIFont boldSystemFontOfSize:17];
        jiXueLabel.textColor = kZhuTiColor;
        [self.contentView addSubview:jiXueLabel];
        [jiXueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(52);
            make.top.mas_equalTo(33);
        }];
        
        jiXueImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:jiXueImageView];
        [jiXueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(32);
            make.width.height.mas_equalTo(16);
            make.centerY.mas_equalTo(jiXueLabel);
        }];
        
        jiXueDateLabel = [[UILabel alloc]init];
        jiXueDateLabel.font = [UIFont boldSystemFontOfSize:14];
        jiXueDateLabel.adjustsFontSizeToFitWidth = YES;
        jiXueDateLabel.textColor = kZhuTiColor;
        [self.contentView addSubview:jiXueDateLabel];
        [jiXueDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiXueLabel.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(jiXueLabel);
            make.width.mas_equalTo(180);
        }];
        
        beiZhuLabel = [[UILabel alloc]init];
        beiZhuLabel.font = [UIFont systemFontOfSize:14];
        beiZhuLabel.textColor = kRGBColor(155, 155, 155);
        beiZhuLabel.numberOfLines = 0;
        [self.contentView addSubview:beiZhuLabel];
        [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(52);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(59);
        }];
        
        couponView = [[UIView alloc]init];
        couponView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:couponView];
        [couponView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(90);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)refreshIndex:(NSInteger )index withdict:(NSDictionary *)dict xian:(BOOL)xian
{
    if (xian == NO) {
        shangXianLine.hidden = YES;
        xiaXianLine.hidden = YES;
        xianquFenImageView.hidden = NO;
        
    }else{
        shangXianLine.hidden = NO;
        xiaXianLine.hidden = NO;
        xianquFenImageView.hidden = NO;
    }
    if (index == 0) {
        zuiXinImageView.hidden = NO;
        shangXianLine.hidden = YES;
        xianquFenImageView.image = DJImageNamed(@"boss_detail_huiBiaoliang");
    }else{
        zuiXinImageView.hidden = YES;
        xianquFenImageView.image = DJImageNamed(@"boss_detail_huiBiaohui");
    }
    
    dateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"reduce_time")];
    NSDictionary *content = KISDictionaryHaveKey(dict, @"content");
    NSDictionary *append = KISDictionaryHaveKey(content, @"append");
    NSInteger operate_type = [KISDictionaryHaveKey(append, @"operate_type")integerValue];
    jiXueLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(append, @"operate_name")];
    if (operate_type == 1) {
        jiXueDateLabel.text = [NSString stringWithFormat:@"(下次跟进时间：%@)",KISDictionaryHaveKey(append, @"next_time")];
        jiXueImageView.image = DJImageNamed(@"boss_detail_jixu");
    }else if (operate_type == 2) {
        jiXueDateLabel.text = @"";
        jiXueImageView.image = DJImageNamed(@"boss_detail_yuyue");
    }else if (operate_type == 3) {
        jiXueDateLabel.text = @"";
        jiXueImageView.image = DJImageNamed(@"boss_detail_wancheng");
    }else{
        jiXueDateLabel.text = @"";
        jiXueImageView.image = DJImageNamed(@"boss_detail_zhongzhi");
    }
    beiZhuLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(append, @"remark")];
    
    if (index !=0 ) {
        dateLabel.textColor = kRGBColor(188, 188, 188);
        jiXueLabel.textColor = kRGBColor(188, 188, 188);
        jiXueDateLabel.textColor = kRGBColor(188, 188, 188);
        beiZhuLabel.textColor = kRGBColor(188, 188, 188);
        if (operate_type == 1) {
            jiXueImageView.image = DJImageNamed(@"boss_detail_jixuHui");
        }else if (operate_type == 2) {
            jiXueImageView.image = DJImageNamed(@"boss_detail_yuyuehui");
        }else if (operate_type == 3) {
            jiXueImageView.image = DJImageNamed(@"boss_detail_wanchengHui");
        }else{
            jiXueImageView.image = DJImageNamed(@"boss_detail_zhongzhiHui");
        }
    }else{
        dateLabel.textColor = kRGBColor(74, 74, 74);
        jiXueLabel.textColor = kZhuTiColor;
        jiXueDateLabel.textColor = kZhuTiColor;
        beiZhuLabel.textColor = kRGBColor(155, 155, 155);
    }
    
    NSArray *coupon = KISDictionaryHaveKey(content, @"coupon");
    couponView.hidden = YES;
    if (coupon.count>0) {
        couponView.hidden = NO;
        //删除cell的所有子视图
        while ([couponView.subviews lastObject] != nil)
        {
            [(UIView*)[couponView.subviews lastObject] removeFromSuperview];
        }
        UILabel *la = [[UILabel alloc]init];
        la.text = @"赠送优惠券";
        la.font = [UIFont systemFontOfSize:14];
        la.textColor = kZhuTiColor;
        [couponView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(53);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
        UIImageView *im = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_detail_coupon")];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [couponView addSubview:im];
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(17);
            make.centerY.mas_equalTo(la);
            make.left.mas_equalTo(32);
        }];
        
        UIView *vi = [[UIView alloc]init];
        vi.backgroundColor = kRGBColor(243, 246, 255);
        [vi.layer setMasksToBounds:YES];
        [vi.layer setCornerRadius:3];
        [vi.layer setBorderWidth:0.5];
        [vi.layer setBorderColor:kRGBColor(207, 214, 237).CGColor];
        [couponView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(52);
            make.right.mas_equalTo(-8);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(coupon.count*30);
        }];
        
        if (index != 0) {
            im.image = DJImageNamed(@"boss_detail_couponHui");
            la.textColor = kRGBColor(188, 188, 188);
            vi.backgroundColor = kRGBColor(244, 244, 244);
        }
        
        for (int i = 0; i<coupon.count; i++) {
            NSDictionary *dictne = coupon[i];
            UILabel *couponla1 = [[UILabel alloc]init];
            couponla1.font = [UIFont systemFontOfSize:12];
            couponla1.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dictne, @"name")];
            [vi addSubview:couponla1];
            [couponla1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(7);
                make.top.mas_equalTo(i*30);
                make.height.mas_equalTo(30);
            }];
            
            UILabel *couponla2 = [[UILabel alloc]init];
            couponla2.font = [UIFont boldSystemFontOfSize:17];
            couponla2.textColor = kRGBColor(74, 74, 74);
            couponla2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dictne, @"data")];
            [vi addSubview:couponla2];
            [couponla2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-7);
                make.top.mas_equalTo(i*30);
                make.height.mas_equalTo(30);
            }];
            
            UILabel *couponla3 = [[UILabel alloc]init];
            couponla3.font = [UIFont boldSystemFontOfSize:12];
            couponla3.textColor = kRGBColor(110, 110, 110);
            couponla3.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dictne, @"content")];
            [vi addSubview:couponla3];
            [couponla3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(couponla2.mas_left).mas_equalTo(-3);
                make.top.mas_equalTo(i*30);
                make.height.mas_equalTo(30);
            }];
            
            if (index != 0) {
                couponla1.textColor = kRGBColor(188, 188, 188);
                couponla2.textColor = [UIColor grayColor];
                couponla3.textColor = [UIColor grayColor];
            }else{
                couponla2.textColor = kRGBColor(74, 74, 74);
                couponla3.textColor = kRGBColor(110, 110, 110);
                
                
                if ([KISDictionaryHaveKey(dictne, @"type") integerValue] == 11) {
                    couponla1.textColor = UIColorFromRGBA(0XF5A623, 1);
                }else if ([KISDictionaryHaveKey(dictne, @"type") integerValue] == 22) {
                    couponla1.textColor = UIColorFromRGBA(0X5A8494, 1);
                }else if ([KISDictionaryHaveKey(dictne, @"type") integerValue] == 33) {
                    couponla1.textColor = UIColorFromRGBA(0X62AC0D, 1);
                }else if ([KISDictionaryHaveKey(dictne, @"type") integerValue] == 44) {
                    couponla1.textColor = UIColorFromRGBA(0X921212, 1);
                }else if ([KISDictionaryHaveKey(dictne, @"type") integerValue] == 55) {
                    couponla1.textColor = UIColorFromRGBA(0X64340, 1);
                }else{
                    couponla1.textColor = UIColorFromRGBA(0XF5A623, 1);
                }
            }
        }
    }
}

@end
