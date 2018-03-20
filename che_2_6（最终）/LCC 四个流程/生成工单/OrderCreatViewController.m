//
//  OrderCreatViewController.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderCreatViewController.h"
#import "LCBottomView.h"
#import "OrderChePaiCell.h"
#import "OrderClassCell.h"
#import "OrderProjectCell.h"
#import "OrderAccessoriesCell.h"
#import "LCMessageListView.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionModel.h"
#import "TopDanXuanViewModel.h"
#import "LCMessageViewModel.h"
#import "SCDDanViewController.h"
#import "WritePersonalViewController.h"

@interface OrderCreatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *headerDataArr;
@property (nonatomic, strong) NSMutableArray *classDataArr;   //分类
@property (nonatomic, strong) NSMutableArray *xiangMuDataArr; //项目
@property (nonatomic, strong) NSMutableArray *peiJianDaraArr; //配件
@property (nonatomic, strong) NSMutableArray *messageDataArr; //消息
@property (nonatomic, strong) UILabel *allPeeLB;
@end

@implementation OrderCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"生成工单" withBackButton:YES];
    self.classDataArr = @[].mutableCopy;
    self.xiangMuDataArr = @[].mutableCopy;
    self.peiJianDaraArr = @[].mutableCopy;
    self.messageDataArr = @[].mutableCopy;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[OrderChePaiCell class] forCellReuseIdentifier:@"OrderChePaiCell"];
        [tableView registerClass:[OrderClassCell class] forCellReuseIdentifier:@"OrderClassCell"];
        [tableView registerClass:[OrderProjectCell class] forCellReuseIdentifier:@"OrderProjectCell"];
        [tableView registerClass:[OrderAccessoriesCell class] forCellReuseIdentifier:@"OrderAccessoriesCell"];
        
        [tableView registerClass:[LCMessageListViewCell class] forCellReuseIdentifier:@"LCMessageListViewCell"];
        [tableView registerClass:[OrderSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"OrderSectionHeaderView"];
       
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.bottom.mas_equalTo(-50);
    }];
    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.view addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_offset(-49.5);
        }];
        v;
    });
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(49);
    }];
    
    UILabel*hejiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(47.5, 21));
            make.centerY.mas_equalTo(0);
        }];
        lb.text = @"0";
        lb;
    });
    hejiLB.text = @"合计:";
    UIImageView *im = ({
        UIImageView *im = [[UIImageView alloc]init];
        [bottomView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(hejiLB);
            make.left.mas_equalTo(hejiLB.mas_right).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(11.5, 11.5));
        }];
        im;
    });
    self.allPeeLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#FF001F);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(im.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(hejiLB);
        }];
        lb.text = @"0.00";
        lb;
    });
    
    UIButton *quDingBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [bottomView addSubview:bt];
        [bt setTitle:@"确定" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        [bt setTitleColor:UIColorHex(#ffffff) forState:UIControlStateNormal];
        bt.backgroundColor = UIColorHex(#4A90E2);
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth * 230 / 375);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self submitOrder];
        }];
        bt;
    });
    
    CreatOrderFlowChartManager *orderManager = [CreatOrderFlowChartManager defaultOrderFlowChartManager];
//    SmallFixCreatOrderFlowChart *smallFix       = orderManager.smallFix;    //小修
    MaintenanceCreatOrderFlowChart *maintenance = orderManager.maintenance; //保养
//    AccidentCarCreatOrderFlowChart *accidentCar = orderManager.accidentCar; //事故车
    SecondarySafeguardCreatOrderFlowChart *secondarySafeguard = orderManager.secondarySafeguard;//二级维护
    
    //分类数据
    for (BaseCreatOrderFlowChart *baseModel in orderManager.creatOrderFlowArr) {
        if (baseModel.isSelect) {
            TopDanXuanViewModel *model = [TopDanXuanViewModel new];
            model.title = baseModel.classTitle;
            model.imageName = baseModel.classImageName;
            [self.classDataArr addObject:model];
        }
    }
    
    
    //项目 //ProjectModel
//    maintenance.projectListModel.projectModelArr
//    secondarySafeguard.projectModelArr
    
    //ProjectModel 项目
    [self.xiangMuDataArr addObjectsFromArray:maintenance.projectListModel.projectModelArr];
    [self.xiangMuDataArr addObjectsFromArray:secondarySafeguard.projectModelArr];
    
    //PartsModel 配件
    [self.peiJianDaraArr addObjectsFromArray:maintenance.partsListModel.partsModelArr];
    if ([[CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel isKindOfClass:[CustomerInformationYYueModel class]]) {
        CustomerInformationYYueModel *newModel = [CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel;
        for (int i = 0; i<newModel.parts.count; i++) {
            PartsModel *mdel = [[PartsModel alloc]init];
            OrderDetailPartsModel *md = newModel.parts[i];
            mdel.partsName = md.parts_name;
            mdel.unitPrice = md.unit;
            mdel.num = md.parts_num;
            mdel.partsId = md.parts_id;
            [self.peiJianDaraArr addObject:mdel];
        }
    }
    
    
    //LCMessageViewModel 消息
    self.messageDataArr = [CreatOrderFlowChartManager defaultOrderFlowChartManager].messageVModelArr;
    
    OrderSectionModel *model2 = [OrderSectionModel new];
    if (self.xiangMuDataArr.count>0) {
        model2.title = [NSString stringWithFormat:@"项目(%ld)",self.xiangMuDataArr.count];
    }else{
        model2.title = @"项目";
    }
//    model2.title = maintenance.projectListModel.title ? maintenance.projectListModel.title : @"项目";
    model2.imageName = @"项目";
    float projectPrice = maintenance.projectListModel.allGongShiPrice + secondarySafeguard.allGongShiPrice;
//    NSLog(@"maintenance.projectListModel.allGongShiPrice == %lf",maintenance.projectListModel.allGongShiPrice);
//    NSLog(@"secondarySafeguard.allGongShiPrice = = %lf",secondarySafeguard.allGongShiPrice);
    model2.price =   projectPrice == 0 ? @"" : [NSString stringWithFormat:@"%.2lf",projectPrice];
    
    OrderSectionModel *model3 = [OrderSectionModel new];
    model3.title = maintenance.partsListModel.title ? maintenance.partsListModel.title : @"配件";
    model3.imageName = @"配件";
    model3.price = maintenance.partsListModel.allPeiJianPrice == 0 ? @"" : [NSString stringWithFormat:@"%.2lf",maintenance.partsListModel.allPeiJianPrice];
    
    OrderSectionModel *model4 = [OrderSectionModel new];
    model4.title = [NSString stringWithFormat:@"故障描述(%ld)",self.messageDataArr.count];
    model4.imageName = @"故障描述";
    model4.price = nil;
    _headerDataArr = @[@"",@"",model2,model3,model4];
    
//    float heJi = maintenance.projectListModel.allGongShiPrice + maintenance.partsListModel.allPeiJianPrice;
    float heJi = projectPrice + [model3.price floatValue];
    self.allPeeLB.text = [NSString stringWithFormat:@"%.2lf",heJi];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return self.xiangMuDataArr.count;
    }else if (section == 3){
        return self.peiJianDaraArr.count;
    }else if (section == 4){
        return self.messageDataArr.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        OrderChePaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderChePaiCell" forIndexPath:indexPath];
#warning 这里传 车牌号 传电话 传名字
        [cell bingViewModel:@"这里传 车牌号 传电话 传名字"];
        return cell;
    }else if (indexPath.section == 1){
        //分类
        OrderClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderClassCell" forIndexPath:indexPath];
        [cell bingViewModel:self.classDataArr];
        return cell;
    }else if (indexPath.section == 2){
        //项目
        OrderProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderProjectCell" forIndexPath:indexPath];
        [cell bingViewModel:self.xiangMuDataArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 3){
        //配件
        OrderAccessoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAccessoriesCell" forIndexPath:indexPath];
        [cell bingViewModel:self.peiJianDaraArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 4){
        
        LCMessageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMessageListViewCell" forIndexPath:indexPath];
        [cell bingViewModel:self.messageDataArr[indexPath.row]];
        return cell;
    }
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderSectionHeaderView"];
    if (section != 0 && section != 1) {
        [headerView bingViewModel:self.headerDataArr[section]];
    }
    return headerView;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    <#SectionFooterViewClass#> *footerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:<#Identifier#>];
//    return footerView;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 41;
    }else if (indexPath.section == 1){
        return 104 + 45;
    }else if (indexPath.section == 2){
        return 16+12;
    }else if (indexPath.section == 3){
        return 16+12;
    }else if (indexPath.section == 4 && self.messageDataArr.count>0){
        LCMessageViewModel *messageVM = self.messageDataArr[indexPath.row];
        return messageVM.cell_H;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0.00001;
    }
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ****** 提交订单 ***********


- (void)submitOrder{
    //项目
    NSDictionary *dic = @{}.mutableCopy;
    
    NSMutableArray *subjectsArr = @[].mutableCopy;
    for (int i=0; i<self.xiangMuDataArr.count; i++) {
        ProjectModel *project = self.xiangMuDataArr[i];
        NSString *name = project.projectName;
        NSString *subject_id = project.subjectId;
        NSString *hour = project.time;
        NSString *reality_fee = project.price;
        
        NSMutableDictionary *dic  = @{}.mutableCopy;
        [dic setValue:name forKey:@"name"];
        [dic setValue:subject_id forKey:@"subject_id"];
        [dic setValue:hour forKey:@"hour"];
        [dic setValue:reality_fee forKey:@"reality_fee"];
        
        [subjectsArr addObject:dic];
    }
    
    NSMutableArray *partsArr = @[].mutableCopy;
    for (int i=0; i<self.peiJianDaraArr.count; i++) {
        PartsModel *partsModel = self.peiJianDaraArr[i];
        NSString *parts_name = partsModel.partsName;
        NSString *parts_id   = partsModel.partsId;
        NSString *parts_num  = partsModel.num;
        NSString *parts_fee  = partsModel.unitPrice;
        
        NSMutableDictionary *dic  = @{}.mutableCopy;
        [dic setValue:parts_name forKey:@"parts_name"];
        [dic setValue:parts_id forKey:@"parts_id"];
        [dic setValue:parts_num forKey:@"parts_num"];
        [dic setValue:parts_fee forKey:@"parts_fee"];
        [partsArr addObject:dic];
    }
    if (subjectsArr.count > 0) {
        [dic setValue:subjectsArr forKey:@"subjects"];
    }
    if (partsArr.count > 0) {
        [dic setValue:partsArr forKey:@"parts"];
    }
    
    //电话
    NSString *mobile = self.userPhoneNum;
    if (LC_isStrEmpty(mobile)) {
//        //提示 手机号为空
//        [self showMessageWindowWithTitle:@"手机号为空" point:self.view.center delay:1];
//        return;
    }else{
        [dic setValue:self.userPhoneNum forKey:@"mobile"];
    }
    
    // 二级维护,小修,保养
    NSString *repairtype = @"";
    for (int i=0; i<self.classDataArr.count; i++) {
        TopDanXuanViewModel *model = self.classDataArr[i];
        
        if (repairtype.length<=0) {
            repairtype  = [NSString stringWithFormat:@"%@",model.title];
        }else{
            repairtype  = [NSString stringWithFormat:@"%@,%@",repairtype,model.title];
        }
    }
    
    // is_insurance 是否走保险
    AccidentCarCreatOrderFlowChart *accidentCar = [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar;
    if (accidentCar.isSelect) {
        //1走保险，2不走保险
        if (accidentCar.isBaoXian) {
            //走保险
            [dic setValue:@"1" forKey:@"is_insurance"];
        }else{
            //不走保险
            [dic setValue:@"2" forKey:@"is_insurance"];
        }
    }
    
    //聊天
    if (self.messageDataArr.count>0) {
        NSMutableArray *messageDicArr = @[].mutableCopy;
        for (LCMessageViewModel *vModel in self.messageDataArr) {
            NSMutableDictionary *messageDic = @{}.mutableCopy;
            NSString *time = vModel.timeStamp;
            NSString *info = vModel.message;
            [messageDic setValue:time forKey:@"time"];
            [messageDic setValue:info forKey:@"info"];
            [messageDicArr addObject:messageDic];
        }
        NSString *jsonStr = [messageDicArr jsonStringEncoded];
        [dic setValue:jsonStr forKey:@"description"];
    }
    //targetid 否 int 车id
    //plate_color 车牌色
    NSString *plate_color = @"蓝色";
    if ([UserInfo shareInstance].userInformetionDict) {
        NSArray *users_carsArray = KISDictionaryHaveKey([UserInfo shareInstance].userInformetionDict, @"users_cars");
        NSDictionary *users_carsDict = users_carsArray[0];
        [dic setValue:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"car_id")] forKey:@"targetid"];
        plate_color = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"car_body_color")];
    }
    if (plate_color.length<=0) {
        plate_color = @"蓝色";
    }
    if (LC_isStrEmpty(plate_color)) {
        [self showMessageWindowWithTitle:@"车牌信息不全" point:self.view.center delay:1];
        return ;
    }else{
        [dic setValue:plate_color forKey:@"plate_color"];
    }
    
//    NSString *car_number = [CreatOrderFlowChartManager defaultOrderFlowChartManager].chePaiDict.chePaiStr;
    NSString *car_number = [UserInfo shareInstance].chuanCheArrayStr;
    if (LC_isStrEmpty(car_number)) {
        [self showMessageWindowWithTitle:@"车牌信息不全" point:self.view.center delay:1];
        return ;
    }else{
        [dic setValue:car_number forKey:@"car_number"];
    }
    
    
    if ([UserInfo shareInstance].userInformetionDict) {
        NSDictionary *users_details = KISDictionaryHaveKey([UserInfo shareInstance].userInformetionDict, @"users_details");
        [dic setValue:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")] forKey:@"store_alias"];
        [dic setValue:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"user_id")] forKey:@"user_id"];
    }else{
        [dic setValue:[UserInfo shareInstance].user_id forKey:@"user_id"];
    }
    
    if ([[CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel isKindOfClass:[CustomerInformationYYueModel class]]) {
        [dic setValue:[CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel.ordercode forKey:@"ordercode"];
    }
    
    

    
//    "send_mobile": "19920310305",
//    "send_name": "送修人",
//    "send_id_card": "410112113114",
//    "id_card": "110112113114",
//    "user_id": "391"
    
    //
    
    NSString *info = [dic jsonStringEncoded];
    
    NSLog(@"info =  %@",info);

    NSMutableDictionary *parametes = @{}.mutableCopy;
    [parametes setValue:info forKey:@"info"];
    [NetWorkManager requestWithParameters:parametes withUrl:@"order/new_order/create_repair" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSString *ordercode = [[responseObject objectForKey:@"data"] objectForKey:@"ordercode"];
        
        if (![ordercode isEmptyOrWhitespace]) {
            if ([UserInfo shareInstance].shiFouShouDong == YES) {
                [MobClick event:@"Finish_Order_Self_Motion_Manual_Operation_wei"];
            }else{
                [MobClick event:@"Finish_Order_Self_Motion_wei"];
            }
            
            
//            bbn
            [OrderInfoPushManager sharedOrderInfoPushManager].type = OrderInfoPushTypeBuildOrder;
            [CreatOrderFlowChartManager defaultOrderFlowChartManager].orderNun = ordercode;
            SCDDanViewController *vc = [[SCDDanViewController alloc]init];
            vc.ordercode = ordercode;
            [self.navigationController pushViewController:vc animated:YES];
            

        } else {
            [self showAlertViewWithTitle:[responseObject objectForKey:@"msg"] Message:nil buttonTitle:@"确定"];
        }
       
        
//        {
//            code = 200;
//            data =     {
//                ordercode = 0020100180411781;
//            };
//            msg = success;
//        }
        
    } failure:^(id error) {
         NSLog(@"error =  %@",error);
    }];
    

}



@end
