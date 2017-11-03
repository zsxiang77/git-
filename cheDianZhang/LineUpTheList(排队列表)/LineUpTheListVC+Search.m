//
//  LineUpTheListVC+Search.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/1.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "LineUpTheListVC.h"

@implementation LineUpTheListVC (Search)

- (void)buildSearchView
{
    UIView* searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), 51)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.hidden = YES;
    [self.view addSubview:searchBg];
    
    self.searchGrayBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kWindowW-20, 30)];
    self.searchGrayBg.backgroundColor = kRGBColor(238, 238, 238);
    self.searchGrayBg.layer.cornerRadius = 5;
    [searchBg addSubview:self.searchGrayBg];
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 20, 20)];
    self.searchImageView.image = DJImageNamed(@"search_gray");
    [self.searchGrayBg addSubview:self.searchImageView];
    
    self.searchOKbt = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 30, 30)];
    [self.searchOKbt addTarget:self action:@selector(searchChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchGrayBg addSubview:self.searchOKbt];
    
    self.searchText = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, kWindowW-40-20, 30)];
    self.searchText.placeholder = @"订单搜索：车牌／订单号／手机号码";
    self.searchText.textColor = kRGBColor(51, 51, 51);
    self.searchText.font = DJSystemFont(14);
    self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchText.returnKeyType = UIReturnKeySearch;
    self.searchText.delegate = self;
    [self.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [searchBg addSubview:self.searchText];
    
    self.searchClearBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-45, 10, 40, 30)];
    [self.searchClearBt setTitle:@"取消" forState:(UIControlStateNormal)];
    self.searchClearBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchClearBt setTitleColor:kRGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    [self.searchClearBt addTarget:self action:@selector(searchClearBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [searchBg addSubview:self.searchClearBt];
    self.searchClearBt.hidden = YES;
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
    self.searchText.frame = CGRectMake(20, 10, kWindowW-40-30, 30);
    self.searchClearBt.hidden = NO;
    self.searchImageView.hidden = YES;
    self.searchOKbt.hidden = YES;
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
        if (asciiLengthOfString(toBeString) > 16) {
            textField.text = [toBeString substringToIndex:asciiLengthIndexOfString(toBeString, 16)];
            return NO;
            
        }
    }
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
    
    
    
    if (![noEmojiStr isEqualToString:textField.text]) {
        
        textField.text = noEmojiStr;
        
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField.text length] == 0) {
        return YES;
    }
    if (self.searchText.text.length>0) {
        self.searchGrayBg.frame = CGRectMake(10, 10, kWindowW-20-40, 30);
        self.searchText.frame = CGRectMake(20, 10, kWindowW-40-30, 30);
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
