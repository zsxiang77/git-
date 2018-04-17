//
//  TheWorkbenchSearchViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheWorkbenchSearchViewController.h"
#import "PlateIDCameraViewController.h"

@interface TheWorkbenchSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TheWorkbenchSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"" withBackButton:YES];
    
    qieHuanView = [[BJDC_headerTitleView alloc]initWithFrameNew:CGRectMake(0, kNavBarHeight, kWindowW, 40) childVcs:@[@"车牌号",@"手机号",@"工单号",@"VIN"] withhasAppointmentBetShow:0];
    kWeakSelf(weakSelf)
    qieHuanView.selectFanHui = ^(NSInteger index) {
        [weakSelf postSearchrequest_methodDatawithShuaXin:YES];
    };
    qieHuanView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:qieHuanView];
    [self buildMainViewWitharray:self.channelsArray];
    [self buildSearchView];
    self.seachTableView.hidden = NO;
}

-(void)backButtonClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 分栏
- (void)buildMainViewWitharray:(NSArray *)array
{
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    if (![array isKindOfClass:[NSArray class]]) {
        return;
    }
    CGFloat jisuanKuai = (105/2)+35/2;
    CGFloat jisuanZongWight = (105/2)+35/2+53/4;
    for (int i = 0; i < array.count; i++) {
        if (!m_mySegBtn[i]) {
            m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        }
        if (i==0) {
            m_mySegBtn[i].frame = CGRectMake(0, 0, jisuanKuai, 43);
        }else{
            m_mySegBtn[i].frame = CGRectMake(jisuanZongWight+(jisuanZongWight-jisuanKuai), 0, jisuanKuai, 43);
        }
        m_mySegBtn[0].selected = YES;
        
        [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] forState:UIControlStateNormal];
        if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] isEqualToString:@"维修"]) {
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group") forState:(UIControlStateNormal)];
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_select") forState:(UIControlStateSelected)];
        }
        if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] isEqualToString:@"洗美"]) {
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_xi") forState:(UIControlStateNormal)];
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_xi_select") forState:(UIControlStateSelected)];
        }
        m_mySegBtn[i].imageEdgeInsets = UIEdgeInsetsMake(10, -5, 10, 50);
        m_mySegBtn[i].titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kZhuTiColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        if (m_mySegBtn[i].selected == YES) {
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }else{
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
        
        m_mySegBtn[i].tag = i;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake((jisuanKuai - 105/2)/2, 43-1.5, 105/2, 1.5)];
    bottomView.backgroundColor = kZhuTiColor;
    if (!m_segButtonsView) {
        m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake((kWindowW-(array.count*jisuanZongWight))/2,kNavBarHeight-43, array.count*jisuanZongWight, 43) buttonArray:btns bottomView:bottomView];
        
        m_segButtonsView.backgroundColor = [UIColor clearColor];
        [m_baseTopView addSubview:m_segButtonsView];
    }
    
    if (self.shiFouWeiXiu == YES) {
        [m_segButtonsView setButtonSelectedWithIndex:0];
    }else{
        [m_segButtonsView setButtonSelectedWithIndex:1];
    }
    
}

#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{
    if (self.searchText.text.length>0) {
        [self postSearchrequest_methodDatawithShuaXin:YES];
    }
}
- (void)buildSearchView
{
    UIView* searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+40, CGRectGetWidth(self.view.frame), 50)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.hidden = NO;
    [self.view addSubview:searchBg];

    self.searchGrayBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kWindowW-20, 63/2)];
    self.searchGrayBg.backgroundColor = kRGBColor(244, 244, 244);
    self.searchGrayBg.layer.cornerRadius = 63/4;
    [self.searchGrayBg.layer setBorderWidth:0.5];
    [self.searchGrayBg.layer setBorderColor:kLineBgColor.CGColor];
    [searchBg addSubview:self.searchGrayBg];
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 20, 20)];
    self.searchImageView.image = DJImageNamed(@"search_gray");
    [self.searchGrayBg addSubview:self.searchImageView];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"search_blue")];
    [self.searchGrayBg addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    
    self.searchText = [[UITextField alloc] init];
    self.searchText.placeholder = @"请输入搜索内容";
    self.searchText.textColor = kRGBColor(51, 51, 51);
    self.searchText.font = DJSystemFont(14);
    self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchText.returnKeyType = UIReturnKeySearch;
    self.searchText.delegate = self;
    [self.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.searchGrayBg addSubview:self.searchText];
    [self.searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-38);
    }];
    
    UIImageView *saoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"扫描")];
    [self.searchGrayBg addSubview:saoImageView];
    [saoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    UIButton *saoButton = [[UIButton alloc]init];
    [saoButton addTarget:self action:@selector(saoButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchGrayBg addSubview:saoButton];
    [saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
}

-(void)saoButtonChick:(UIButton *)sender
{
    PlateIDCameraViewController *vc = [[PlateIDCameraViewController alloc]init];
    vc.shiFouHuiDiao = YES;
    kWeakSelf(weakSelf)
    vc.saoMiaoJieGUo = ^(NSString *jieGuo) {
        [weakSelf postSearchrequest_methodDatawithShuaXin:YES];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)seachTableView
{
    if (!_seachTableView) {
        self.seachArray = [[NSMutableArray alloc]init];
        _seachTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+90, kWindowW, kWindowH-90) style:(UITableViewStylePlain)];
        _seachTableView.backgroundColor = [UIColor whiteColor];
        _seachTableView.delegate = self;
        _seachTableView.dataSource = self;
        _seachTableView.tableFooterView = [[UIView alloc] init];
        _seachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_seachTableView];
        [self.view bringSubviewToFront:_seachTableView];
    }
    return _seachTableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *heav = [[UIView alloc]init];
    
    UILabel *zuoSla = [[UILabel alloc]init];
    zuoSla.textColor = kRGBColor(71, 71, 71);
    zuoSla.font = [UIFont boldSystemFontOfSize:16];
    zuoSla.text = [NSString stringWithFormat:@"搜索结果(%ld)",self.seachArray.count];
    [heav addSubview:zuoSla];
    [zuoSla mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(heav);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [heav addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    return heav;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seachArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    TheWorkbenchWeiXiuCell *cell = (TheWorkbenchWeiXiuCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[TheWorkbenchWeiXiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    TheWorkModel *model;
    model = self.seachArray[indexPath.row];
    
    [cell refeleseWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheWorkModel *model;
    model = self.seachArray[indexPath.row];
    
    if ([model.class_name isEqualToString:@"维修"]) {
        return 80;
    }else
    {
        return 110;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TheWorkModel *model;
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    model = self.seachArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanZhiModel = model;
    [self.navigationController  pushViewController:vc animated:YES];
}

#pragma mark - net
-(void)postSearchrequest_methodDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        self.searchIndex = 1;
    }
    [[self.seachTableView viewWithTag:4000 + 500] removeFromSuperview];
    [[self.seachTableView viewWithTag:4000 + 501] removeFromSuperview];
    
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    if (self.searchText.text.length>0) {
        [mDict setObject:self.searchText.text forKey:@"search"];
    }else{
        return;
    }
    
    if (qieHuanView.selectIndex == 0) {
        [mDict setObject:@"car_number" forKey:@"key"];
    }else if (qieHuanView.selectIndex == 1){
        [mDict setObject:@"mobile" forKey:@"key"];
    }else if (qieHuanView.selectIndex == 2){
        [mDict setObject:@"ordercode" forKey:@"key"];
    }else if (qieHuanView.selectIndex == 0){
        [mDict setObject:@"vin" forKey:@"key"];
    }else{
        [mDict setObject:@"" forKey:@"key"];
    }
    
    [mDict setObject:@"0" forKey:@"is_relation"];
    
    [mDict setObject:KISDictionaryHaveKey(array[m_segButtonsView.selectIndex], @"channel_id") forKey:@"ctype"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",self.searchIndex] forKey:@"page"];

    
    [mDict setObject:@"5" forKey:@"order_status"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.seachArray removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"order_list");
        for (int i = 0; i<order_list.count; i++) {
            TheWorkModel *model = [[TheWorkModel alloc]init];
            [model setdataWithDict:order_list[i]];
            [weakSelf.seachArray addObject:model];
        }
        
        
        
        
        [[self.seachTableView viewWithTag:4000 + 500] removeFromSuperview];
        [[self.seachTableView viewWithTag:4000 + 501] removeFromSuperview];
        if(weakSelf.seachArray.count<=0)
        {
            UIImageView *wuViweImage = [[UIImageView alloc]initWithImage:DJImageNamed(@"seach_wuData")];
            if (KIS_IPHONE_6P) {
                wuViweImage.frame = CGRectMake((kWindowW-173/2)/2, 80, 173/2, 221/2);
            }else{
                wuViweImage.frame = CGRectMake((kWindowW-173/2)/2, 80, 173/3, 221/3);
            }
            
            wuViweImage.tag = 4000 + 500;
            [weakSelf.seachTableView addSubview:wuViweImage];
            
            
            UILabel *zhanLabel = [[UILabel alloc]init];
            zhanLabel.font = [UIFont systemFontOfSize:14];
            zhanLabel.tag = 4000 + 501;
            zhanLabel.text = @"暂无相关订单";
            [weakSelf.seachTableView addSubview:zhanLabel];
            [zhanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(wuViweImage);
                make.top.mas_equalTo(wuViweImage.mas_bottom).mas_equalTo(10);
            }];
        }
        
        [weakSelf.seachTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == self.searchText) {
        if (self.searchText.text.length>18) {
            [self showMessageWindowWithTitle:@"最多18个字" point:self.view.center delay:1];
            self.searchText.text = [self.searchText.text substringToIndex:self.searchText.text.length-1];
            return;
        }
    }
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
    
    
    
    if (![noEmojiStr isEqualToString:textField.text]) {
        
        textField.text = noEmojiStr;
        
    }
    
    if (self.searchText.text.length>0) {
        [self postSearchrequest_methodDatawithShuaXin:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField.text length] == 0) {
        return YES;
    }
    return YES;
}

@end
