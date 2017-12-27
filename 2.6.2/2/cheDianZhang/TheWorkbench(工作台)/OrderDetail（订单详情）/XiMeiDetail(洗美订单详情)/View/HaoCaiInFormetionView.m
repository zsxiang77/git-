//
//  HaoCaiInFormetionView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "HaoCaiInFormetionView.h"
#import "CheDianZhangCommon.h"
#import "UIImage+ImageWithColor.h"
#import "UIImageView+WebCache.h"
#import "HaoCaiInFormetionCell.h"

@implementation HaoCaiInFormetionView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        self.mainArray = [[NSArray alloc]init];
        
        UIView *backV = [[UIView alloc]init];
        [backV.layer setMasksToBounds:YES];
        [backV.layer setCornerRadius:3];
        backV.backgroundColor = [UIColor whiteColor];
        [self addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(300);
        }];
        
        UIButton *guanBiBt = [[UIButton alloc]init];
        guanBiBt.imageEdgeInsets = UIEdgeInsetsMake(35, 10, 0, 10);
        [guanBiBt setImage:DJImageNamed(@"tankuang_close") forState:(UIControlStateNormal)];
        [guanBiBt addTarget:self action:@selector(guanBiButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:guanBiBt];
        [guanBiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backV);
            make.bottom.mas_equalTo(backV.mas_top);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(75);
        }];
        
        UILabel *la1 = [[UILabel alloc]init];
        la1.font = [UIFont systemFontOfSize:14];
        la1.text = @"耗材信息";
        la1.textAlignment = NSTextAlignmentCenter;
        la1.textColor = [UIColor grayColor];
        [backV addSubview:la1];
        [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        self.mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [backV addSubview:self.mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(40);
        }];
        
    }
    return self;
}

-(void)guanBiButton:(UIButton *)sender
{
    self.hidden = YES;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    HaoCaiInFormetionCell *cell = (HaoCaiInFormetionCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[HaoCaiInFormetionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    NSDictionary *dict = self.mainArray[indexPath.row];
    
    [cell.mainImageView  sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(dict, @"images")] placeholderImage:DJImageNamed(@"ic_launcher")];
    
    cell.mainLabel.text = KISDictionaryHaveKey(dict, @"title");
    cell.duoShanJianLabel.text = [NSString stringWithFormat:@"共 %@ 件",KISDictionaryHaveKey(dict, @"count")];
    cell.shuXinLabel.text = [NSString stringWithFormat:@"¥:%@",KISDictionaryHaveKey(dict, @"reality_price")];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
