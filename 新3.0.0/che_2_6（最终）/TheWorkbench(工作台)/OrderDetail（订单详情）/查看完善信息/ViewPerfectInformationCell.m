//
//  ViewPerfectInformationCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ViewPerfectInformationCell.h"
#import "UIImageView+WebCache.h"


@implementation ViewPerfectInformationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.mianView = [[UIView alloc]init];
        self.mianView.backgroundColor = kRGBColor(250, 250, 250);
        [self.mianView.layer setMasksToBounds:YES];
        [self.mianView.layer setBorderWidth:0.5];
        [self.mianView.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
        [self.contentView addSubview:self.mianView];
        [self.mianView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.top.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)refeleseWithModel:(ViewPerfectInformationModel *)model
{
//    [[self.mianView.subviews lastObject] removeFromSuperview];
    
    //删除cell的所有子视图
    while ([self.mianView.subviews lastObject] != nil)
    {
        [[self.mianView.subviews lastObject] removeFromSuperview];
    }
    
    if ([model.key isEqualToString:@"user_info"]) {
        ViewPerfectInformationUser_infoModel *user_infoModel = [[ViewPerfectInformationUser_infoModel alloc]init];
        [user_infoModel setdataWithDict:model.value];
        for (int i = 0; i<7; i++) {
            UILabel *zuoLabel = [[UILabel alloc]init];
            zuoLabel.font = [UIFont systemFontOfSize:14];
            zuoLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:zuoLabel];
            [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            UILabel *youLabel = [[UILabel alloc]init];
            youLabel.font = [UIFont systemFontOfSize:14];
            youLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:youLabel];
            [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            if (i == 0) {
                zuoLabel.text = @"客户类型";
                if ([user_infoModel.is_unit integerValue] == 0) {
                    youLabel.text = @"个人";
                }else{
                    youLabel.text = @"企业";
                }
            }else if (i == 1) {
                zuoLabel.text = @"客户电话";
                youLabel.text = user_infoModel.mobile;
            }else if (i == 2) {
                zuoLabel.text = @"客户姓名";
                youLabel.text = user_infoModel.store_alias;
            }else if (i == 3) {
                zuoLabel.text = @"客户身份证";
                youLabel.text = user_infoModel.id_card;
            }else if (i == 4) {
                zuoLabel.text = @"送修人电话";
                youLabel.text = user_infoModel.send_mobile;
            }else if (i == 5) {
                zuoLabel.text = @"送修人姓名";
                youLabel.text = user_infoModel.send_name;
            }else{
                zuoLabel.text = @"送修人身份证";
                youLabel.text = user_infoModel.send_id_card;
            }
        }
    }else if ([model.key isEqualToString:@"car_info"]) {
        ViewPerfectInformationCar_infoModel *car_infoModel = [[ViewPerfectInformationCar_infoModel alloc]init];
        [car_infoModel setdataWithDict:model.value];
        for (int i = 0; i<12; i++) {
            UILabel *zuoLabel = [[UILabel alloc]init];
            zuoLabel.font = [UIFont systemFontOfSize:14];
            zuoLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:zuoLabel];
            [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            UILabel *youLabel = [[UILabel alloc]init];
            youLabel.font = [UIFont systemFontOfSize:14];
            youLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:youLabel];
            [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            if (i == 0) {
                zuoLabel.text = @"车牌号";
                youLabel.text = car_infoModel.car_number;
            }else if (i == 1) {
                zuoLabel.text = @"车辆识别代码";
                youLabel.text = car_infoModel.carvin;
            }else if (i == 2) {
                zuoLabel.text = @"发动机号";
                youLabel.text = car_infoModel.engine_number;
            }else if (i == 3) {
                zuoLabel.text = @"所有人";
                youLabel.text = car_infoModel.owner;
            }else if (i == 4) {
                zuoLabel.text = @"品牌型号";
                youLabel.text = car_infoModel.model;
            }else if (i == 5) {
                zuoLabel.text = @"使用性质";
                youLabel.text = car_infoModel.use_character;
            }else if (i == 6) {
                zuoLabel.text = @"注册日期";
                youLabel.text = car_infoModel.register_date;
            }else if (i == 7) {
                zuoLabel.text = @"发证日期";
                youLabel.text = car_infoModel.issue_date;
            }else if (i == 8) {
                zuoLabel.text = @"地址";
                youLabel.text = car_infoModel.address;
            }else if (i == 9) {
                zuoLabel.text = @"车型";
                youLabel.text = car_infoModel.car_spec;
            }else if (i == 10) {
                zuoLabel.text = @"车身颜色";
                youLabel.text = car_infoModel.car_body_color;
            }else{
                zuoLabel.text = @"车辆类型";
                youLabel.text = car_infoModel.cartype;
            }
        }
    }else if ([model.key isEqualToString:@"insurance_info"]) {
        ViewPerfectInformationInsurance_infoModel *insurance_infoModel = [[ViewPerfectInformationInsurance_infoModel alloc]init];
        [insurance_infoModel setdataWithDict:model.value];
        for (int i = 0; i<2; i++) {
            UIView *vIve = [[UIView alloc]init];
            [self.mianView addSubview:vIve];
            [vIve mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(107);
                make.top.mas_equalTo(i*107);
            }];
            
            UILabel *label1 = [[UILabel alloc]init];
            label1.font = [UIFont boldSystemFontOfSize:14];
            label1.textColor = kRGBColor(74, 74, 74);
            [vIve addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(107/3.0);
            }];
            
            UILabel *zuoLabel = [[UILabel alloc]init];
            zuoLabel.font = [UIFont systemFontOfSize:14];
            zuoLabel.textColor = kRGBColor(102, 102, 102);
            [vIve addSubview:zuoLabel];
            [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(107/3.0);
                make.height.mas_equalTo(107/3.0);
            }];
            
            UILabel *youLabel = [[UILabel alloc]init];
            youLabel.font = [UIFont systemFontOfSize:14];
            youLabel.textColor = kRGBColor(102, 102, 102);
            [vIve addSubview:youLabel];
            [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(107/3.0);
                make.height.mas_equalTo(107/3.0);
            }];
            
            UILabel *zuoLabel2 = [[UILabel alloc]init];
            zuoLabel2.font = [UIFont systemFontOfSize:14];
            zuoLabel2.textColor = kRGBColor(102, 102, 102);
            [vIve addSubview:zuoLabel2];
            [zuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo((107/3.0) * 2);
                make.height.mas_equalTo(107/3.0);
            }];
            
            UILabel *youLabel2 = [[UILabel alloc]init];
            youLabel2.font = [UIFont systemFontOfSize:14];
            youLabel2.textColor = kRGBColor(102, 102, 102);
            [vIve addSubview:youLabel2];
            [youLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo((107/3.0) * 2);
                make.height.mas_equalTo(107/3.0);
            }];
            
            UIImageView *youImageView = [[UIImageView alloc]init];
            youImageView.contentMode = UIViewContentModeScaleAspectFit;
            [vIve addSubview:youImageView];
            [youImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo((107/3.0) * 2);
                make.height.mas_equalTo(107/3.0);
                make.width.mas_equalTo(98);
            }];
            zuoLabel.text = @"到期日期";
            zuoLabel2.text = @"承包公司";
            if (i == 0) {
                label1.text = @"交强险";
                youLabel.text = insurance_infoModel.TCI_expire;
                if (insurance_infoModel.insurance_force_images.length<=0) {
                    youLabel2.hidden = NO;
                    youLabel2.text = insurance_infoModel.insurance_force;
                    youImageView.hidden = YES;
                    [youImageView sd_setImageWithURL:[NSURL URLWithString:insurance_infoModel.insurance_force_images]];
                }else{
                    youLabel2.hidden = YES;
                    youImageView.hidden = NO;
                    [youImageView sd_setImageWithURL:[NSURL URLWithString:insurance_infoModel.insurance_force_images]];
                }
            }else
            {
                label1.text = @"商业险";
                youLabel.text = insurance_infoModel.VCI_expire;
                
                if (insurance_infoModel.insurance_company_images.length<=0) {
                    youLabel2.hidden = NO;
                    youLabel2.text = insurance_infoModel.insurance_company;
                    youImageView.hidden = YES;
                    [youImageView sd_setImageWithURL:[NSURL URLWithString:insurance_infoModel.insurance_company_images]];
                }else{
                    youLabel2.hidden = YES;
                    youImageView.hidden = NO;
                    [youImageView sd_setImageWithURL:[NSURL URLWithString:insurance_infoModel.insurance_company_images]];
                }
            }
            
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [vIve addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(10);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(0.5);
            }];
        }
        
        UIView *viNe = [[UIView alloc]init];
        [self.mianView addSubview:viNe];
        [viNe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(75);
        }];
        
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.font = [UIFont boldSystemFontOfSize:14];
        label1.textColor = kRGBColor(74, 74, 74);
        [viNe addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(75/2.0);
        }];
        label1.text = @"车辆年检";
        
        UILabel *zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:14];
        zuoLabel.textColor = kRGBColor(102, 102, 102);
        [viNe addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(75/2.0);
            make.height.mas_equalTo(75/2.0);
        }];
        zuoLabel.text = @"年检日期";
        
        UILabel *youLabel = [[UILabel alloc]init];
        youLabel.font = [UIFont systemFontOfSize:14];
        youLabel.textColor = kRGBColor(102, 102, 102);
        [viNe addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(75/2.0);
            make.height.mas_equalTo(75/2.0);
        }];
        
        youLabel.text = insurance_infoModel.valid_car_date;
        
    }else if ([model.key isEqualToString:@"inspect_info"]) {
        ViewPerfectInformationInspect_infoModel *inspect_infoModel = [[ViewPerfectInformationInspect_infoModel alloc]init];
        [inspect_infoModel setdataWithDict:model.value];
        UILabel *beiZhuLabel = [[UILabel alloc]init];
        beiZhuLabel.font = [UIFont systemFontOfSize:12];
        beiZhuLabel.text = @"备注";
        beiZhuLabel.textColor = kRGBColor(133, 133, 133);
        [self.mianView addSubview:beiZhuLabel];
        [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(42);
        }];
        
        
        UIView *view1 = [[UIView alloc]init];
        [self.mianView addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        if (inspect_infoModel.image_info_sum.count>0) {
            NSDictionary *image_info_sumDict = inspect_infoModel.image_info_sum[0];
            for (int i = 0; i<6; i++) {
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((i%3)*((kWindowW-20)/3), i/3*30, (kWindowW-20)/3, 30)];
                nameLabel.font = [UIFont systemFontOfSize:12];
                nameLabel.textAlignment = NSTextAlignmentCenter;
                nameLabel.textColor = kRGBColor(74, 74, 74);
                [view1 addSubview:nameLabel];
                if (i == 0) {
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"AX") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"凹陷（%ld）",nu];
                }else if (i == 1) {
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"DQ") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"掉漆（%ld）",nu];
                }else if (i == 2) {
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"GH") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"刮痕（%ld）",nu];
                }else if (i == 3) {
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"LW") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"裂纹（%ld）",nu];
                }else if (i == 4) {
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"PS") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"破损（%ld）",nu];
                }else{
                    NSInteger nu = [KISDictionaryHaveKey(image_info_sumDict, @"XS") integerValue];
                    if (nu>0) {
                        nameLabel.textColor = [UIColor redColor];
                    }else{
                        nameLabel.textColor = kRGBColor(74, 74, 74);
                    }
                    nameLabel.text = [NSString stringWithFormat:@"锈蚀（%ld）",nu];
                }
            }
        }
//        ==========
        if (inspect_infoModel.images.count>0) {
            UIScrollView *tuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kWindowW-20, 96)];
            [self.mianView addSubview:tuScrollView];
            [self zuoYouScllower:tuScrollView withArray:inspect_infoModel.images];
        }
        
        
    }else if ([model.key isEqualToString:@"goods_info"]) {
        ViewPerfectInformationGoods_infoModel *goods_infoModel = [[ViewPerfectInformationGoods_infoModel alloc]init];
        [goods_infoModel setdataWithDict:model.value];
        UILabel *beiZhuLabel = [[UILabel alloc]init];
        beiZhuLabel.font = [UIFont systemFontOfSize:12];
        beiZhuLabel.numberOfLines = 2;
        beiZhuLabel.text = [NSString stringWithFormat:@"备注：%@",goods_infoModel.goods_remark];
        beiZhuLabel.textColor = kRGBColor(133, 133, 133);
        [self.mianView addSubview:beiZhuLabel];
        [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(42);
        }];
        if (goods_infoModel.goods.count>0) {
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [self.mianView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(kWindowW/2.0);
                make.top.mas_equalTo(10);
                make.bottom.mas_equalTo(-42);
                make.width.mas_equalTo(1);
            }];
            NSMutableArray *shulArray = [[NSMutableArray alloc]init];;
            for (int i = 0; i<goods_infoModel.goods.count; i++) {
                BOOL shif = [KISDictionaryHaveKey(goods_infoModel.goods[i], @"bool") boolValue];
                if (shif == YES) {
                    [shulArray addObject:goods_infoModel.goods[i]];
                }
            }
            
            for (int i = 0; i<shulArray.count; i++) {
                NSDictionary *goodsDict = shulArray[i];
                UILabel *nameLabel = [[UILabel alloc]init];
                nameLabel.font = [UIFont systemFontOfSize:14];
                nameLabel.textColor = kRGBColor(74, 74, 74);
                nameLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(goodsDict, @"name")];
                [self.mianView addSubview:nameLabel];
                if (i%2 == 0) {
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(line.mas_right).mas_equalTo(10);
                        make.top.mas_equalTo((i/2)*42);
                        make.height.mas_equalTo(42);
                    }];
                }else{
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(10);
                        make.top.mas_equalTo((i/2)*42);
                        make.height.mas_equalTo(42);
                    }];
                }
                
            }
        }

    }else if ([model.key isEqualToString:@"functions_info"]) {
        ViewPerfectInformationFunctions_infoModel *functions_infoModel = [[ViewPerfectInformationFunctions_infoModel alloc]init];
        [functions_infoModel setdataWithDict:model.value];
        UILabel *beiZhuLabel = [[UILabel alloc]init];
        beiZhuLabel.font = [UIFont systemFontOfSize:12];
        beiZhuLabel.numberOfLines = 2;
        beiZhuLabel.text = [NSString stringWithFormat:@"备注：%@",functions_infoModel.functions_remark];
        beiZhuLabel.textColor = kRGBColor(133, 133, 133);
        [self.mianView addSubview:beiZhuLabel];
        [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(42);
        }];
        
        for (int i = 0; i<functions_infoModel.functions.count; i++) {
            NSDictionary *functionDict = functions_infoModel.functions[i];
            
            UILabel *zuoLabel = [[UILabel alloc]init];
            zuoLabel.font = [UIFont systemFontOfSize:14];
            zuoLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:zuoLabel];
            [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
            }];
            
            UILabel *youLabel = [[UILabel alloc]init];
            youLabel.font = [UIFont systemFontOfSize:14];
            youLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:youLabel];
            [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
            }];
            
            zuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(functionDict, @"name")];
            if ([KISDictionaryHaveKey(functionDict, @"bool") boolValue] == YES) {
                youLabel.text = @"正常";
            }else{
                youLabel.text = @"异常";
            }
//            youLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(functionDict, @"result")];
        }
    }else if ([model.key isEqualToString:@"gas_info"]) {
        ViewPerfectInformationGas_infoModel *gas_infoModel = [[ViewPerfectInformationGas_infoModel alloc]init];
        [gas_infoModel setdataWithDict:model.value];
        for (int i = 0; i<2; i++) {
            UILabel *zuoLabel = [[UILabel alloc]init];
            zuoLabel.font = [UIFont systemFontOfSize:14];
            zuoLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:zuoLabel];
            [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            UILabel *youLabel = [[UILabel alloc]init];
            youLabel.font = [UIFont systemFontOfSize:14];
            youLabel.textColor = kRGBColor(102, 102, 102);
            [self.mianView addSubview:youLabel];
            [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(i*37);
                make.height.mas_equalTo(37);
            }];
            
            if (i == 0) {
                zuoLabel.text = @"油量";
                youLabel.text = [NSString stringWithFormat:@"%@%%",gas_infoModel.gas];
            }else{
                zuoLabel.text = @"里程";
                youLabel.text = [NSString stringWithFormat:@"%@KM",gas_infoModel.repairmile];
            }
        }
    }
}
-(void)zuoYouScllower:(UIScrollView *)scrollView withArray:(NSArray *)images
{
    self.tuPianArray = images;
    for (int i = 0; i<images.count;i++ ) {
        NSDictionary *model = images[i];
        
        UIView *tuView = [[UIView alloc]initWithFrame:CGRectMake(i*128,0, 128,96)];
        [scrollView addSubview:tuView];
        
        UIImageView *zhuIm = [[UIImageView alloc]init];
        zhuIm.contentMode = UIViewContentModeScaleAspectFit;
        [zhuIm sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"images")]]];
        zhuIm.contentMode = UIViewContentModeScaleAspectFit;
        [tuView addSubview:zhuIm];
        [zhuIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.top.mas_equalTo(0);
        }];
        
        
        UIButton *tuPianYLbt = [[UIButton alloc]init];
        tuPianYLbt.tag = 3000 + i;
        [tuView addSubview:tuPianYLbt];
        [tuPianYLbt addTarget:self action:@selector(tuPianYLbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [tuPianYLbt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.top.mas_equalTo(0);
        }];
    }
    scrollView.contentSize = CGSizeMake(images.count*128, 96);
}

-(void)tuPianYLbtChick:(UIButton *)sender
{
    
    NSInteger index = sender.tag - 3000;
    PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
    //    vc.chuRuMoel = self.wenTiArray[index];
    NSMutableArray *wenTiarray = [[NSMutableArray alloc]init];
    NSArray *images = self.tuPianArray;
    for (int i = 0; i<images.count; i++) {
        CarInspectionModel *model = [[CarInspectionModel alloc]init];
        model.urlDiZhi = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(images[i], @"images")];
        NSDictionary *describe = KISDictionaryHaveKey(images[i], @"describe");
        model.fangXiang = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(describe, @"Direction")];
        model.beiZhu = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(describe, @"remarks")];
        
        if ([KISDictionaryHaveKey(describe, @"XS") boolValue] == YES) {
            [model.wenTiArray addObject:@"锈蚀"];
        }
        if ([KISDictionaryHaveKey(describe, @"PS") boolValue] == YES) {
            [model.wenTiArray addObject:@"破损"];
        }
        if ([KISDictionaryHaveKey(describe, @"DQ") boolValue] == YES) {
            [model.wenTiArray addObject:@"掉漆"];
        }
        if ([KISDictionaryHaveKey(describe, @"LW") boolValue] == YES) {
            [model.wenTiArray addObject:@"裂纹"];
        }
        if ([KISDictionaryHaveKey(describe, @"GH") boolValue] == YES) {
            [model.wenTiArray addObject:@"刮痕"];
        }
        if ([KISDictionaryHaveKey(describe, @"AX") boolValue] == YES) {
            [model.wenTiArray addObject:@"凹陷"];
        }
        
        [wenTiarray addObject:model];
    }
    
    vc.tuPianArray = wenTiarray;
    vc.index = index;
    [self.superViewController.navigationController pushViewController:vc animated:YES];
}



@end
