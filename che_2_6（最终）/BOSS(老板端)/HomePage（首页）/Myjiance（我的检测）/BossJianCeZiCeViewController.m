//
//  BossJianCeZiCeViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianCeZiCeViewController.h"
#import "BossJianCeXiangQingModel.h"
#import "BossJianCeListTableViewCell.h"
@interface BossJianCeZiCeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BossJianCeZiCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"自测题" withBackButton:YES];
    self.view.backgroundColor =[UIColor whiteColor];
    self.chuanZhiArray = [[NSMutableArray alloc]init];
    self.tableViewArray = [[NSMutableArray alloc]init];
    [self shuJushuaxinQingQiu];
    UIView * shangbanView =[[UIView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, 61)];
    [self.view addSubview:shangbanView];
    UILabel * line =[[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [shangbanView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    textlable = [[UILabel alloc]init];
    textlable.textColor = kRGBColor(51, 51, 51);
    textlable.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:textlable];
    [textlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(shangbanView);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.viewScroLLview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+61, kWindowW, kWindowH-kBOSSNavBarHeight-61)];
    
    self.viewScroLLview.scrollEnabled = NO;
    [self.view addSubview:self.viewScroLLview];
    
    
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-62, kWindowW, 62)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel * line2 =[[UILabel alloc]init];
    line2.backgroundColor = kLineBgColor;
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel * line1 =[[UILabel alloc]init];
    line1.backgroundColor = kRGBColor(155, 155, 155);
    line1.frame = CGRectMake(kWindowW/3, 18, 1, 25);
    [bottomView addSubview:line1];
    
    UILabel * lineBottom = [[UILabel alloc]init];
    lineBottom.backgroundColor = kRGBColor(200, 199, 204);
    [bottomView addSubview:lineBottom];
    lineBottom.frame = CGRectMake(0, 0, kWindowW, 1);
    
    
    UILabel * line4 =[[UILabel alloc]init];
    line4.backgroundColor = kRGBColor(155, 155, 155);
    line4.frame = CGRectMake(kWindowW/3*2, 18, 1, 25);
    [bottomView addSubview:line4];
    
    for (int i=0; i<3; i++) {
        UIButton * btn =[[UIButton alloc]init];
        btn.tag = 4000+i;
        [btn addTarget:self action:@selector(qieHuanChick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kRGBColor(102, 102, 102) forState:UIControlStateNormal];
        btn.frame = CGRectMake(kWindowW/3*i, 0, kWindowW/3, 66);
        [bottomView addSubview: btn];
        if(i==0){
            if(self.diJiTi<1){
                [btn setTitle:@"" forState:UIControlStateNormal];
                btn.enabled = NO;
            }
        }else if(i==1){
            
        }else{
            [btn setTitle:@"下一题" forState:UIControlStateNormal];
        }
    }
    
}
-(void)qieHuanChick:(UIButton *)sender
{
    if (sender.tag == 4000) {
        NPrintLog(@"中国%ld",self.diJiTi);
        if(self.diJiTi<1){
            [sender setTitle:@"" forState:UIControlStateNormal];
            sender.enabled =NO;
        }else{
            sender.enabled =YES;
            self.diJiTi--;
            if(self.diJiTi==0){
                [sender setTitle:@"" forState:UIControlStateNormal];
                sender.enabled =NO;
            }
            [self.viewScroLLview setContentOffset:CGPointMake(kWindowW*self.diJiTi,0) animated:YES];
        }
    }
    if(sender.tag == 4002){
        if(self.diJiTi == self.chuanZhiArray.count-1){
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            self.diJiTi ++;
            [self.viewScroLLview setContentOffset:CGPointMake(kWindowW*self.diJiTi,0) animated:YES];
            UIButton *zuoBt = [bottomView viewWithTag:4000];
            zuoBt.enabled = YES;
            if(self.diJiTi==9){
                [sender setTitle:@"返回" forState:UIControlStateNormal];
            }
            [zuoBt setTitle:@"上一题" forState:UIControlStateNormal];
        }
        
    }
    UIButton *zhongBt = [bottomView viewWithTag:4001];
    [zhongBt setTitle:[NSString stringWithFormat:@"%ld/%ld",self.diJiTi+1,self.chuanZhiArray.count] forState:UIControlStateNormal];
    
}
-(void)shuJushuaxinQingQiu
{
    BossJianceModel *model = self.chuanZhiModel;
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.a_id forKey:@"a_id"];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@user/study/my_exam_detail",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"get参数%@\n返回：%@",mDict,parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        [weakSelf.chuanZhiArray removeAllObjects];
        NSMutableAttributedString *AttributedStr= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您共完成%@道题,其中%@道题错误",KISDictionaryHaveKey(adData, @"totalnum"),KISDictionaryHaveKey(adData, @"num")]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor redColor]
                              range:NSMakeRange(9+[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"totalnum")].length,[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"num")].length)];
        textlable.attributedText = AttributedStr;
        NSArray *cuowu_list = KISDictionaryHaveKey(adData, @"wrong");
        for( int i= 0;i<cuowu_list.count;i++){
            BossJianCeXiangQingModel *models = [[BossJianCeXiangQingModel alloc]init];
            [models setJianCeDatashuJu:cuowu_list[i]];
            [weakSelf.chuanZhiArray addObject:models];
        }
        if(weakSelf.chuanZhiArray.count>0)
        {
            [weakSelf xiuGaiView];
        }
        NPrintLog(@"测试%@",weakSelf.chuanZhiArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

-(void)xiuGaiView
{
    //删除cell的所有子视图
    while ([self.viewScroLLview.subviews lastObject] != nil)
    {
        [[self.viewScroLLview.subviews lastObject] removeFromSuperview];
    }
    self.viewScroLLview.contentSize = CGSizeMake(kWindowW*self.chuanZhiArray.count, kWindowH-kBOSSNavBarHeight-61);
    self.viewScroLLview.backgroundColor =[UIColor whiteColor];
    [self.tableViewArray removeAllObjects];
    
    
    UIButton *zhongBt = [bottomView viewWithTag:4001];
    [zhongBt setTitle:[NSString stringWithFormat:@"%ld/%ld",self.diJiTi+1,self.chuanZhiArray.count] forState:UIControlStateNormal];
    
    for (int i = 0; i<self.chuanZhiArray.count; i++) {
        UITableView *nTableView = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW*i, 0, kWindowW, kWindowH-kBOSSNavBarHeight-61) style:(UITableViewStyleGrouped)];
        nTableView.delegate = self;
        nTableView.dataSource = self;
        nTableView.bounces = NO;
        nTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.viewScroLLview addSubview:nTableView];
        [self.tableViewArray addObject:nTableView];
        [nTableView reloadData];
    }
    
}
#pragma tableview数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.tableViewArray.count>0) {
        NSInteger jihang = 0;
        for (int i = 0; i<self.tableViewArray.count; i++) {
            UITableView *naT = self.tableViewArray[i];
            if (naT == tableView) {
                BossJianCeXiangQingModel *model = self.chuanZhiArray[i];
                NPrintLog(@"model.option%ld",model.option.count);
                jihang = model.option.count;
            }
        }
        return jihang;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    BossJianCeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[BossJianCeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BossJianCeXiangQingModel *wrongModel;
    if (self.tableViewArray.count>0) {
        for (int i = 0; i<self.tableViewArray.count; i++) {
            UITableView *naT = self.tableViewArray[i];
            if (naT == tableView) {
                BossJianCeXiangQingModel *model2 = self.chuanZhiArray[i];
                wrongModel = model2;
            }
        }
        [cell setData:wrongModel.option[indexPath.row] withZhengque:wrongModel.answer withWrong:wrongModel.answer_u withInIt:indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor =[UIColor whiteColor];
    UILabel *hTitle = [[UILabel alloc]init];
    hTitle.numberOfLines = 2;
    hTitle.adjustsFontSizeToFitWidth = YES;
    hTitle.font = [UIFont boldSystemFontOfSize:17];
    hTitle.textColor = kRGBColor(74, 74, 74);
    
    BossJianCeXiangQingModel *wrongModel;
    NSInteger xueHao = 0;
    if (self.tableViewArray.count>0) {
        for (int i = 0; i<self.tableViewArray.count; i++) {
            UITableView *naT = self.tableViewArray[i];
            if (naT == tableView) {
                BossJianCeXiangQingModel *model2 = self.chuanZhiArray[i];
                wrongModel = model2;
                xueHao = i;
            }
        }
    }
    hTitle.text = [NSString stringWithFormat:@"%ld、%@",xueHao+1,wrongModel.title];
    [headView addSubview:hTitle];
    [hTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(74/2);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    return headView;
}
//设置tableview头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
//设置table尾部
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor =[UIColor whiteColor];
    UILabel * textContent = [[UILabel alloc]init];
    textContent.text = @"试题详解";
    textContent.font = [UIFont systemFontOfSize:12];
    [textContent setTextColor:kRGBColor(51, 51, 51)];
    [footView addSubview:textContent];
    [textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(footView);
    }];
    
    
    UILabel * zuoLine = [[UILabel alloc]init];
    zuoLine.backgroundColor = kLineBgColor;
    [footView addSubview:zuoLine];
    [zuoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textContent);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(textContent.mas_left).mas_equalTo(-5);
        make.height.mas_equalTo(1);
    }];
    
    UILabel * youLine = [[UILabel alloc]init];
    youLine.backgroundColor = kLineBgColor;
    [footView addSubview:youLine];
    [youLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textContent);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(textContent.mas_right).mas_equalTo(5);
        make.height.mas_equalTo(1);
    }];
    
    UILabel * redLable = [[UILabel alloc]init];
    [redLable  setTextColor:[UIColor redColor]];
    redLable.text = @"回答错误";
    redLable.font = [UIFont systemFontOfSize:15];
    [footView addSubview:redLable];
    [redLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(zuoLine.mas_bottom).mas_equalTo(10);
    }];
    
    BossJianCeXiangQingModel *wrongModel;
    NSInteger xueHao = 0;
    if (self.tableViewArray.count>0) {
        for (int i = 0; i<self.tableViewArray.count; i++) {
            UITableView *naT = self.tableViewArray[i];
            if (naT == tableView) {
                BossJianCeXiangQingModel *model2 = self.chuanZhiArray[i];
                wrongModel = model2;
                xueHao = i;
            }
        }
    }
    self.daAnLable = [[UILabel alloc]init];
    self.daAnLable.font = [UIFont systemFontOfSize:13];
    [self.daAnLable setTextColor:kRGBColor(51, 51, 51)];
    self.daAnLable.numberOfLines = 0;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"*解析:%@",wrongModel.analysis]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(0, 1)];
    self.daAnLable.attributedText = AttributedStr;
    [footView addSubview:self.daAnLable];
    [self.daAnLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(redLable.mas_bottom).mas_equalTo(5);
    }];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tableViewArray.count>0) {
        NSInteger jihang = 0;
        for (int i = 0; i<self.tableViewArray.count; i++) {
            UITableView *naT = self.tableViewArray[i];
            if (naT == tableView) {
                BossJianCeXiangQingModel *model = self.chuanZhiArray[i];
                NPrintLog(@"model.option%ld",model.option.count);
                
                jihang = model.option.count;
            }
        }
        return kWindowH-kBOSSNavBarHeight-(jihang*45)-61-62;
    }else{
        return 0;
    }
}
@end

