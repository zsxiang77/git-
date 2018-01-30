//
//  FillInforMationErVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillInforMationErVC.h"
#import "NetWorkManagerGet.h"
#import "FillInforMationErModel.h"

@interface FillInforMationErVC ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate>
{
    NSMutableArray *shangArray;
    NSMutableArray *xiaArray;
}

@property(nonatomic,strong)UITableView *mainTableView;



@end

@implementation FillInforMationErVC

- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}
#pragma 键盘的通知
- (void) keyboardWillShow:(NSNotification*)noti
{
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-40 - keyboardFrameBeginRect.size.height);
        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-40-60);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"填入信息" withBackButton:YES];
    self.view.backgroundColor = kRGBColor(240, 240, 240);
    shangArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<3; i++) {
        FillInforMationErModel *model = [[FillInforMationErModel alloc]init];
        if (i == 0) {
            model.name = @"汽车维护";
        }else if (i == 1){
            model.name = @"事故修理";
        }else if (i == 2){
            model.name = @"故障修理";
        }
        [shangArray addObject:model];
    }
    
    xiaArray = [[NSMutableArray alloc]init];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
    titleLabel.text = @"2.填写维修信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-40-60) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(10, kWindowH-60, kWindowW-20, 40)];
    [okButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:okButton];
    
    [self getRequest_method];
}

-(void)okButtonChick:(UIButton *)sender
{
    BOOL shif1 = NO;
    for (int i = 0; i<shangArray.count; i++) {
        FillInforMationErModel *model = shangArray[i];
        if (model.xuanZhong == YES) {
            shif1 = YES;
            if (i== 0) {
                self.zuiZhongModel.repairnature = @"10";
//                self.zuiZhongModel.repairnature = @"30";
            }else if (i==1)
            {
                self.zuiZhongModel.repairnature = @"30";
            }else
            {
                self.zuiZhongModel.repairnature = @"20";
//                self.zuiZhongModel.repairnature = @"30";
            }
        }
    }
    if (self.schemeTextView.text.length <= 0&&[[UserInfo shareInstance].isExplod boolValue] != YES) {
        [self showMessageWithContent:@"请填写故障描述" point:self.view.center afterDelay:2.0];
        return;
    }else
    {
        self.zuiZhongModel.repair_describe = self.schemeTextView.text;
    }
    if (shif1 == NO) {
        [self showMessageWithContent:@"请选择维修性质" point:self.view.center afterDelay:2.0];
        return;
    }
    
    
    BOOL shiFouBeiJing = [[UserInfo shareInstance].isExplod boolValue];
    if (shiFouBeiJing == YES) {
        BOOL shif2 = NO;
        for (int i = 0; i<xiaArray.count; i++) {
            FillInforMationErModel *model = xiaArray[i];
            if (model.xuanZhong == YES) {
                shif2 = YES;
                self.zuiZhongModel.repairtype = model.name;
            }
        }
        if (shif2 == NO) {
            [self showMessageWithContent:@"请选择维修类型" point:self.view.center afterDelay:2.0];
            return;
        }
    }
    
    CarInspectionViewController *vc = [[CarInspectionViewController alloc]init];
    vc.zuiZhongModel = self.zuiZhongModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getRequest_method
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/repair_order/repair_types",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            
            return ;
        }
        
        NSString *types = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"types")];
        NSArray *typesArray = [types componentsSeparatedByString:@","];
        
        [xiaArray removeAllObjects];
        for (int i = 0; i< typesArray.count;i++ ) {
            FillInforMationErModel *model = [[FillInforMationErModel alloc]init];
            model.name = typesArray[i];
            [xiaArray addObject:model];
        }
        
        [weakSelf.mainTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return shangArray.count;
    }else{
        return xiaArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    FillInforMationErCell *cell = (FillInforMationErCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[FillInforMationErCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    
    FillInforMationErModel *model;
    if (indexPath.section == 0) {
        model = shangArray[indexPath.row];
    }else
    {
        model = xiaArray[indexPath.row];
    }
    cell.zuoTitelLabel.text = model.name;
    if (model.xuanZhong == YES) {
        cell.xuanZhongImaheView.image = DJImageNamed(@"cell_select");
    }else{
        cell.xuanZhongImaheView.image = DJImageNamed(@"cell_noselect");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        for (int i = 0; i<shangArray.count; i++) {
            FillInforMationErModel *model = shangArray[i];
            model.xuanZhong = NO;
        }
        
        FillInforMationErModel *model2 = shangArray[indexPath.row];
        model2.xuanZhong = YES;
    }else{
        for (int i = 0; i<xiaArray.count; i++) {
            FillInforMationErModel *model = xiaArray[i];
            model.xuanZhong = NO;
        }
        
        FillInforMationErModel *model2 = xiaArray[indexPath.row];
        model2.xuanZhong = YES;
    }
    [self.mainTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vibj = [[UIView alloc]init];
    vibj.backgroundColor = kRGBColor(245, 245, 245);
    if (section == 0) {
        UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowW-20, 40)];
        shuoMingLabel.textColor = [UIColor grayColor];
        shuoMingLabel.text = @"客户需求及故障描述：";
        [vibj addSubview:shuoMingLabel];
        
        UIView *backVWhite = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 70)];
        backVWhite.backgroundColor = [UIColor whiteColor];
        [vibj addSubview:backVWhite];
        
        self.schemeTextView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 70)];
//        self.schemeTextView.isScrollable = NO;
        self.schemeTextView.minNumberOfLines = 1;
        self.schemeTextView.maxNumberOfLines = 6;
        self.schemeTextView.text = self.zuiZhongModel.repair_describe;
        self.schemeTextView.maxHeight = 70;
        self.schemeTextView.font = [UIFont systemFontOfSize:13];
        self.schemeTextView.delegate = self;
        self.schemeTextView.returnKeyType = UIReturnKeyDone;
        self.schemeTextView.placeholder = @"请输入内容...";
        self.schemeTextView.placeholderColor = kRGBColor(220, 220, 220);
        [vibj addSubview:self.schemeTextView];
        
        
        
        
        UILabel *mianLabel = [[UILabel alloc]init];
        mianLabel.textColor = [UIColor grayColor];
        [vibj addSubview:mianLabel];
        [mianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        mianLabel.text = @"维修性质";
    }else
    {
        UILabel *mianLabel = [[UILabel alloc]init];
        mianLabel.textColor = [UIColor grayColor];
        [vibj addSubview:mianLabel];
        [mianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        mianLabel.text = @"维修类型";
    }
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [vibj addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    return vibj;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 150;
    }
    
    return 40;
}
-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    if (growingTextView == self.schemeTextView) {
        self.zuiZhongModel.repair_describe = self.schemeTextView.text;
    }
}
- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.schemeTextView resignFirstResponder];
        return NO;
    }
    
    if (self.schemeTextView.text.length>255) {//50字
        return NO;
    }else
    {
        return YES;
    }
    
}

@end
