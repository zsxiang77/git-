//
//  CarInfoChooseView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoChooseView.h"
#import "CarInfoTitleView.h"

@interface CarInfoChooseView ()
@property (nonatomic, strong) CarInfoTitleView *titleView;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UILabel *manualChooseInfoLb; //手动选择时,显示的一条车辆
@end

@implementation CarInfoChooseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
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
    _titleView.imageName = @"info_car_info";
    _titleView.title = @"选择车型";
    @weakify(self)
    _titleView.didChooseCarButtonCallBack = ^{
        @strongify(self)
        [self clickChooseButton];
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.rowHeight = 45;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _chooseBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(89, 89));
            make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset(3);
            make.centerX.mas_equalTo(btn.superview);
        }];
        
        UIImageView *iv = [[UIImageView alloc] init];
        [btn addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(btn);
            make.size.mas_equalTo(CGSizeMake(89, 59));
        }];
        iv.image = [UIImage imageNamed:@"car_info_choose_img"];
        
        UILabel *lb = [[UILabel alloc] init];
        [btn addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(lb.superview);
            make.top.mas_equalTo(iv.mas_bottom).mas_offset(5);
        }];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithHexString:@"858488"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.text = @"点击选择车辆";
        
        [btn addTarget:self action:@selector(clickChooseButton) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _manualChooseInfoLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleView.mas_bottom);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(0);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        lb;
    });
}

- (void)clickChooseButton
{
    !_didChooseCarButtonCallBack ?: _didChooseCarButtonCallBack();
}

#pragma mark -

- (void)setStyle:(CarInfoChooseViewStyle)style
{
    _style = style;
    switch (style) {
        case CarInfoChooseViewStyleNoData:
            _titleView.isHiddenButton = YES;
            _tableView.hidden = YES;
            _chooseBtn.hidden = NO;
            _manualChooseInfoLb.hidden = YES;
            _currHeight = 35 + 135;
            break;
        case CarInfoChooseViewStyleManual:
            _titleView.isHiddenButton = NO;
            _tableView.hidden = YES;
            _chooseBtn.hidden = YES;
            _manualChooseInfoLb.hidden = NO;
            _currHeight = 35 + 45;
            break;
        case CarInfoChooseViewStyleList:
            _titleView.isHiddenButton = NO;
            _tableView.hidden = NO;
            _chooseBtn.hidden = YES;
            _manualChooseInfoLb.hidden = YES;
            _currHeight = 35 + 135;
            break;
    }
}

- (void)setManualChooseText:(NSString *)manualChooseText
{
    _manualChooseText = manualChooseText;
    _manualChooseInfoLb.text = manualChooseText;
}

@end
