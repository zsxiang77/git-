//
//  ViewPerfectInformationVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ViewPerfectInformationVC.h"
#import "ViewPerfectInformationCell.h"

@interface ViewPerfectInformationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation ViewPerfectInformationVC

- (void)setupView
{
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, 0, 4)];
    _progressView.top = m_baseTopView.bottom;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"B4EC51"].CGColor, (__bridge id)[UIColor colorWithHexString:@"39D1BD"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 0, 4);
    _gradientLayer = gradientLayer;
    [_progressView.layer addSublayer:gradientLayer];
    [self.view addSubview:_progressView];
}

- (void)updateUI {
    CGFloat progress = [KISDictionaryHaveKey(self.mainDict, @"inspect_percent") floatValue];;
    
    
    if (progress < 50) {
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"F5515F"].CGColor, (__bridge id)[UIColor colorWithHexString:@"FF9C55"].CGColor];
    }else{
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"B4EC51"].CGColor, (__bridge id)[UIColor colorWithHexString:@"39D1BD"].CGColor];
    }
    progress = progress/100.0;
    _progressView.width = kScreenWidth * progress;
    _gradientLayer.width = kScreenWidth * progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"查看信息" withBackButton:YES];
    self.listArray = [[NSMutableArray alloc]init];
    [self setupView];
    
    [self postInspect_detail];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+4, kWindowW, kWindowH-(kNavBarHeight+4)) style:(UITableViewStylePlain)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}


#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    ViewPerfectInformationCell *cell = (ViewPerfectInformationCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[ViewPerfectInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    
    cell.superViewController = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ViewPerfectInformationModel *model = self.listArray[indexPath.section];
    [cell refeleseWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewPerfectInformationModel *model = self.listArray[indexPath.section];
    if ([model.key isEqualToString:@"user_info"]) {
        return 224;
    }else if ([model.key isEqualToString:@"car_info"]) {
        return 37*12;
    }else if ([model.key isEqualToString:@"insurance_info"]) {
        return 287;
    }else if ([model.key isEqualToString:@"inspect_info"]) {
        ViewPerfectInformationInspect_infoModel *inspect_infoModel = [[ViewPerfectInformationInspect_infoModel alloc]init];
        [inspect_infoModel setdataWithDict:model.value];
        CGFloat jiSuanH = 42;
        if (inspect_infoModel.image_info_sum.count>0) {
            jiSuanH += 60;
        }
        if (inspect_infoModel.images.count>0) {
            jiSuanH += 96;
        }
        return jiSuanH;
    }else if ([model.key isEqualToString:@"goods_info"]) {
        ViewPerfectInformationGoods_infoModel *gongModel = [[ViewPerfectInformationGoods_infoModel alloc]init];
        [gongModel setdataWithDict:model.value];
        if (gongModel.goods.count<=0) {
            return 42;
        }else{
            NSInteger shul = 0;
            for (int i = 0; i<gongModel.goods.count; i++) {
                BOOL shif = [KISDictionaryHaveKey(gongModel.goods[i], @"bool") boolValue];
                if (shif == YES) {
                    shul++;
                }
            }
            
            NSInteger jis = (shul+1)/2;
            return 42+jis*40;
        }
    }else if ([model.key isEqualToString:@"functions_info"]) {
        ViewPerfectInformationFunctions_infoModel *gongModel = [[ViewPerfectInformationFunctions_infoModel alloc]init];
        [gongModel setdataWithDict:model.value];
        return 42+gongModel.functions.count*40;
    }else if ([model.key isEqualToString:@"gas_info"]) {
        return 80;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *touImageView = [[UIImageView alloc]init];
    [headerView addSubview:touImageView];
    [touImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(headerView);
    }];
    touImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *leiXieLabel = [[UILabel alloc]init];
    leiXieLabel.font = [UIFont boldSystemFontOfSize:15];
    leiXieLabel.textColor = kRGBColor(51, 51, 51);
    [headerView addSubview:leiXieLabel];
    [leiXieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.centerY.mas_equalTo(headerView);
    }];
    
    UILabel *wanShanLabel = [[UILabel alloc]init];
    wanShanLabel.font = [UIFont boldSystemFontOfSize:12];
    wanShanLabel.textColor = kRGBColor(133, 133, 133);
    [headerView addSubview:wanShanLabel];
    [wanShanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(headerView);
    }];
     ViewPerfectInformationModel *model = self.listArray[section];
    
    wanShanLabel.text = [NSString stringWithFormat:@"%ld%%",[model.percent integerValue]];
    if ([model.percent integerValue] > 50) {
        wanShanLabel.textColor = [UIColor colorWithHexString:@"62AC0D"];
    }
    else if ([model.percent integerValue] < 50) {
        wanShanLabel.textColor = [UIColor colorWithHexString:@"FF383D"];
    }
    else {
        wanShanLabel.textColor = [UIColor colorWithHexString:@"E38D00"];
    }
    
    UILabel *la1 = [[UILabel alloc]init];
    la1.font = [UIFont boldSystemFontOfSize:12];
    la1.textColor = kRGBColor(133, 133, 133);
    la1.text = @"已完善";
    [headerView addSubview:la1];
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wanShanLabel.mas_left).mas_equalTo(-2);
        make.centerY.mas_equalTo(headerView);
    }];
    
   
    NSString *iconName = [NSString stringWithFormat:@"info_%@",model.key];
    touImageView.image = DJImageNamed(iconName);
    if ([model.key isEqualToString:@"user_info"]) {
        leiXieLabel.text = @"客户信息";
    }else if ([model.key isEqualToString:@"car_info"]) {
        leiXieLabel.text = @"车辆信息";
    }else if ([model.key isEqualToString:@"insurance_info"]) {
        leiXieLabel.text = @"保险信息";
    }else if ([model.key isEqualToString:@"inspect_info"]) {
        leiXieLabel.text = @"外观检查";
    }else if ([model.key isEqualToString:@"goods_info"]) {
        leiXieLabel.text = @"随车装备";
        touImageView.image = DJImageNamed(@"info_goods");
    }else if ([model.key isEqualToString:@"functions_info"]) {
        leiXieLabel.text = @"功能检查";
        touImageView.image = DJImageNamed(@"info_functions");
    }else if ([model.key isEqualToString:@"gas_info"]) {
        leiXieLabel.text = @"油量里程";
        touImageView.image = DJImageNamed(@"info_gas");
    }else{
        leiXieLabel.text = @"";
    }
    
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

@end
