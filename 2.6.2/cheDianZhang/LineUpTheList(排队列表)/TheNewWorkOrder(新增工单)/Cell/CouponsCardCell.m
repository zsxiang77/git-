//
//  CouponsCardCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CouponsCardCell.h"
#import "CheDianZhangCommon.h"

@implementation CouponsCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.beiJingView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, kWindowW-20, (kWindowW-20)*260/600)];
        [self.contentView addSubview:self.beiJingView];
        self.beiJingView.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
        self.beiJingView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.beiJingView.layer.shadowOpacity = 0.8;//阴影透明度，默认0


    }
    return self;
}

-(UIImageView *)beiJingImageView
{
    if (!_beiJingImageView) {
        _beiJingImageView = [[UIImageView alloc]init];
        [self.beiJingView addSubview:_beiJingImageView];
        [_beiJingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _beiJingImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.beiJingView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
        }];
    }
    return _titleLabel;
}

-(UILabel *)huiSeLabel
{
    if (!_huiSeLabel) {
        _huiSeLabel = [[UILabel alloc]init];
        
        _huiSeLabel.textColor = [UIColor grayColor];
        _huiSeLabel.font = [UIFont systemFontOfSize:13];
        [self.beiJingView addSubview:_huiSeLabel];
        [_huiSeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(10);
        }];
    }
    return _huiSeLabel;
}
-(UILabel *)heiSeLabel
{
    if (!_heiSeLabel) {
        _heiSeLabel = [[UILabel alloc]init];
        _heiSeLabel.numberOfLines = 0;
        _heiSeLabel.font = [UIFont systemFontOfSize:13];
        [self.beiJingView addSubview:_heiSeLabel];
        [_heiSeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.huiSeLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(kWindowW-40);
        }];
    }
    return _heiSeLabel;
}

-(void)refreshViewWithDate:(NSDictionary *)dict
{
    NSInteger type = [KISDictionaryHaveKey(dict, @"type") integerValue];
    NSString *title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    NSString *sinfo = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"sinfo")];
    NSString *cardsnum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cardsnum")];
    
    if (type == 1) {
        self.beiJingImageView.image = DJImageNamed(@"card_chong");
    }else
    {
        self.beiJingImageView.image = DJImageNamed(@"card_fu");
    }
    self.titleLabel.text = title;
    self.huiSeLabel.text = cardsnum;
    self.heiSeLabel.text = sinfo;
}

@end
