//
//  kehuXuQiuViewController.m
//  测试
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "kehuXuQiuViewController.h"
#import "TopDanXuanCollectionView.h"
#import "TopDanXuanViewModel.h"
#import "LCBottomView.h"
#import "LCMessageListView.h"
#import "MaintenanceProjectViewController.h" //项目保养
#import "RepairSecondViewController.h"       //二级维护
#import "OrderCreatViewController.h"

@interface kehuXuQiuViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) TopDanXuanCollectionView *topView;
@property (nonatomic, strong) LCMessageListView * messageListView;
@property (nonatomic, strong) LCBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray <TopDanXuanViewModel *>*topArr;
@property (nonatomic, strong) UIView *backView;
@end

@implementation kehuXuQiuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTopViewWithTitle:@"客户需求" withBackButton:YES];
    
    
    
#warning 这里是单利 初始化 + 单利清空数据
    [[CreatOrderFlowChartManager defaultOrderFlowChartManager] resetDefault];

    
    self.topView = [[TopDanXuanCollectionView alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];
    [self.view addSubview:_topView];
    @weakify(self);
    _topView.didSelect = ^(TopDanXuanViewModel *vmodel) {
        @strongify(self);
        if ([self.topArr containsObject:vmodel]) {
            NSInteger i = [self.topArr indexOfObject:vmodel];
            if (i==2) {
                //事故车
                UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保险",@"非保险", nil];
                sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
                [sheet showInView:self.view];
            }else{
                
                vmodel.isSelect = !vmodel.isSelect;
                BaseCreatOrderFlowChart *flowChart = [CreatOrderFlowChartManager defaultOrderFlowChartManager].creatOrderFlowArr[i];
                flowChart.isSelect = vmodel.isSelect;
                if (!flowChart.isSelect) {
                    //
                    [flowChart qingKongData];
                }
            }
        }
    };
    self.topArr = @[].mutableCopy;
    NSArray *titles = @[@"小修",@"保养",@"事故车",@"二级维护"];
    for (NSString *title in titles) {
        TopDanXuanViewModel *model = [TopDanXuanViewModel new];
        model.title = title;
        model.imageName = title;
        model.isSelect = NO;
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            if (self.mainModel.order_typeArray.count>0) {
                for (int h = 0; h<self.mainModel.order_typeArray.count; h++) {
                    if ([model.title isEqualToString:self.mainModel.order_typeArray[h]]) {
                        model.isSelect = YES;
                    }
                }
            }
        }
        if ([model.title isEqualToString:@"事故车"]) {
            model.isSelect = NO;
        }
        [self.topArr addObject:model];
    }
    _topView.dataArr = self.topArr.copy;
    
    for (int i = 0; i< self.topArr.count; i++) {
        TopDanXuanViewModel *vmodel = self.topArr[i];
        BaseCreatOrderFlowChart *flowChart = [CreatOrderFlowChartManager defaultOrderFlowChartManager].creatOrderFlowArr[i];
        flowChart.isSelect = vmodel.isSelect;
        if (!flowChart.isSelect) {
            //
            [flowChart qingKongData];
        }
    }
    
    if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel = self.mainModel;
        if (self.mainModel.order_typeArray.count>0) {
            for (int h = 0; h<self.mainModel.order_typeArray.count; h++) {
                if ([self.mainModel.order_typeArray[h] isEqualToString:@"事故车"]) {
                    //事故车
                    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保险",@"非保险", nil];
                    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
                    [sheet showInView:self.view];
                }
            }
        }
    }
    
    self.bottomView = [LCBottomView new];
    [self.view addSubview:_bottomView];
    
    
    
    
    
    
    //发送消息
    _bottomView.sendMessage = ^(id model) {
        @strongify(self);
        [self.messageListView addMessageViewModel:model];
    };
    //下一步
    _bottomView.nextStep = ^{
        @strongify(self);
        /*
         保养
         二级维护
         */
        BOOL isSelect = NO;
        for (BaseCreatOrderFlowChart *baseFlowChart in [CreatOrderFlowChartManager defaultOrderFlowChartManager].creatOrderFlowArr) {
            isSelect = isSelect || baseFlowChart.isSelect;
        }
        if (!isSelect) {
            [self showBackView];
            return ;
        }
        
        if ([CreatOrderFlowChartManager defaultOrderFlowChartManager].maintenance.isSelect) {
            
            //跳保养
            NSLog(@"跳保养");
            MaintenanceProjectViewController *maintenanceVC = [MaintenanceProjectViewController new];
            [self.navigationController pushViewController:maintenanceVC animated:YES];
        }else if ([CreatOrderFlowChartManager defaultOrderFlowChartManager].secondarySafeguard.isSelect){
           
            //跳二级维护流程
            RepairSecondViewController *repairSecondVC = [RepairSecondViewController new];
            [self.navigationController pushViewController:repairSecondVC animated:YES];
            NSLog(@"跳二级维护流程");
        }else if ([CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isSelect){
            
            //直接跳工单
            OrderCreatViewController *orderCreat = [OrderCreatViewController new];
            [self.navigationController pushViewController:orderCreat animated:YES];
            NSLog(@"直接跳工");
        }else if ([CreatOrderFlowChartManager defaultOrderFlowChartManager].smallFix.isSelect){
            
            //直接跳工单
            OrderCreatViewController *orderCreat = [OrderCreatViewController new];
            [self.navigationController pushViewController:orderCreat animated:YES];
            NSLog(@"直接跳工");
        }
    };
    
    self.messageListView = [[LCMessageListView alloc]init];
    [self.view addSubview:_messageListView];
    [_messageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(0);
    }];
    
    if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
        NSMutableArray *neArray = [[NSMutableArray alloc]init];
        if (self.mainModel.info.count > 0) {
            for (int i = 0; i< self.mainModel.info.count; i++) {
                NSDictionary *dict = self.mainModel.info[i];
                LCMessageViewModel *model = [[LCMessageViewModel alloc]init];
                model.timeStamp = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.timeStamp longValue]];;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM-dd HH:mm"];
                model.time = [dateFormatter stringFromDate:date];
                model.message = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"info")];
                model.cell_H = [self setMessage:model.message];
                
                [neArray addObject:model];
                }
        }
        
        [self.messageListView addMessageViewModels:neArray];
    }
}
- (CGFloat )setMessage:(NSString *)message{
    
    if (message.length<=0) {
        return 40;
    }else{
        CGFloat maxImgv_W = kScreenWidth - 100 - 15;
        
        CGFloat height = 0;
        height = [message heightForFont:[UIFont pf_PingFangSCRegularFontOfSize:15] width:maxImgv_W];
        
        return height + 40;
    }
}

#pragma mark ****** 代理 ***********
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //保险
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isBaoXian = YES;
        TopDanXuanViewModel *model = self.topArr[2];
        model.isSelect = YES;
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isSelect = YES;
    }else if (buttonIndex == 1){
        //非保险
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isBaoXian = NO;
        TopDanXuanViewModel *model = self.topArr[2];
        model.isSelect = YES;
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isSelect = YES;
    }else if(buttonIndex == 2){
        //取消
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isBaoXian = NO;
        TopDanXuanViewModel *model = self.topArr[2];
        model.isSelect = NO;
        [[CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar qingKongData];
        [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isSelect = NO;
    }
    NSLog(@"%ld",buttonIndex);
    [_topView reloadData];
}

#pragma mark ****** 代理 ***********
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    TopDanXuanViewModel *model = self.topArr[2];
    model.isSelect = NO;
    [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isSelect = NO;
    [_topView reloadData];
}

- (void)showBackView
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 4;
    backView.layer.masksToBounds = YES;
    [self.backView addSubview:backView];
    backView.alpha = 1;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 150));
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-50);
    }];
    UIButton *queDingBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [backView addSubview:bt];
        [bt setTitle:@"确定" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        [bt setTitleColor:kBOSSZhuTiColor forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self.backView removeAllSubviews];
            [self.backView removeFromSuperview];
        }];
        bt;
    });
    UILabel *titleLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [backView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        lb.textColor = UIColorHex(#666666);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"请选择维修类别";
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(queDingBT.mas_top).mas_equalTo(0);
        }];
        lb;
    });
    UIView *lineVeiw = ({
        UIView *v = [[UIView alloc]init];
        [titleLB addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        v;
    });
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self.backView];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _backView;
}
@end
