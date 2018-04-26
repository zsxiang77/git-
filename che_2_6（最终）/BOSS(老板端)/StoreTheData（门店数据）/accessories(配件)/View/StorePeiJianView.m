//
//  StorePeiJianView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StorePeiJianView.h"

@implementation StorePeiJianView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self==[super initWithFrame:(CGRect)frame]){
        self.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        UIButton * btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(riliClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(6);
            make.width.height.mas_equalTo(40);
        }];
        
        self.timeDateLable = [[UILabel alloc]init];
        self.timeDateLable.font = [UIFont systemFontOfSize:12];
        [self.timeDateLable setTextColor:[UIColor blackColor]];
        self.timeDateLable.text = @"2018年3月";
        [self addSubview:self.timeDateLable];
        [self.timeDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btn.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(btn);
        }];
        
        anNniuView = [[UIView alloc]init];
        [anNniuView.layer setMasksToBounds:YES];
        [anNniuView.layer setBorderWidth:0.5];
        [anNniuView.layer setBorderColor:kLineBgColor.CGColor];
        [anNniuView.layer setCornerRadius:10];
        [self addSubview:anNniuView];
        [anNniuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.timeDateLable);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(186/2);
        }];
        UILabel *btnLine =[[UILabel alloc]init];
        btnLine .backgroundColor = kLineBgColor;
        [anNniuView addSubview:btnLine];
        [btnLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(anNniuView);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(92/2);
        }];
        for (int i=0 ; i<2; i++) {
            UIButton * buttonTwo = [[UIButton alloc]init];
            buttonTwo.titleLabel.font = [UIFont systemFontOfSize:14];
            [buttonTwo addTarget:self action:@selector(xuanzeRenYuanBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            buttonTwo.tag = 500+i;
            [buttonTwo setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
            [buttonTwo setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
            [anNniuView addSubview:buttonTwo];
            if(i==0){
                [buttonTwo setTitle:@"销" forState:(UIControlStateNormal)];
                [buttonTwo setTitle:@"销" forState:(UIControlStateSelected)];
                buttonTwo.frame = CGRectMake(0, 0, 92/2, 32);
                buttonTwo.selected = YES;
            }else{
                [buttonTwo setTitle:@"存" forState:(UIControlStateNormal)];
                [buttonTwo setTitle:@"存" forState:(UIControlStateSelected)];
                buttonTwo.frame = CGRectMake(92/2+1, 0, 92/2, 32);
            }
        }
        
       self.headerView = [[StoreYuanXingtuView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 666/2)];
         self.mainTable= [[UITableView alloc]initWithFrame:CGRectMake(0, 52, kWindowW,self.frame.size.height-52)style:UITableViewStyleGrouped];
         self.mainTable.delegate = self;
        self.mainTable.dataSource = self;
         self.mainTable.hidden = NO;
         self.mainTable.tableHeaderView = self.headerView;
        [self addSubview: self.mainTable];
        
    }
       return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *Identifier = @"Identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.mainTable reloadData];
        return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return 45;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return 50;
  
    
}
-(void)xuanzeRenYuanBtn:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<2; i++) {
        UIButton *bt = [anNniuView viewWithTag:500+i];
        bt.selected = NO;
    }
    sender.selected =! sender.selected;
    
}

-(void)riliClick:(UIButton *)sender
{
    self.showRiLiBlock();
}
@end
