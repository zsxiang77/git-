//
//  LearningZuoViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningZuoViewController.h"
#import "LearningZuoCeShiModel.h"
#import "LearningZuoCell.h"
#import "LearningZiCeViewController.h"
@interface LearningZuoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTableView;

@end

@implementation LearningZuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"答题中" withBackButton:YES];
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight-66) style:(UITableViewStyleGrouped)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];

    [self.view addSubview:self.mainTableView];
    LearningZuoCeShiModel *model = self.chuanZhiArray[self.diJiTi];
    
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-66, kWindowW, 66)];
    bottomView.backgroundColor = kRGBColor(255, 255, 255);
    [self.view addSubview:bottomView];
    UILabel * line1 =[[UILabel alloc]init];
    line1.backgroundColor = kRGBColor(155, 155, 155);
    line1.frame = CGRectMake(kWindowW/3, 18, 1, 25);
    [bottomView addSubview:line1];
    
    UILabel * lineBottom = [[UILabel alloc]init];
    lineBottom.backgroundColor = kRGBColor(200, 199, 204);
    [bottomView addSubview:lineBottom];
    lineBottom.frame = CGRectMake(0, 0, kWindowW, 1);
    
    
    UILabel * line2 =[[UILabel alloc]init];
    line2.backgroundColor = kRGBColor(155, 155, 155);
    line2.frame = CGRectMake(kWindowW/3*2, 18, 1, 25);
    [bottomView addSubview:line2];
    
    for (int i=0; i<3; i++) {
        UIButton * btn =[[UIButton alloc]init];
        btn.tag = 4000+i;
        [btn addTarget:self action:@selector(qieHuanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setTitleColor:kRGBColor(102, 102, 102) forState:UIControlStateNormal];
        btn.frame = CGRectMake(kWindowW/3*i, 0, kWindowW/3, 66);
        [bottomView addSubview: btn];
        if(i==0){
            if(self.diJiTi<1){
                [btn setTitle:@"" forState:UIControlStateNormal];
                btn.enabled = NO;
            }else{
                [btn setTitle:@"上一题" forState:UIControlStateNormal];
            }
        }else if(i==1){
            [btn setTitle:[NSString stringWithFormat:@"%ld/%ld",self.diJiTi+1,self.chuanZhiArray.count] forState:UIControlStateNormal];
        }else{
            if(self.diJiTi == self.chuanZhiArray.count-1){
                [btn setTitle:@"提交" forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"下一题" forState:UIControlStateNormal];
            }
        }
        
    }
}

-(void)xuanZeDaAnChick:(UIButton *)sender
{
    LearningZuoCeShiModel *model = self.chuanZhiArray[self.diJiTi];
    if ([model.question_types isEqualToString:@"2"]) {
        sender.selected =!sender.selected;
        
    }else{
        for (int i = 0; i<model.option.count; i++) {
            
        }
    }
}

-(void)qieHuanChick:(UIButton *)sender
{
    if (sender.tag == 4000) {
        [self.navigationController  popViewControllerAnimated:YES];
    }else if(sender.tag == 4001){
     
    }else{
        if(self.diJiTi == self.chuanZhiArray.count-1){
            
            [self qingQiuGet_questionData];
        }else {
            LearningZuoViewController * vc =[[LearningZuoViewController alloc]init];
            vc.chuanZhiArray = self.chuanZhiArray;
            vc.diJiTi = self.diJiTi+1;
            vc.exam_id = self.exam_id;
            vc.fatherViewController = self.fatherViewController;
            vc.backCeshiViewController = self.backCeshiViewController;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}


-(void)qingQiuGet_questionData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.exam_id forKey:@"exam_id"];
    
    NSMutableDictionary  *daAnDict = [[NSMutableDictionary alloc]init];
    for (int i = 0; i<self.chuanZhiArray.count; i++) {
        LearningZuoCeShiModel *model = self.chuanZhiArray[i];
        NSString *daAnatr = @"";
        for (int j = 0; j<model.daAn.count; j++) {
            LearningZuoCeShiDaAnModel *daModel = model.daAn[j];
            if (daModel.shiFouXuanZhong == YES) {
                if (j == 0) {
                    daAnatr = @"A";
                }else if (j == 1){
                    if (daAnatr.length>0) {
                        daAnatr = [NSString stringWithFormat:@"%@,B",daAnatr];
                    }else{
                        daAnatr = @"B";
                    }
                }else if (j == 2){
                    if (daAnatr.length>0) {
                        daAnatr = [NSString stringWithFormat:@"%@,C",daAnatr];
                    }else{
                        daAnatr = @"C";
                    }
                }else if (j == 3){
                    if (daAnatr.length>0) {
                        daAnatr = [NSString stringWithFormat:@"%@,D",daAnatr];
                    }else{
                        daAnatr = @"D";
                    }
                }else if (j == 4){
                    if (daAnatr.length>0) {
                        daAnatr = [NSString stringWithFormat:@"%@,E",daAnatr];
                    }else{
                        daAnatr = @"E";
                    }
                }else{
                    if (daAnatr.length>0) {
                        daAnatr = [NSString stringWithFormat:@"%@,F",daAnatr];
                    }else{
                        daAnatr = @"F";
                    }
                }
            }
        }
        [daAnDict setObject:daAnatr forKey:model.question_id];
    }
    [mDict setObject:[self convertToJsonData:daAnDict] forKey:@"data"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/submit_exam" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showConnectFailView:NO mySEL:nil inView:weakSelf.view startY:0];
        NSDictionary *adData = kParseData(responseObject);/*dataDic[@"data"];*/
        if ([adData isKindOfClass:[NSDictionary class]]) {
            LearningWrongModel *mode = [[LearningWrongModel alloc]init];
            [mode setDictData:adData];
            LearningZiCeViewController * vc = [[LearningZiCeViewController alloc]init];
            vc.chuanZhiDict = mode;
            vc.fatherViewController = self.fatherViewController;
            vc.backCeshiViewController = self.backCeshiViewController;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(id error) {
        [weakSelf showConnectFailView:YES mySEL:@selector(qingQiuGet_questionData) inView:weakSelf.view startY:0];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LearningZuoCeShiModel *model = self.chuanZhiArray[self.diJiTi];
    return model.option.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    LearningZuoCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[LearningZuoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    LearningZuoCeShiModel *chuModel = self.chuanZhiArray[self.diJiTi];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell shuaXinData:chuModel.daAn[indexPath.row]];
    kWeakSelf(weakSelf)
    cell.dianJiChickBlock = ^(LearningZuoCeShiDaAnModel *model) {
        if ([chuModel.question_types isEqualToString:@"2"]) {
            model.shiFouXuanZhong = !model.shiFouXuanZhong;
        }else{
            if (model.shiFouXuanZhong == YES) {
                return ;
            }else{
                for (int i = 0; i<chuModel.daAn.count; i++) {
                    LearningZuoCeShiDaAnModel *newModel = chuModel.daAn[i];
                    newModel.shiFouXuanZhong = NO;
                }
                model.shiFouXuanZhong = !model.shiFouXuanZhong;
            }
            
        }
        [weakSelf.mainTableView reloadData];
    };
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    UILabel *hTitle = [[UILabel alloc]init];
    hTitle.numberOfLines = 2;
    hTitle.adjustsFontSizeToFitWidth = YES;
    hTitle.font = [UIFont boldSystemFontOfSize:17];
    hTitle.textColor = kRGBColor(74, 74, 74);
    LearningZuoCeShiModel *model = self.chuanZhiArray[self.diJiTi];
    hTitle.text = [NSString stringWithFormat:@"%ld、%@",self.diJiTi+1,model.title];
    [headView addSubview:hTitle];
    [hTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(74/2);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

@end

