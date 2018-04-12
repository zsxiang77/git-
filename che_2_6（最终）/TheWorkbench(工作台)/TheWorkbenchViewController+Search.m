//
//  TheWorkbenchViewController+Search.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "PlateIDCameraViewController.h"

@implementation TheWorkbenchViewController (Search)
- (void)buildSearchView
{
    UIView* searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), (63/2+10)*2)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.hidden = NO;
    [self.view addSubview:searchBg];
    
    UIView *qieView = [[UIView alloc]initWithFrame:CGRectMake(0, (63/2+10), kWindowW, (63/2+10))];
    qieView.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:qieView];
    
    UIView *shaiXuanView = [[UIView alloc]init];
    shaiXuanView.backgroundColor = kRGBColor(244, 244, 244);
    [shaiXuanView.layer setMasksToBounds:YES];
    [shaiXuanView.layer setBorderWidth:0.5];
    [shaiXuanView.layer setCornerRadius:54/4];
    [shaiXuanView.layer setBorderColor:kLineBgColor.CGColor];
    [qieView addSubview:shaiXuanView];
    [shaiXuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(qieView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(54/2);
    }];
    
    shaiXuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_repair")];
    [shaiXuanView addSubview:shaiXuanImageView];
    [shaiXuanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(15);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    shaiXuanTitle = [[UILabel alloc]init];
    shaiXuanTitle.font = [UIFont systemFontOfSize:12];
    shaiXuanTitle.textColor = kRGBColor(245, 166, 35);
    shaiXuanTitle.text = @"待施工";
    [shaiXuanView addSubview:shaiXuanTitle];
    [shaiXuanTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shaiXuanImageView.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    shaiXuanJianTou = [[UIImageView alloc]initWithImage:DJImageNamed(@"jiaoTou_DownUp")];
    [shaiXuanView addSubview:shaiXuanJianTou];
    [shaiXuanJianTou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    UIButton *shaiXuanBt = [[UIButton alloc]init];
    [shaiXuanBt addTarget:self action:@selector(shaiXuanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shaiXuanView addSubview:shaiXuanBt];
    [shaiXuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIView *qieView2 = [[UIView alloc]init];
    qieView2.backgroundColor = kRGBColor(244, 244, 244);
    [qieView2.layer setMasksToBounds:YES];
    [qieView2.layer setBorderWidth:0.5];
    [qieView2.layer setCornerRadius:54/4];
    [qieView2.layer setBorderColor:kLineBgColor.CGColor];
    [qieView addSubview:qieView2];
    [qieView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(qieView);
        make.width.mas_equalTo(227/2);
        make.height.mas_equalTo(54/2);
    }];
    
    myListButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 117/2, 54/2)];
    myListButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [myListButton.layer setMasksToBounds:YES];
    [myListButton.layer setCornerRadius:54/4];
    myListButton.selected = YES;
    [myListButton addTarget:self action:@selector(myListButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [myListButton setTitle:@"与我相关" forState:(UIControlStateNormal)];
    [myListButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [myListButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [myListButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    [myListButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    [qieView2 addSubview:myListButton];
    

    allListButton = [[UIButton alloc]initWithFrame:CGRectMake(227/2-117/2, 0, 117/2, 54/2)];
    allListButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [allListButton.layer setMasksToBounds:YES];
    [allListButton.layer setCornerRadius:54/4];
    allListButton.selected = NO;
    [allListButton addTarget:self action:@selector(allListButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [allListButton setTitle:@"显示所有" forState:(UIControlStateNormal)];
    [allListButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [allListButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [allListButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    [allListButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    [qieView2 addSubview:allListButton];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, ((63/2+9)*2), kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [searchBg addSubview:line];
    
    self.searchGrayBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kWindowW-20, 63/2)];
    self.searchGrayBg.backgroundColor = kRGBColor(244, 244, 244);
    self.searchGrayBg.layer.cornerRadius = 63/4;
    [self.searchGrayBg.layer setBorderWidth:0.5];
    [self.searchGrayBg.layer setBorderColor:kLineBgColor.CGColor];
    [searchBg addSubview:self.searchGrayBg];
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 20, 20)];
    self.searchImageView.image = DJImageNamed(@"search_gray");
    [self.searchGrayBg addSubview:self.searchImageView];
    
    self.searchOKbt = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 30, 30)];
    [self.searchOKbt addTarget:self action:@selector(searchChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchGrayBg addSubview:self.searchOKbt];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"search_blue")];
    [self.searchGrayBg addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    self.searchText = [[UITextField alloc] init];
    self.searchText.placeholder = @"请输入车牌号/手机号/VIN/订单号";
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
    
    self.searchClearBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-45, 10, 40, 30)];
    [self.searchClearBt setTitle:@"取消" forState:(UIControlStateNormal)];
    self.searchClearBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchClearBt setTitleColor:kRGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    [self.searchClearBt addTarget:self action:@selector(searchClearBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [searchBg addSubview:self.searchClearBt];
    self.searchClearBt.hidden = YES;
}

-(void)shaiXuanBtChick:(UIButton *)sender
{
    if (self.orderDetailShaiXuanView.hidden == NO) {
        [self.orderDetailShaiXuanView yingCangViwe];
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
        }];
    }else{
        [self.orderDetailShaiXuanView displayView];
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }
    [self.view bringSubviewToFront:self.orderDetailShaiXuanView];
}

-(void)saoButtonChick:(UIButton *)sender
{
    
    
    PlateIDCameraViewController *vc = [[PlateIDCameraViewController alloc]init];
    vc.shiFouHuiDiao = YES;
    kWeakSelf(weakSelf)
    vc.saoMiaoJieGUo = ^(NSString *jieGuo) {
        weakSelf.searchGrayBg.frame = CGRectMake(10, 10, kWindowW-20-40, 30);
        //    self.searchText.frame = CGRectMake(20, 10, kWindowW-40-30, 30);
        weakSelf.searchClearBt.hidden = NO;
        weakSelf.searchImageView.hidden = YES;
        weakSelf.searchOKbt.hidden = YES;
        [weakSelf resetTableScroll];
        weakSelf.searchText.text = jieGuo;
        [weakSelf postSearchrequest_methodDatawithShuaXin:YES];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myListButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        allListButton.selected = NO;
    }else{
        allListButton.selected = YES;
    }
    
    if (m_segButtonsView.selectIndex == 0) {
        weixiuMyList = YES;
    }
    if (m_segButtonsView.selectIndex == 1) {
        xiMeiMyList = YES;
    }
    
    [self postrequest_methodDataWithIndex:m_segButtonsView.selectIndex withShuaXin:YES];
}
-(void)allListButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        myListButton.selected = NO;
    }else{
        myListButton.selected = YES;
    }
    
    if (m_segButtonsView.selectIndex == 0) {
        weixiuMyList = NO;
    }
    if (m_segButtonsView.selectIndex == 1) {
        xiMeiMyList = NO;
    }
    
    [self postrequest_methodDataWithIndex:m_segButtonsView.selectIndex withShuaXin:YES];
}

-(void)searchClearBtChick:(UIButton *)sender
{
    self.seachTableView.hidden = YES;
    self.searchClearBt.hidden = YES;
    self.searchImageView.hidden = NO;
    self.searchOKbt.hidden = NO;
    self.searchText.text = @"";
    self.searchGrayBg.frame = CGRectMake(10, 10, kWindowW-20, 30);
    [self.view endEditing:YES];
    [self.seachArray removeAllObjects];
    [self.seachTableView reloadData];
}

-(void)searchChick:(UIButton *)sender
{
    if (self.searchText.text.length>0) {
        self.searchGrayBg.frame = CGRectMake(10, 10, kWindowW-20-40, 30);
        self.searchClearBt.hidden = NO;
        self.searchImageView.hidden = YES;
        self.searchOKbt.hidden = YES;
        //        self.processType = @"1,2";
        //        self.lotteryType = @"";
        [self resetTableScroll];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.searchGrayBg.frame = CGRectMake(10, 10, kWindowW-20-40, 30);
//    self.searchText.frame = CGRectMake(20, 10, kWindowW-40-30, 30);
    self.searchClearBt.hidden = NO;
    self.searchImageView.hidden = YES;
    self.searchOKbt.hidden = YES;
    [self resetTableScroll];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.searchText == textField)  //判断是否时我们想要限定的那个输入框
    {
        if (string.length>0) {
            if (asciiLengthOfString(toBeString) > 17) {
                return NO;
            }
        }
        
    }
    
    return YES;
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
    if (self.searchText.text.length>0) {
        self.searchClearBt.hidden = NO;
        self.searchImageView.hidden = YES;
        self.searchOKbt.hidden = YES;
        //        self.processType = @"1,2";
        //        self.lotteryType = @"";
        [self resetTableScroll];
    }
    return YES;
}
@end
