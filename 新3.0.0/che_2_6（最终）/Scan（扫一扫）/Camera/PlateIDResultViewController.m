//
//  WTResultViewController.m
//  PlateIDDemo
//


#import "PlateIDResultViewController.h"
#import "ViewController.h"
#import "WorkOrderTypeVC.h"



@interface PlateIDResultViewController ()

@end

@implementation PlateIDResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:@"车牌信息" withBackButton:YES];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight+66, kWindowW, 40)];
    label1.textColor = kRGBColor(74, 74, 74);
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"您扫描的车牌号码是";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UIView *bav = [[UIView alloc]init];
    bav.backgroundColor = kChePaiColor;
    [bav.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [bav.layer setCornerRadius:3];
    [self.view addSubview:bav];
    [bav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(87);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    [label2.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [label2.layer setCornerRadius:3];
    [label2.layer setBorderWidth:1];//设置边界的宽度
    //设置按钮的边界颜色
    [label2.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    label2.font = [UIFont boldSystemFontOfSize:48];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.text = _plateResult.license;
    [bav addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"请核对车牌！如有错误请重新扫描车牌！";
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = kRGBColor(74, 74, 74);
    label3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(bav.mas_bottom).mas_equalTo(10);
        
    }];
    
    UIButton *okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-70);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *chongXinButton = [[UIButton alloc]init];
    [chongXinButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [chongXinButton.layer setCornerRadius:3];
    [chongXinButton.layer setBorderWidth:0.5];//设置边界的宽度
    //设置按钮的边界颜色
    [chongXinButton.layer setBorderColor:[kZhuTiColor CGColor]];
    [chongXinButton addTarget:self action:@selector(chongXinButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [chongXinButton setTitle:@"重新扫描车牌" forState:(UIControlStateNormal)];
    [chongXinButton setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [self.view addSubview:chongXinButton];
    [chongXinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(okButton.mas_top).mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
}


-(void)okButtonChick:(UIButton *)sender
{
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/channels",HOST_URL];
    
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"---");
        [UserInfo dicToJson:responseObject];
        NSLog(@"---");
        
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            [weakSelf carDaoUserInforMeTion:adData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

-(void)carDaoUserInforMeTion:(NSDictionary *)dict
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.plateResult.license forKey:@"car_number"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/query" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        WorkOrderTypeVC *vc = [[WorkOrderTypeVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.chePaiStr = weakSelf.plateResult.license;
        vc.chuanZhiArray = KISDictionaryHaveKey(dict, @"channels");
        vc.userInformetionDict = nil;
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            if (adData.count>0) {
                vc.userInformetionDict = adData;
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 202) {
            if (adData.count>0) {
                vc.userInformetionDict = adData;
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(id error) {
        
    }];
}


-(void)chongXinButtonChick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
