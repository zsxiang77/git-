//
//  MaintenanceHistoryCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "MaintenanceHistoryCell.h"

@implementation MaintenanceHistoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
//        UIView *zhuView = [[UIView alloc]init];
//        zhuView
        
        backView = [[UIView alloc]init];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(67/2);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
        
        quanImageView = [[UILabel alloc]init];
        quanImageView.backgroundColor = kZhuTiColor;
        [quanImageView.layer setMasksToBounds:YES];
        [quanImageView.layer setCornerRadius:5];
        [self.contentView addSubview:quanImageView];
        [quanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo((35+20+53/2-10)/2);
            make.width.height.mas_equalTo(10);
        }];
        
        shangXianImageView = [[UILabel alloc]init];
        shangXianImageView.backgroundColor = kZhuTiColor;
        [self.contentView addSubview:shangXianImageView];
        [shangXianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(quanImageView);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(1.5);
            make.bottom.mas_equalTo(quanImageView.mas_top);
        }];
        
        xiaXianImageView = [[UILabel alloc]init];
        xiaXianImageView.backgroundColor = kZhuTiColor;
        [self.contentView addSubview:xiaXianImageView];
        [xiaXianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(quanImageView);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(1.5);
            make.top.mas_equalTo(quanImageView.mas_bottom);
        }];
        
    }
    return self;
}

-(void)tianJiaBeiJing{
    imageBackView = [[UIImageView alloc]init];
    [backView addSubview:imageBackView];
    [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
-(void)refeleseZongCell:(BOOL)shiFouWeiXiu withDict:(NSDictionary *)model withInder:(NSInteger)index withPeiJian:(BOOL)peiJian
{
    while ([backView.subviews lastObject] != nil)
    {
        [[backView.subviews lastObject] removeFromSuperview];
    }
    [self tianJiaBeiJing];
    
    if (index == 0) {
        shangXianImageView.hidden = YES;
    }else{
        shangXianImageView.hidden = NO;
    }
    
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.textColor = kRGBColor(51, 51, 51);
    dateLabel.font = [UIFont systemFontOfSize:11];
    [backView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(53/2);
        make.top.mas_equalTo(7);
    }];
    
    if (shiFouWeiXiu == YES) {
        if (peiJian == NO) {//维修项目
            NSArray *list = KISDictionaryHaveKey(model, @"list");
            dateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"create_time")];
            if (list.count<=1) {
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack");
            }else{
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack2");
            }
            
            for (int i = 0; i<list.count; i++) {
                UILabel *shiShouLabe = [[UILabel alloc]init];
                shiShouLabe.textColor = kRGBColor(133, 133, 133);
                shiShouLabe.font = [UIFont systemFontOfSize:14];
                shiShouLabe.text = @"实收金额：";
                [backView addSubview:shiShouLabe];
                [shiShouLabe mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-80);
                    make.top.mas_equalTo(53/2+35*i);
                }];
                
                UILabel *jieELabel = [[UILabel alloc]init];
                jieELabel.textColor = [UIColor redColor];
                jieELabel.font = [UIFont systemFontOfSize:15];
                jieELabel.text = [NSString stringWithFormat:@"¥%@",KISDictionaryHaveKey(list[i], @"reality_fee")];
                [backView addSubview:jieELabel];
                [jieELabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shiShouLabe.mas_right);
                    make.centerY.mas_equalTo(shiShouLabe);
                }];
                
                UILabel *titleLabel = [[UILabel alloc]init];
                titleLabel.textColor = kRGBColor(74, 74, 74);
                titleLabel.font = [UIFont boldSystemFontOfSize:14];
                titleLabel.numberOfLines = 2;
                titleLabel.adjustsFontSizeToFitWidth = YES;
                titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(list[i], @"subject")];
                [backView addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(53/2);
                    make.centerY.mas_equalTo(shiShouLabe);
                    make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-kWindowW/2);
                }];
            }
        }else{//维修配件
            NSArray *list = KISDictionaryHaveKey(model, @"list");
            dateLabel.text = [NSString stringWithFormat:@"%@ 更换：",KISDictionaryHaveKey(model, @"create_time")];
            if (list.count<=1) {
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack");
            }else{
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack2");
            }
            for (int i = 0; i<list.count; i++) {
                UILabel *shiShouLabe = [[UILabel alloc]init];
                shiShouLabe.textColor = kRGBColor(133, 133, 133);
                shiShouLabe.font = [UIFont systemFontOfSize:14];
                shiShouLabe.text = [NSString stringWithFormat:@"编码：%@",KISDictionaryHaveKey(list[i], @"code")];
                [backView addSubview:shiShouLabe];
                [shiShouLabe mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(kWindowW/2);
                    make.top.mas_equalTo(53/2+35*i);
                }];
                
                UILabel *jieELabel = [[UILabel alloc]init];
                jieELabel.textColor = [UIColor redColor];
                jieELabel.font = [UIFont systemFontOfSize:15];
                jieELabel.text = [NSString stringWithFormat:@"¥%@",KISDictionaryHaveKey(list[i], @"fee")];
                [backView addSubview:jieELabel];
                [jieELabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shiShouLabe.mas_right).mas_equalTo(10);
                    make.centerY.mas_equalTo(shiShouLabe);
                }];
                
                UILabel *titleLabel = [[UILabel alloc]init];
                titleLabel.textColor = kRGBColor(74, 74, 74);
                titleLabel.font = [UIFont boldSystemFontOfSize:14];
                titleLabel.numberOfLines = 2;
                titleLabel.adjustsFontSizeToFitWidth = YES;
                titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(list[i], @"title")];
                [backView addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(53/2);
                    make.centerY.mas_equalTo(shiShouLabe);
                    make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-kWindowW/2);
                }];
            }
        }
    }else{
        if (peiJian == NO) {//洗美项目
            imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack");
            dateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"create_time")];
            UILabel *shiShouLabe = [[UILabel alloc]init];
            shiShouLabe.textColor = kRGBColor(133, 133, 133);
            shiShouLabe.font = [UIFont systemFontOfSize:14];
            shiShouLabe.text = @"实收金额：";
            [backView addSubview:shiShouLabe];
            [shiShouLabe mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-80);
                make.top.mas_equalTo(53/2);
            }];
            
            UILabel *jieELabel = [[UILabel alloc]init];
            jieELabel.textColor = [UIColor redColor];
            jieELabel.font = [UIFont systemFontOfSize:15];
            jieELabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"reality_price")];
            [backView addSubview:jieELabel];
            [jieELabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(shiShouLabe.mas_right);
                make.centerY.mas_equalTo(shiShouLabe);
            }];
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textColor = kRGBColor(74, 74, 74);
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.numberOfLines = 2;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"service")];
            [backView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(53/2);
                make.centerY.mas_equalTo(shiShouLabe);
                make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-kWindowW/2);
            }];
        }else{//洗美配件
            NSArray *list = KISDictionaryHaveKey(model, @"list");
            dateLabel.text = [NSString stringWithFormat:@"%@ 更换：",KISDictionaryHaveKey(model, @"create_time")];
            if (list.count<=1) {
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack");
            }else{
                imageBackView.image = DJImageNamed(@"lishi_saoJiaoBack2");
            }
            
            for (int i = 0; i<list.count; i++) {
                UILabel *shiShouLabe = [[UILabel alloc]init];
                shiShouLabe.textColor = kRGBColor(133, 133, 133);
                shiShouLabe.font = [UIFont systemFontOfSize:14];
                shiShouLabe.text = [NSString stringWithFormat:@"编码：%@",KISDictionaryHaveKey(list[0], @"code")];
                [backView addSubview:shiShouLabe];
                [shiShouLabe mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(kWindowW/2);
                    make.top.mas_equalTo(53/2+35*i);
                }];
                
                UILabel *jieELabel = [[UILabel alloc]init];
                jieELabel.textColor = [UIColor redColor];
                jieELabel.font = [UIFont systemFontOfSize:15];
                jieELabel.text = [NSString stringWithFormat:@"¥%@",KISDictionaryHaveKey(list[i], @"fee")];
                [backView addSubview:jieELabel];
                [jieELabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(shiShouLabe.mas_right).mas_equalTo(10);
                    make.centerY.mas_equalTo(shiShouLabe);
                }];
                
                UILabel *titleLabel = [[UILabel alloc]init];
                titleLabel.textColor = kRGBColor(74, 74, 74);
                titleLabel.font = [UIFont boldSystemFontOfSize:14];
                titleLabel.numberOfLines = 2;
                titleLabel.adjustsFontSizeToFitWidth = YES;
                titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(list[i], @"title")];
                [backView addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(53/2);
                    make.centerY.mas_equalTo(shiShouLabe);
                    make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-kWindowW/2);
                }];
            }
        }
    }
}


@end
