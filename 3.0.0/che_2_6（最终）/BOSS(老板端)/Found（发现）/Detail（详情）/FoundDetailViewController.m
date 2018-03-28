//
//  FoundDetailViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundDetailViewController.h"
#import<WebKit/WebKit.h>
#import "MJChiBaoZiHeader.h"

@interface FoundDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    WKWebView*    m_webView;
}



@end

@implementation FoundDetailViewController

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
#pragma mark -  键盘的通知
- (void) keyboardWillShow:(NSNotification*)noti
{

    
//    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
//    kWeakSelf(weakSelf)
//    [UIView animateWithDuration:0.3 animations:^{
//        [weakSelf.view bringSubviewToFront:weakSelf.faBuView];
//        weakSelf.faBuView.frame = CGRectMake(0, kWindowH-keyboardFrameBeginRect.size.height, kWindowW, 53);
//    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
//    NPrintLog(@"%@",self.huiFuModel);
//    self.huiFuModel = nil;
//    kWeakSelf(weakSelf)
//    [UIView animateWithDuration:0.3 animations:^{
//        [weakSelf.view bringSubviewToFront:weakSelf.faBuView];
//        weakSelf.faBuView.frame = CGRectMake(0, kWindowH-53, kWindowW, 53);
//    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"详情" withBackButton:YES];
    shaiXuanQieHuan = YES;
    
    self.faBuView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-53, kWindowW, 53)];
    self.faBuView.layer.shadowColor = kRGBColor(123, 123, 123).CGColor;//shadowColor阴影颜色
    self.faBuView.layer.shadowOffset = CGSizeMake(5,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.faBuView.layer.shadowOpacity = 0.5;
    self.faBuView.layer.shadowRadius = 2;// 阴影扩散的范围控制
    self.faBuView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
    self.faBuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.faBuView];
    
    UIView *faBaView = [[UIView alloc]init];
    faBaView.backgroundColor = kRGBColor(238, 238, 238);
    [faBaView.layer setMasksToBounds:YES];
    [faBaView.layer setBorderColor:kRGBColor(229, 229, 229).CGColor];
    [faBaView.layer setBorderWidth:0.5];
    [faBaView.layer setCornerRadius:15];
    [self.faBuView addSubview:faBaView];
    [faBaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-66);
        make.centerY.mas_equalTo(self.faBuView);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *im = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_Found_xiePL")];
    [faBaView addSubview:im];
    [im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(faBaView);
        make.width.height.mas_equalTo(15);
    }];
    
    UILabel *lineim = [[UILabel alloc]init];
    lineim.backgroundColor = kRGBColor(102, 102, 102);
    [faBaView addSubview:lineim];
    [lineim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(faBaView);
    }];
    
    self.faBuTextField = [[UITextField alloc]init];
    self.faBuTextField.placeholder = @"请输入内容";
    self.faBuTextField.font = [UIFont systemFontOfSize:14];
    self.faBuTextField.delegate  = self;
    self.faBuTextField.returnKeyType = UIReturnKeyDone;
    [faBaView addSubview:self.faBuTextField];
    [self.faBuTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(43);
    }];
    
    UIButton *bt = [[UIButton alloc]init];
    bt.titleLabel.font = [UIFont systemFontOfSize:17];
    [bt setTitleColor:kRGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [bt addTarget:self action:@selector(faBUChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setTitle:@"发布" forState:(UIControlStateNormal)];
    [self.faBuView addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(66);
    }];
    
    
    self.mainListArrar = [[NSMutableArray alloc]init];
    [self postfind_article_detail];
    
    [self postpingLunLIst:YES];
}


-(void)faBUChick:(UIButton *)sender
{
    
    if (self.faBuTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请输入内容" point:self.view.center delay:1];
        return;
    }
    
    
    [self postdo_article_comment];
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight-53) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}


-(FoundDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FoundDetailHeaderView alloc]init];
        _headerView.webView.UIDelegate = self;
        _headerView.webView.navigationDelegate = self;
        kWeakSelf(weakSelf)
        _headerView.dianZanBtChickBlock = ^{
            if ([weakSelf.foundDetailModel.is_praise boolValue] == YES) {
                [weakSelf  showMessageWindowWithTitle:@"您已赞过" point:weakSelf.view.center delay:1];
            }else{
                [weakSelf postdo_article_praise];
            }
        };
    }
    return _headerView;
}
-(FoundDetailModel *)foundDetailModel{
    if (!_foundDetailModel) {
        _foundDetailModel = [[FoundDetailModel alloc]init];
    }
    return _foundDetailModel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainListArrar.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    FoundDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[FoundDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell refleshData:self.mainListArrar[indexPath.row]];
    kWeakSelf(weakSelf)
    cell.zanBtChickBlock = ^(FoundDetailListModel *zhuModel) {
        [weakSelf postdo_comment_praiseWithmodel:zhuModel];
    };
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoundDetailListModel *model = self.mainListArrar[indexPath.row];
    CGFloat height = (146+36+20)/2;
    CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(model.content, DJSystemFont(14), CGSizeMake(kWindowW-20, 100));
    height += wordSize.height;
    if (model.original.length>0) {
        NSString *str = [NSString stringWithFormat:@"@%@:%@",model.to_username,model.original];
        CGSize wordSize2 = DAJIANG_MULTILINE_TEXTSIZE(str, DJSystemFont(14), CGSizeMake(kWindowW-20, 100));
        height += wordSize2.height;
    }
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = [UIColor whiteColor];
    
    
    UIView *dingView = [[UIView alloc]init];
    [dingView.layer setMasksToBounds:YES];
    [dingView.layer setCornerRadius:3];
    [dingView.layer setBorderColor:kLineBgColor.CGColor];
    [dingView.layer setBorderWidth:1];
    [headerV addSubview:dingView];
    [dingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(headerV);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(93);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [dingView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.bottom.mas_equalTo(-9);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(dingView);
    }];
    reDuBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 93/2, 32)];
    reDuBt.selected = !shaiXuanQieHuan;
    reDuBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [reDuBt setTitle:@"热度" forState:(UIControlStateNormal)];
    [reDuBt addTarget:self action:@selector(shaiXuanQieHuanChcick:) forControlEvents:(UIControlEventTouchUpInside)];
    [reDuBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [reDuBt setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
    [dingView addSubview:reDuBt];
    
    shiJianBt = [[UIButton alloc]initWithFrame:CGRectMake(93/2, 0, 93/2, 32)];
    [shiJianBt addTarget:self action:@selector(shaiXuanQieHuanChcick:) forControlEvents:(UIControlEventTouchUpInside)];
    shiJianBt.selected = shaiXuanQieHuan;
    shiJianBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [shiJianBt setTitle:@"时间" forState:(UIControlStateNormal)];
    [shiJianBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [shiJianBt setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
    [dingView addSubview:shiJianBt];
    
    return headerV;
}
-(void)shaiXuanQieHuanChcick:(UIButton *)sender
{
    shaiXuanQieHuan = !shaiXuanQieHuan;
    [self.mainTableView reloadData];
    [self postpingLunLIst:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.faBuTextField becomeFirstResponder];
    self.huiFuModel = self.mainListArrar[indexPath.row];
}

#pragma mark - WKUIDelegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    self.headerView.webViewimb.hidden = YES;
    [self updateWKWebView];
}

- (void)updateWKWebView
{
    if(m_timer != nil)
    {
        [m_timer invalidate];
        m_timer = nil;
    }
    m_timer = [NSTimer scheduledTimerWithTimeInterval:(2.0) target:self selector:@selector(refreshLeftTime)
                                             userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
}

-(void)refreshLeftTime
{
    [self.headerView refleshdata:self.foundDetailModel withBuju:YES];
    self.mainTableView.tableHeaderView = self.headerView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.faBuTextField resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
