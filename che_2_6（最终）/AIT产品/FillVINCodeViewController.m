//
//  FillVINCodeViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillVINCodeViewController.h"

#import "FillVINCodeCell.h"


@interface FillVINCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSTimer*            m_timer;
}

@property(nonatomic,strong)UITableView  *mainTableView;
@property(nonatomic,strong)NSMutableArray *mainArray;
@property(nonatomic,strong)VINquedingVIew *vINquedingVIew;

@property(nonatomic,strong)NSString *seathStr;

@end

@implementation FillVINCodeViewController

-(VINquedingVIew *)vINquedingVIew
{
    if (!_vINquedingVIew) {
        _vINquedingVIew = [[VINquedingVIew alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_vINquedingVIew];
        kWeakSelf(weakSelf)
        _vINquedingVIew.fanHuiPopBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self.view bringSubviewToFront:_vINquedingVIew];
    }
    return _vINquedingVIew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"填写VIN码" withBackButton:YES];
    
    self.seathStr = @"";
    
    self.headerView = [[FillVINCodeHeaderView alloc]initWithFrame:CGRectMake(0, kNavBarHeight + 10, kWindowW, 203/2)];
    self.headerView.zhuLabel.text = [NSString stringWithFormat:@"AIT:%@",self.touStr];
    kWeakSelf(weakSelf)
    self.headerView.codeChange = ^(NSString *str) {
        weakSelf.seathStr = str;
        [weakSelf updateyanShiWithNeiRong:str];
    };
    self.headerView.codeView.vINinPutView.quedingBlock = ^{
        if (weakSelf.seathStr.length<17) {
            [weakSelf showMessageWindowWithTitle:@"必须17位" point:weakSelf.view.center delay:1];
        }
        [weakSelf.headerView.codeView.mainTextField resignFirstResponder];
        
        [weakSelf quedingTiJiaovin:weakSelf.seathStr];
    };
    [self.headerView.codeView codeBecomeFirstResponder];
//    self.headerView.codeView.mainTextField.inputAccessoryView = self.vINinPutView;
    [self.view addSubview:self.headerView];
    
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-64, 20, 54, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [backButton setTitleColor:kRGBColor(54, 54, 54) forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonGuanBiClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:backButton];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkkJieShouXiaoXiDangQianAITDidReceiveMessageBenDI:) name:kJieShouXiaoXiDangQianAIT object:nil];
    
    
    [self postSearchVin:@""];
}

-(void)networkkJieShouXiaoXiDangQianAITDidReceiveMessageBenDI:(NSNotification *)notification {
    
    self.touStr = [notification object];
    self.headerView.zhuLabel.text = [NSString stringWithFormat:@"AIT:%@",self.touStr];
}
-(void)backButtonGuanBiClick:(UIButton *)sender
{
    [self.headerView.codeView.mainTextField resignFirstResponder];
    VINNewAlertView* alert = [[VINNewAlertView alloc]initWithTitleWithmessage:@"是否关闭VIN？" cancelButtonTitle:@"取消" otherButtonTitle:@"是"];
    alert.quXiaoLabel.text = @"否";
    alert.quXiaoLabel.textColor = kZhuTiColor;
    [alert.queRenBt setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    
    [alert show];
    kWeakSelf(weakSelf)
    alert.queRenBtBlock = ^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTiaoZhuanVinYe];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"0"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:alert];
    [self.view bringSubviewToFront:alert];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTiaoZhuanVinYe] != nil) {
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"1"];
    }else{
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"0"];
    }
}

-(void)quedingTiJiaovin:(NSString *)vin
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.touStr forKey:@"serial_number"];
    [mDict setObject:vin forKey:@"vin"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/vin_serial" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTiaoZhuanVinYe];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
            [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"0"];
            weakSelf.vINquedingVIew.hidden = NO;
            [weakSelf.view bringSubviewToFront:weakSelf.vINquedingVIew];
            
            
            //    倒计时时间
            __block NSInteger timeOut = 3;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            //    每秒执行一次
            dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(source, ^{
                
                //倒计时结束，关闭
                if (timeOut <= 0) {
                    dispatch_source_cancel(source);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }else
                {
                    //            int seconds = timeOut % 60;
                    NSInteger seconds = timeOut;
                    NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.vINquedingVIew .daoLabel.text = [NSString stringWithFormat:@"(%@s返回)",timeStr];
                    });
                    timeOut--;
                }
            });
            dispatch_resume(source);
 
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {
        
    }];
}

-(void)postSearchVin:(NSString *)str
{
    
    if (self.mainArray.count<=0 && str.length>3) {
        return;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:str forKey:@"vin"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/vin_carinfo" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return ;
        }
        [weakSelf.mainArray removeAllObjects];
        for (int i = 0; i<dataDic.count; i++) {
            [weakSelf.mainArray addObject:dataDic[i]];
        }
        
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10+203/2, kWindowW, kWindowH-kNavBarHeight-10-203/2) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(NSMutableArray *)mainArray
{
    if (!_mainArray) {
        _mainArray = [[NSMutableArray alloc]init];
    }
    return _mainArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    FillVINCodeCell *cell = (FillVINCodeCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[FillVINCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell freshdata:self.mainArray[indexPath.row] pipei:self.seathStr];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.headerView.codeView.mainTextField resignFirstResponder];
    
    NSDictionary *dict = self.mainArray[indexPath.row];
    NSString *vinStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"VIN")];
    if (vinStr.length !=17) {
        [self showMessageWindowWithTitle:@"VIN错误" point:self.view.center delay:1];
        return;
    }
    NSMutableArray *vinArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        if (i<4) {
            NSString *string = [vinStr substringWithRange:NSMakeRange(i*4,4)];
            [vinArray addObject:string];
        }else{
            NSString *string = [vinStr substringWithRange:NSMakeRange(i*4,1)];
            [vinArray addObject:string];
        }
    }
    
    NSString *str11 = [NSString stringWithFormat:@"VIN:%@ %@ %@ %@ %@",vinArray[0],vinArray[1],vinArray[2],vinArray[3],vinArray[4]];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8; //设置行间距
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle};
    NSMutableAttributedString* att1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n请确认VIN码无误后再提交，否则无法接收",str11] attributes:dic];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str11.length+1, 20)];
    [att1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str11.length+1, 20)];
    [att1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str11.length)];
    
    VINNewAlertView* alert = [[VINNewAlertView alloc]initWithTitleWithmessage:@"" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    alert.quXiaoLabel.text = @"取消";
//    alert.maLabel2.attributedText = att1;
    alert.maLabel.hidden = YES;
    alert.maLabel2.hidden = NO;
    alert.maLabel3.hidden = NO;
    alert.maLabel2.text = str11;
    alert.maLabel3.text = @"请确认VIN码无误，否则无法接收报告";
    alert.maLabel3.font = [UIFont systemFontOfSize:12];
    
    [alert show];
    kWeakSelf(weakSelf)
    alert.queRenBtBlock = ^{
//        NPrintLog(@"%@",[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(weakSelf.mainArray[indexPath.row], @"VIN")]);
        [weakSelf quedingTiJiaovin:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainArray[indexPath.row], @"VIN")]];
    };
    [self.view addSubview:alert];
    [self.view bringSubviewToFront:alert];
}

#pragma mark - 搜索延时
- (void)updateyanShiWithNeiRong:(NSString *)str
{
    souSuoNeiRong = str;
    if(m_timer != nil)
    {
        [m_timer invalidate];
        m_timer = nil;
    }
    if(self.navigationController.visibleViewController != self){
        return;
    }
    m_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(refreshLeftTime)
                                             userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
}

- (void)refreshLeftTime
{
    
    [self postSearchVin:souSuoNeiRong];
    
    if(m_timer != nil)
    {
        [m_timer invalidate];
        m_timer = nil;
    }
}
@end
