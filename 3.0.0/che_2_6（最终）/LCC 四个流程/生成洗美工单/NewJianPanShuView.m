//
//  NewJianPanShuView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewJianPanShuView.h"
#import "CheDianZhangCommon.h"
#import "CommonControlOrView.h"

static float kButtonHeight = 45;

static NSInteger kNumButtonTag = 500;

@interface NewJianPanShuView()
{
    UIButton*  m_valueButton;
    
}

@end


@implementation NewJianPanShuView
- (instancetype)initWithFrame:(CGRect)frame value:(NSString*)value
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.4];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(dissMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        self.xiaoShuWeiShu = 0;
        self.zuiDaZhiFloat = 0;
        
        [self buildMainView:value];
    }
    return self;
}

- (void)buildMainView:(NSString*)currentValue
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), kWindowW, 285)];
    self.contentView.backgroundColor = kRGBColor(233, 237, 240);
    [self addSubview:self.contentView];
    
    UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), 45)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    
    UIButton* hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 12, 25, 21)];
    [hideBtn setImage:DJImageNamed(@"hide_board_bg") forState:UIControlStateNormal];
    [hideBtn addTarget:self action:@selector(dissMissView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:hideBtn];
    
    UILabel* touLabel = [CommonControlOrView setLabelWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)-120, 0, 30, 45) textColor:kRGBColor(168, 168, 168) font:DJBoldSystemFont(13) text:@"" textAlignment:NSTextAlignmentCenter];
    [topView addSubview:touLabel];
    
    m_valueButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)-90, 7.5, 60, 30)];
    [m_valueButton setBackgroundColor:kRGBColor(249, 249, 251)];
    m_valueButton.layer.borderColor = [kRGBColor(219, 219, 219) CGColor];
    m_valueButton.layer.borderWidth = 1;
    m_valueButton.layer.cornerRadius = 2;
    m_valueButton.userInteractionEnabled = NO;
    [m_valueButton setTitleColor:kRGBColor(12, 12, 12) forState:UIControlStateNormal];
    [m_valueButton setTitle:currentValue forState:UIControlStateNormal];
    m_valueButton.titleLabel.font = DJSystemFont(13.0);
    [topView addSubview:m_valueButton];
    
    UILabel* beiLabel = [CommonControlOrView setLabelWithFrame:CGRectMake(CGRectGetMaxX(m_valueButton.frame), 0, 30, 45) textColor:kRGBColor(168, 168, 168) font:DJBoldSystemFont(13) text:@"" textAlignment:NSTextAlignmentCenter];
    [topView addSubview:beiLabel];
    
    /////
    float btnW = CGRectGetWidth(self.contentView.frame)/5.0;
    NSArray* multiples = @[@"1", @"2", @"5", @"10", @"20"];
    for (int i = 0; i < 5; i++) {
        UIButton* multipleBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW*i, 50, btnW, 50)];
        [multipleBtn setTitle:multiples[i] forState:UIControlStateNormal];
        [multipleBtn setTitleColor:kRGBColor(12, 12, 12) forState:UIControlStateNormal];
        multipleBtn.titleLabel.font = DJSystemFont(14.0);
        multipleBtn.backgroundColor = [UIColor whiteColor];
        multipleBtn.tag = 200+i;
        [multipleBtn addTarget:self action:@selector(multipleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:multipleBtn];
    }
    
    float numBtnW = (CGRectGetWidth(self.contentView.frame)-54)/3.0;
    NSArray* nums = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"+1", @"."];
    for (int i = 0; i < 12; i++) {
        UIButton* numBtn = [[UIButton alloc] initWithFrame:CGRectMake(numBtnW*(i%3), 105+i/3*kButtonHeight, numBtnW, kButtonHeight)];
        [numBtn setTitle:nums[i] forState:UIControlStateNormal];
        [numBtn setTitleColor:kRGBColor(12, 12, 12) forState:UIControlStateNormal];
        numBtn.titleLabel.font = DJSystemFont(15.0);
        numBtn.backgroundColor = [UIColor whiteColor];
        numBtn.tag = kNumButtonTag+i;
        [numBtn addTarget:self action:@selector(numButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:numBtn];
    }
    
    ///删除 确定
    UIButton* deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)-54, 105, 54, kButtonHeight*2)];
    [deleteBtn setBackgroundColor:kRGBColor(194, 195, 199)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = DJBoldSystemFont(14.0);
    [deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn];
    
    UIButton* okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)-54, 105+kButtonHeight*2, 54, kButtonHeight*2)];
    [okBtn setBackgroundColor:kZhuTiColor];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.titleLabel.font = DJBoldSystemFont(14.0);
    [okBtn addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:okBtn];
    
    [self buildLine];
}

- (void)buildLine
{
    float btnW = CGRectGetWidth(self.contentView.frame)/5.0;
    for (int i = 0; i < 4; i++) {
        UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(btnW*i+btnW, 50, 1, 50)];
        line.backgroundColor = kRGBColor(234, 234, 234);
        [self.contentView addSubview:line];
    }
    
    float numBtnW = (CGRectGetWidth(self.contentView.frame)-54)/3.0;
    for (int i = 0; i < 3; i++) {
        UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(numBtnW*i+numBtnW, 105, 1, kButtonHeight*4)];
        line.backgroundColor = kRGBColor(234, 234, 234);
        [self.contentView addSubview:line];
    }
    for (int i = 0; i < 3; i++) {
        UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105+kButtonHeight*i+kButtonHeight, CGRectGetWidth(self.contentView.frame)-54, 1)];
        line.backgroundColor = kRGBColor(234, 234, 234);
        [self.contentView addSubview:line];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)dissMissView
{
    [UIView animateWithDuration:0.4 animations:^{
        CGPoint _center = self.contentView.center;
        
        _center.y += CGRectGetHeight(self.contentView.frame);
        
        self.contentView.center = _center;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)displayView//显示
{
    [UIView animateWithDuration:0.4 animations:^{
        self.hidden = NO;
        self.alpha = 1.0;
        
        CGPoint _center = self.contentView.center;
        
        _center.y -= CGRectGetHeight(self.contentView.frame);
        
        self.contentView.center = _center;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark 点击
- (void)multipleButtonClick:(UIButton*)tempBtn
{
    NSInteger number = tempBtn.tag - 200;
    
    NSArray* multiples = @[@"1", @"2", @"5", @"10", @"20"];
    [m_valueButton setTitle:multiples[number] forState:UIControlStateNormal];
    
}

- (void)numButtonClick:(UIButton*)tempBtn
{
    NSInteger number = tempBtn.tag - kNumButtonTag;
    NSString* currentText = [m_valueButton currentTitle];
//    if (currentText.length<=0) {
//        currentText = @"0";
//    }
    if (self.xiaoShuWeiShu>0) {
        NSArray *xiaoShuArray = [currentText componentsSeparatedByString:@"."];
        if (xiaoShuArray.count>1) {
            NSString *puand = xiaoShuArray[1];
            if (![tempBtn.titleLabel.text isEqualToString:@"+1"]) {
                if (puand.length >=self.xiaoShuWeiShu) {
                    return;
                }
            }
        }
    }
    

    
    if (number <= 9)
    {
        NSArray *numbeArray = [currentText componentsSeparatedByString:@"."];
        if (numbeArray.count>0) {
            NSString *zhengShuStr = numbeArray[0];
            if (zhengShuStr.length>1) {
                //两位数以上时，第一位不允许为0
                if ([currentText intValue] == 0) {
                    currentText = @"";
                }
            }
        }
        
        currentText = [currentText stringByAppendingString:[NSString stringWithFormat:@"%ld", number==9?0:(long)number+1]];
        if (self.zuiDaZhiFloat<=0) {
            if ([currentText intValue]>10000) {//最高倍数
                currentText = @"10000";
            }
        }
        
//        else if ([currentText intValue]==0){
//            currentText = @"1";
//        }
    }
    else if (10 == number)
    {
        if ([currentText integerValue] < 10000) {
            currentText = [NSString stringWithFormat:@"%ld", (long)[currentText intValue]+1];
        }
    }
    else if (11 == number)
    {
        if (currentText.length > 0){
            currentText = [NSString stringWithFormat:@"%@%@", currentText,@"."];
        }
    }
    
    if (self.zuiDaZhiFloat >0) {
        if (self.zuiDaZhiFloat<=[currentText floatValue]) {
            currentText = [NSString stringWithFormat:@"%.1f",self.zuiDaZhiFloat];
        }
    }
    [m_valueButton setTitle:currentText forState:UIControlStateNormal];
}

- (void)deleteButtonClick
{
    NSString* currentText = [m_valueButton currentTitle];
    if (currentText.length > 0) {
        currentText = [currentText substringToIndex:currentText.length-1];
    }
    [m_valueButton setTitle:currentText forState:UIControlStateNormal];
}

- (void)okButtonClick
{
    if (self.okClick) {
        NSString* currentText = [m_valueButton currentTitle];
        self.okClick(currentText.length>0?currentText:@"1");
    }
    [self dissMissView];
}


@end
