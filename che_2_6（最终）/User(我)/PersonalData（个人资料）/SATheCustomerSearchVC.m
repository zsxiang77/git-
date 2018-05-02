//
//  TheCustomerSearchVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/19.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "SATheCustomerSearchVC.h"
#import "TheCustomerCell.h"
#import "BJDC_headerTitleView.h"
#import "TheCustomerGeRenVC.h"


@interface SATheCustomerSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BJDC_headerTitleView          *m_scrollPageView;
}
@property(nonatomic,strong)UITextField *mainTextField;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray  *mainDataArray;

@property(nonatomic,strong)UIView  *shangView;


@end

@implementation SATheCustomerSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"客户" withBackButton:YES];
    self.shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 44+55)];
    self.shangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shangView];
    UILabel *boline = [[UILabel alloc]init];
    boline.backgroundColor = kLineBgColor;
    [self.shangView addSubview:boline];
    [boline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *souSuoKangView = [[UIView alloc]init];
    [souSuoKangView.layer setMasksToBounds:YES];
    [souSuoKangView.layer setCornerRadius:16];
    [souSuoKangView.layer setBorderColor:kLineBgColor.CGColor];
    [souSuoKangView.layer setBorderWidth:1];
    [self.shangView addSubview:souSuoKangView];
    [souSuoKangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.top.mas_equalTo(6);
        make.right.mas_equalTo(-57);
        make.height.mas_equalTo(32);
    }];
    
    UIImageView *biaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"BOOss_souSuo")];
    [souSuoKangView addSubview:biaoImageView];
    [biaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.centerY.mas_equalTo(souSuoKangView);
        make.width.height.mas_equalTo(19);
    }];
    
    
    self.mainTextField = [[UITextField alloc] init];
    self.mainTextField.placeholder = @"请输入手机号/姓名";
    self.mainTextField.textColor = kRGBColor(51, 51, 51);
    self.mainTextField.font = DJSystemFont(14);
    self.mainTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mainTextField.returnKeyType = UIReturnKeySearch;
    self.mainTextField.delegate = self;
    [self.mainTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [souSuoKangView addSubview:self.mainTextField];
    [self.mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-7);
    }];
    
    UIButton *searchClearBt = [[UIButton alloc]init];
    [searchClearBt setTitle:@"取消" forState:(UIControlStateNormal)];
    searchClearBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [searchClearBt setTitleColor:kRGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    [searchClearBt addTarget:self action:@selector(searchClearBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shangView addSubview:searchClearBt];
    [searchClearBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(souSuoKangView);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(57);
    }];
    
    
    [self.mainTextField becomeFirstResponder];
    
    [self setPlayTitleWithDangQian:YES];
}

-(void)setPlayTitleWithDangQian:(BOOL)qiehuan
{
    if(m_scrollPageView != nil){
        [m_scrollPageView removeFromSuperview];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    NSMutableArray *kebianArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        if (i == 0) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_count")];
            NSString *str2 = @"全部";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 1) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"A_count")];
            NSString *str2 = @"A类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 2) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"B_count")];
            NSString *str2 = @"B类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 3) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"C_count")];
            NSString *str2 = @"C类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 4) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"D_count")];
            NSString *str2 = @"D类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"loss_count")];
            NSString *str2 = @"流失";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }
        
        [kebianArray addObject:dict];
    }
    
    NSArray *childVcs = kebianArray;
    
    NSInteger BetShow = 0;
    m_scrollPageView = [[BJDC_headerTitleView alloc] initWithFrame:CGRectMake(0, 44, kWindowW, 55) childVcs:childVcs withhasAppointmentBetShow:BetShow];
    kWeakSelf(weakSelf)
    m_scrollPageView.selectFanHui = ^(NSInteger index){
        [weakSelf postwork_boardwithShuaXin:YES];
        
    };
    [self.shangView addSubview:m_scrollPageView];
    [self.shangView sendSubviewToBack:m_scrollPageView];
    [m_scrollPageView qingZhiXuanZHong:self.selelctIndex];
}



-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+44+55, kWindowW, kWindowH-(kNavBarHeight+44+55)) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}
-(void)searchClearBtChick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        [self.mainTextField resignFirstResponder];
        [self postwork_boardwithShuaXin:YES];
        return YES;
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)sender
{
    
    if (self.mainTextField.text.length>18) {
        [self showMessageWindowWithTitle:@"最多18个字" point:self.view.center delay:1];
        self.mainTextField.text = [self.mainTextField.text substringToIndex:self.mainTextField.text.length-1];
        return;
    }
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:self.mainTextField.text options:0 range:NSMakeRange(0, self.mainTextField.text.length) withTemplate:@""];
    
    
    
    if (![noEmojiStr isEqualToString:self.mainTextField.text]) {
        
        self.mainTextField.text = noEmojiStr;
        
    }
    
    if (self.mainTextField.text.length>0) {
        [self postwork_boardwithShuaXin:YES];
    }
}

-(NSMutableArray *)mainDataArray
{
    if (!_mainDataArray) {
        _mainDataArray = [[NSMutableArray alloc]init];
    }
    return _mainDataArray;
}

-(void)postwork_boardwithShuaXin:(BOOL)shuaX
{
    if (self.mainTextField.text.length<=0) {
        return;
    }
    
    [[self.mainTableView viewWithTag:4000] removeFromSuperview];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:@"1" forKey:@"page"];
    [mDict setObject:self.mainTextField.text forKey:@"query"];
    [mDict setObject:@"" forKey:@"is_unit"];
    if (m_scrollPageView.selectIndex == 0) {
        [mDict setObject:@"" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 1) {
        [mDict setObject:@"0" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 2) {
        [mDict setObject:@"1" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 3) {
        [mDict setObject:@"2" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 4) {
        [mDict setObject:@"3" forKey:@"consume_type"];
    }else{
        [mDict setObject:@"4" forKey:@"consume_type"];
    }
    
    [mDict setObject:@"1" forKey:@"role_id"];
    kWeakSelf(weakSelf)
    [NetWorkManagerGet requestWithParametersGet:mDict withUrl:@"user/ucenter/consume_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if (code == 200) {
            if (shuaX == YES) {
                [weakSelf.mainDataArray removeAllObjects];
            }
            NSDictionary* dataDic = kParseData(responseObject);
            weakSelf.mainDataDict = dataDic;
            
            NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
            
            for (int i = 0; i<order_list.count; i++) {
                TheCustomerModel *model = [[TheCustomerModel alloc]init];
                [model setdataWithDict:order_list[i]];
                [weakSelf.mainDataArray addObject:model];
            }
            
            if(weakSelf.mainDataArray.count<=0)
            {
                UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
                cLabel.text = @"暂无搜索数据";
                cLabel.tag = 4000;
                cLabel.textAlignment = NSTextAlignmentCenter;
                cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
                cLabel.font = [UIFont boldSystemFontOfSize:20];
                cLabel.backgroundColor = [UIColor clearColor];
                [weakSelf.mainTableView addSubview:cLabel];
                
            }
            [weakSelf setheaderTitleNumber];
            [weakSelf.mainTableView reloadData];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(id error) {
        
    }];
    
}

-(void)setheaderTitleNumber
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *A_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"A_count")];
    NSString *B_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"B_count")];
    NSString *C_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"C_count")];
    NSString *D_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"D_count")];
    NSString *all_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_count")];
    NSString *loss_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"loss_count")];
    
    [array addObject:all_count];
    [array addObject:A_count];
    [array addObject:B_count];
    [array addObject:C_count];
    [array addObject:D_count];
    [array addObject:loss_count];
    
    [m_scrollPageView reloadTitlesWithNewTitles:array];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    TheCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[TheCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell refleshData:self.mainDataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = [UIColor whiteColor];
    UILabel *zuoline = [[UILabel alloc]init];
    zuoline.backgroundColor = kZhuTiColor;
    [headerV addSubview:zuoline];
    [zuoline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(headerV);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(15);
    }];
    
    UILabel  *biaoTiLabel = [[UILabel alloc]init];
    biaoTiLabel.textColor = kRGBColor(74, 74, 74);
    biaoTiLabel.font = [UIFont boldSystemFontOfSize:17];
    [headerV addSubview:biaoTiLabel];
    [biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(headerV);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [headerV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    biaoTiLabel.text = @"搜索结果";
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor grayColor];
    label2.text = [NSString stringWithFormat:@"(%ld)",self.mainDataArray.count];
    [headerV addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(biaoTiLabel.mas_right);
        make.centerY.mas_equalTo(headerV);
    }];
    
    return headerV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TheCustomerGeRenVC *vc = [[TheCustomerGeRenVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanZhiModel = self.mainDataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}




- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(weakSelf)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"拨号" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        TheCustomerModel *mdeol = weakSelf.mainDataArray[indexPath.row];
        [weakSelf bodaDianHuaWithDianHua:mdeol.mobile];
    }];
    action.backgroundColor = kRGBColor(74, 144, 226);
    return @[action];
}

-(void)bodaDianHuaWithDianHua:(NSString *)str
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];
    
}


@end

