//
//  LearningZuoCeShiViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningZuoCeShiViewController.h"

@interface LearningZuoCeShiViewController ()

@end

@implementation LearningZuoCeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:self.chuanZhiModel.title withBackButton:YES];
    self.mainArray = [[NSMutableArray alloc]init];
    [self qingQiuGet_questionData];
}

-(void)qingQiuGet_questionData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.exam_id forKey:@"exam_id"];

    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/get_question" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showConnectFailView:NO mySEL:nil inView:weakSelf.view startY:0];
        NSDictionary *adData = kParseData(responseObject);/*dataDic[@"data"];*/
        if ([adData isKindOfClass:[NSDictionary class]]) {
            NSArray *adDataArray = KISDictionaryHaveKey(adData, @"question");
            [weakSelf.mainArray removeAllObjects];
            for (int i = 0; i<adDataArray.count; i++) {
                LearningZuoCeShiModel *model = [[LearningZuoCeShiModel alloc]init];
                [model setDictData:adDataArray[i]];
                [weakSelf.mainArray addObject:model];
            }
            [weakSelf buJuView];
        }

    } failure:^(id error) {
        [weakSelf showConnectFailView:YES mySEL:@selector(qingQiuGet_questionData) inView:weakSelf.view startY:0];
    }];
}

-(void)buJuView
{
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, 200)];
    shangView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:shangView];
    
    UILabel *numberLabel = [[UILabel alloc]init];
    numberLabel.font = [UIFont systemFontOfSize:17];
    numberLabel.textColor = kRGBColor(74, 74, 74);
    numberLabel.text = @"答题数量";
    [self.view addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(shangView.mas_bottom).mas_equalTo(14);
    }];
    
    UILabel *numberLabel2 = [[UILabel alloc]init];
    numberLabel2.font = [UIFont systemFontOfSize:27];
    numberLabel2.textColor = [UIColor blackColor];
    numberLabel2.text = [NSString stringWithFormat:@"%ld题",self.mainArray.count];
    [self.view addSubview:numberLabel2];
    [numberLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(numberLabel.mas_bottom).mas_equalTo(5);
    }];

    UIButton *okBt = [[UIButton alloc]init];
    [okBt.layer setMasksToBounds:YES];
    okBt.backgroundColor = kZhuTiColor;
    [okBt.layer setCornerRadius:8];
    [okBt setTitle:@"开始答题" forState:(UIControlStateNormal)];
    [okBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okBt];
    [okBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(numberLabel2.mas_bottom).mas_equalTo(21);
        make.height.mas_equalTo(48);
    }];
}


@end
