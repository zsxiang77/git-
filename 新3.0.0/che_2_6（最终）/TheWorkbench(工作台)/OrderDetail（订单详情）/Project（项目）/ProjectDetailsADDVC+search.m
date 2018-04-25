//
//  ProjectDetailsADDVC+search.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDVC.h"
@implementation ProjectDetailsADDVC (search)
- (void)buildSearchView
{
    UIView* searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), (63/2+10))];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.hidden = NO;
    [self.view addSubview:searchBg];
    
    
    self.searchGrayBg = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kWindowW-20, 63/2)];
    self.searchGrayBg.backgroundColor = kRGBColor(244, 244, 244);
    self.searchGrayBg.layer.cornerRadius = 63/4;
    [self.searchGrayBg.layer setBorderWidth:0.5];
    [self.searchGrayBg.layer setBorderColor:kLineBgColor.CGColor];
    [searchBg addSubview:self.searchGrayBg];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"search_blue")];
    [self.searchGrayBg addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    self.searchText = [[UITextField alloc] init];
    self.searchText.placeholder = @"请输入配件编号和配件名称";
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
    
    UIImageView *saoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"shuruYuYin")];
    saoImageView.contentMode = UIViewContentModeScaleAspectFit;
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
    
    self.searchClearBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-45, 5, 40, 30)];
    [self.searchClearBt setTitle:@"取消" forState:(UIControlStateNormal)];
    self.searchClearBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchClearBt setTitleColor:kRGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    [self.searchClearBt addTarget:self action:@selector(searchClearBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [searchBg addSubview:self.searchClearBt];
    self.searchClearBt.hidden = YES;
}

-(void)searchClearBtChick:(UIButton *)sender
{
    self.seachTableView.hidden =YES;
    self.searchClearBt.hidden = YES;
    self.searchText.text = @"";
    self.searchGrayBg.frame = CGRectMake(10, 5, kWindowW-20, 30);
    [self.view endEditing:YES];
    [self.searchArray removeAllObjects];
    [self.seachTableView reloadData];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.searchGrayBg.frame = CGRectMake(10, 5, kWindowW-20-40, 30);
    self.searchClearBt.hidden = NO;
    self.seachTableView.hidden = NO;
    [self.view bringSubviewToFront:self.seachTableView];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.searchText == textField)  //判断是否时我们想要限定的那个输入框
    {
        if (asciiLengthOfString(toBeString) > 17) {
            textField.text = [toBeString substringToIndex:asciiLengthIndexOfString(toBeString, 16)];
            return NO;
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
    
    if (![noEmojiStr isEqualToString:textField.text]){
        textField.text = noEmojiStr;
    }
    
    if (self.searchText.text.length>0) {
        [self searchPeijian:self.searchText.text];
        
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
        self.seachTableView.hidden = NO;
        [self.view bringSubviewToFront:self.seachTableView];
    }
    return YES;
}

-(void)searchPeijian:(NSString *)strText
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.searchText.text forKey:@"input"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/search_subject" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        [weakSelf.searchArray removeAllObjects];
        for (int i = 0; i<dataDic.count; i++) {
            [weakSelf.searchArray addObject:dataDic[i]];
        }
        [weakSelf.seachTableView reloadData];
    } failure:^(id error) {
        
    }];
}

-(void)saoButtonChick:(UIButton*)sender
{
    
}
@end
