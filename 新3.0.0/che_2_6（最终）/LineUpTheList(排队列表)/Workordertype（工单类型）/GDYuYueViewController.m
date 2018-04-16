//
//  GDYuYueViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "GDYuYueViewController.h"
#import "OrderDetailModel.h"

@interface GDYuYueViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSDictionary *mainDict;
@property(nonatomic,strong)NSMutableArray *subjectArray;
@property(nonatomic,strong)NSMutableArray *partsArray;

@end

@implementation GDYuYueViewController

-(void)huoQuData
{

    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    NSArray *order_list = KISDictionaryHaveKey(self.userInformetionDict, @"order_list");
    NSString *ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(order_list[0], @"ordercode")];
    [mDict setObject:ordercode forKey:@"ordercode"];

    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
       
        NSDictionary* dataDic = kParseData(responseObject);
        weakSelf.mainDict = dataDic;
        NSArray *subject = KISDictionaryHaveKey(dataDic, @"subject");
        if ([subject isKindOfClass:[NSArray class]]) {
            [weakSelf.subjectArray removeAllObjects];
            for (int i = 0; i<subject.count; i++) {
                OrderDetailSubjectsModel *model = [[OrderDetailSubjectsModel alloc]init];
                [model setdataWithDict:subject[i]];
                [weakSelf.subjectArray addObject:model];
            }
        }
        
        NSArray *parts = KISDictionaryHaveKey(dataDic, @"parts");
        if ([parts isKindOfClass:[NSArray class]]) {
            [weakSelf.subjectArray removeAllObjects];
            for (int i = 0; i<parts.count; i++) {
                OrderDetailPartsModel *model = [[OrderDetailPartsModel alloc]init];
                [model setdataWithDict:subject[i]];
                [weakSelf.subjectArray addObject:model];
            }
        }
       

        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"工单预约" withBackButton:YES];
    
    self.subjectArray = [[NSMutableArray alloc]init];
    self.partsArray = [[NSMutableArray alloc]init];
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-53) style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self huoQuData];
}

-(void)queDingBtChick:(UIButton *)sender
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.subjectArray.count;
    }else{
        return self.partsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    GDYuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[GDYuYueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[ UIView alloc]init];
    v.backgroundColor = [UIColor whiteColor];
    UIImageView *zuoImaView = [[UIImageView alloc]init];
    [v addSubview:zuoImaView];
    [zuoImaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(v);
        make.width.height.mas_equalTo(20);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = kRGBColor(74, 74, 74);
    [v addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zuoImaView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(v);
    }];
    
    
    UIButton *bt = [[UIButton alloc]init];
    bt.tag = 2000+section;
    [bt.layer setMasksToBounds:YES];
    [bt.layer setCornerRadius:3];
    [bt.layer setBorderColor:kZhuTiColor.CGColor];
    [bt.layer setBorderWidth:1];
    [bt setTitle:@"取消全选" forState:(UIControlStateNormal)];
    [v addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(100);
    }];
    
    if (section == 0) {
        zuoImaView.image = DJImageNamed(@"ic_sa_info_project");
        titleLabel.text = [NSString stringWithFormat:@"项目(%ld)",self.subjectArray.count];
    }else{
        zuoImaView.image = DJImageNamed(@"ic_sa_info_parts");
        titleLabel.text = [NSString stringWithFormat:@"配件(%ld)",self.partsArray.count];
    }
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v= [[UIView alloc]init];
    v.backgroundColor = self.view.backgroundColor;
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
@end
