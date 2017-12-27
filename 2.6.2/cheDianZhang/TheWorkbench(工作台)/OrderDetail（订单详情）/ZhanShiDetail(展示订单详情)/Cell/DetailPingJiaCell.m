//
//  DetailPingJiaCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "DetailPingJiaCell.h"
#import "CheDianZhangCommon.h"

@implementation DetailPingJiaCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kRGBColor(245, 245, 245);
        zhuLabel = [[UILabel alloc]init];
        zhuLabel.font = [UIFont systemFontOfSize:14];
        zhuLabel.textColor = kRGBColor(155, 155, 155);
        zhuLabel.numberOfLines = 0;
        [self.contentView addSubview:zhuLabel];
        [zhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
        
        zuoYouScrollView = [[UIScrollView alloc]init];
        [self.contentView addSubview:zuoYouScrollView];
        [zuoYouScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(zhuLabel.mas_bottom).mas_equalTo(7);
            make.height.mas_equalTo(60);
        }];
    }
    return self;
}

-(void)refleshData:(NSDictionary *)dict
{
    NPrintLog(@"contentshivid%@",KISDictionaryHaveKey(dict, @"content"));
    zhuLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"content")];
    NSArray *images = KISDictionaryHaveKey(dict, @"images");
    if ([images isKindOfClass:[NSArray class]]) {
        [self zuoYouScrollViewBuju:images];
    }
    
}
-(void)zuoYouScrollViewBuju:(NSArray *)images
{
    while ([zuoYouScrollView.subviews lastObject] != nil)
    {
        [(UIView*)[zuoYouScrollView.subviews lastObject] removeFromSuperview];
    }
    
    
    for (int i = 0; i<images.count; i++) {
        UIImageView *maImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*110, 0, 100, 60)];
        [zuoYouScrollView addSubview:maImageView];
        [maImageView  sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:DJImageNamed(@"ic_launcher")];
    }
    zuoYouScrollView.contentSize = CGSizeMake((images.count)*110, 60);
}
@end
