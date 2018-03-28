//
//  CarInfoTypeView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoTypeView.h"
#import "CarInfoTitleView.h"
#import "UIButton+ImageTitleStyle.h"

#define kCatBtnTag 100

@interface CarInfoTypeView ()
@property (nonatomic, strong) CarInfoTitleView *titleView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray<UIButton *> *carBtns;

@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) CGFloat btnHeight;
@end

@implementation CarInfoTypeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btnWidth = (kScreenWidth - 70) / 4;
        _btnHeight = 70;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _titleView = [[CarInfoTitleView alloc] init];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    _titleView.imageName = @"car_info_type_img";
    _titleView.title = @"车辆类型";
    _titleView.isHiddenButton = YES;
    
    _carBtns = [self creatColorButtonArray];
    _carBtns.firstObject.selected = YES;
    
}

- (NSArray *)creatColorButtonArray
{
    NSMutableArray *arr = [NSMutableArray array];
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *btn1 = [self creatBtnWithTitle:@"小型车"
                                      norImg:[[UIImage imageNamed:@"Group3_"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]
                                   selectImg:[[UIImage imageNamed:@"Group3_selected"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]];
    UIButton *btn2 = [self creatBtnWithTitle:@"大中型客车"
                                      norImg:[[UIImage imageNamed:@"Group4_"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]
                                   selectImg:[[UIImage imageNamed:@"Group4_selected"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]];
    UIButton *btn3 = [self creatBtnWithTitle:@"大型货车"
                                      norImg:[[UIImage imageNamed:@"Group5_"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]
                                   selectImg:[[UIImage imageNamed:@"Group5_selected"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]];
    UIButton *btn4 = [self creatBtnWithTitle:@"其他"
                                      norImg:[[UIImage imageNamed:@"Group6_"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]
                                   selectImg:[[UIImage imageNamed:@"Group6_selected"] imageByResizeToSize:CGSizeMake(_btnWidth - 10, 50) contentMode:UIViewContentModeScaleAspectFit]];
    
    [_contentView addSubview:btn1];
    [_contentView addSubview:btn2];
    [_contentView addSubview:btn3];
    [_contentView addSubview:btn4];
    
    //车辆类型 1 小型车 2大中型客车 3大型货车 9 其他
    btn1.tag = 1 + kCatBtnTag;
    btn2.tag = 2 + kCatBtnTag;
    btn3.tag = 3 + kCatBtnTag;
    btn4.tag = 9 + kCatBtnTag;
    

    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_btnWidth, _btnHeight));
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn1.mas_right).mas_offset(11);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_btnWidth, _btnHeight));
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn2.mas_right).mas_offset(11);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_btnWidth, _btnHeight));
    }];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn3.mas_right).mas_offset(11);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_btnWidth, _btnHeight));
    }];
    
    [btn1 setButtonImageTitleStyle:ButtonImageTitleStyleCenterDown padding:2];
    [btn2 setButtonImageTitleStyle:ButtonImageTitleStyleCenterDown padding:2];
    [btn3 setButtonImageTitleStyle:ButtonImageTitleStyleCenterDown padding:2];
    [btn4 setButtonImageTitleStyle:ButtonImageTitleStyleCenterDown padding:2];
    
    [arr addObject:btn1];
    [arr addObject:btn2];
    [arr addObject:btn3];
    [arr addObject:btn4];
    
    return [arr copy];
}

- (UIButton *)creatBtnWithTitle:(NSString *)title norImg:(UIImage *)norImg selectImg:(UIImage *)selectImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:norImg forState:UIControlStateNormal];
    [btn setImage:selectImg forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickButton:(UIButton *)sender
{
    _selectedCar = sender.titleLabel.text;
    
    sender.selected = !sender.selected;
    [self changeButtonSelectedStateFromClickButton:sender];
}

- (void)changeButtonSelectedStateFromClickButton:(UIButton *)button
{
    for (UIButton *btn in _carBtns) {
        if (btn == button) {
            continue;
        }
        btn.selected = NO;
    }
}

- (NSString *)getSelectedCarParam
{
    NSDictionary *dic = @{@"小型车":@"1", @"大中型客车":@"2",
                          @"大型货车":@"3", @"其他":@"9"};
    return [dic objectForKey:self.selectedCar];
}

- (void)setSelectedCarWithCatTypeInt:(NSInteger)carTypeInt
{
    if (carTypeInt < 1) {
        return;
    }
    
    UIButton *selectedBtn = nil;
    for (UIButton *btn in _carBtns) {
        if (btn.tag != carTypeInt + kCatBtnTag) {
            continue;
        }
        selectedBtn = btn;
    }
    
    if (selectedBtn) {
        selectedBtn.selected = YES;
        _selectedCar = selectedBtn.titleLabel.text;
        [self changeButtonSelectedStateFromClickButton:selectedBtn];
    }
}
@end
