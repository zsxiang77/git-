//
//  AITCheckPreviewViewController.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "AITCheckPreviewViewController.h"
#import "CarInspectionViewController.h"

@interface AITCheckPreviewViewController ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *carIv;
@property (nonatomic, strong) YYAnimatedImageView *aitIv;
@property (nonatomic, strong) UIView *dotVi;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *skipBtn;
@end

@implementation AITCheckPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AIT智能检测";
    [self setTopViewWithTitle:@"AIT智能检测" withBackButton:YES];
    m_baseTopView.backgroundColor = [UIColor clearColor];
    
    [self setupViews];
}

- (void)setupViews
{
    _carIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1005./1125 * kScreenWidth);
        }];
        iv.image = [UIImage imageNamed:@"ait_check_preview_img"];
        iv;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.carIv addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(80);
            make.centerX.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.text = @"请插入AIT设备";
        lb;
    });
    
    _aitIv = ({
        YYImage *image = [YYImage imageNamed:@"ic_sa_ait_1"];
        YYAnimatedImageView *an = [[YYAnimatedImageView alloc] initWithImage:image];
        [self.view addSubview:an];
        [an mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.carIv.mas_bottom).mas_offset(12);
            make.centerX.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(94 * 0.6, 274 * 0.6));
        }];
        an;
    });
    UIImageView *an2 = [[UIImageView alloc] init];
    an2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:an2];
    [self.view bringSubviewToFront:an2];
    [an2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carIv.mas_bottom).mas_offset(12);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(94 * 0.6, 274 * 0.6));
    }];
    NSMutableArray *anArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <54; i++) {
        UIImage *image;
        if (53-i>9) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"AIT_00%d_图层-%d",53-i,i+1]];
        }else{
            image = [UIImage imageNamed:[NSString stringWithFormat:@"AIT_000%d_图层-%d",53-i,i+1]];
        }
        [anArray addObject:image];
    }
    
    an2.animationImages = anArray; //获取Gif图片列表
    an2.animationDuration = 5;     //执行一次完整动画所需的时长
    an2.animationRepeatCount = MAXFLOAT;  //动画重复次数
    [an2 startAnimating];
    

    _tipLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.aitIv addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.aitIv.mas_bottom).mas_offset(20);
            make.centerX.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.text = @"插入车的OBD接口，它一般位于驾驶员的左腿下方";
        lb;
    });
    
    _dotVi = ({
        UIView *vi = [[UIView alloc] init];
        [self.view addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tipLb);
            make.right.mas_equalTo(self.tipLb.mas_left).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(7, 7));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"EEC75B"];
        vi.layer.cornerRadius = 7 * 0.5;
        vi.layer.masksToBounds = YES;
        vi;
    });
    
    _skipBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 25));
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(-20);
        }];
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"4C8CE2"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        [btn addTarget:self action:@selector(clickSkipButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _commitBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.skipBtn.mas_top).mas_offset(-8);
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(47);
        }];
        [btn setTitle:@"确认插入" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(clickSkipButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

#pragma mark -
- (void)clickSkipButton:(UIButton *)btn {
    
    if ([OrderInfoPushManager sharedOrderInfoPushManager].type == OrderInfoPushTypeOrderDetail) {
        [self.navigationController popToBeforeViewControllerWithNum:2 animated:YES];
        return;
    }
    
    // 外观检查
    CarInspectionViewController *vc = [[CarInspectionViewController alloc] init];
    vc.chuaOrdercode = _ordercode;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
