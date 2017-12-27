//
//  DetailAITProductsViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "DetailAITProductsViewController.h"
#import "NumberKeyboard.h"
#import "AITBuyView.h"
#import "AITIntroduceViewController.h"

@interface DetailAITProductsViewController ()<UITextFieldDelegate,NumKeyboardDelegate,UITextViewDelegate>
{
    UITextField   *phoneTextField;
    UITextField   *nameTextField;
    UITextView   *addressTextView;
}
@property(nonatomic,strong)AITBuyView *aITBuyView;
@property(nonatomic,strong)UIButton *queDingBt;
@property(nonatomic,strong)UILabel *tishiLabel;
@property(nonatomic,strong)UIImageView *animImageView;


@end

@implementation DetailAITProductsViewController

-(AITBuyView *)aITBuyView
{
    if (!_aITBuyView) {
        _aITBuyView = [[AITBuyView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_aITBuyView];
        kWeakSelf(weakSelf)
        _aITBuyView.fanHuiPopBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self.view bringSubviewToFront:_aITBuyView];
    }
    return _aITBuyView;
}
-(void)bianJiBtChick:(UIButton *)sender
{
    
    self.tishiLabel.text = @"输入联系方式1-2天内会有销售人员与您联系";
    self.queDingBt.hidden = NO;
    phoneTextField.userInteractionEnabled = YES;
    nameTextField.userInteractionEnabled = YES;
    addressTextView.userInteractionEnabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订购AIT产品" withBackButton:YES];
    
    UIButton *xiaYiBuBt = [[UIButton alloc]init];
    [xiaYiBuBt setTitle:@"编辑" forState:(UIControlStateNormal)];
    [xiaYiBuBt setTitleColor:kRGBColor(54, 54, 54) forState:(UIControlStateNormal)];
    [xiaYiBuBt addTarget:self action:@selector(bianJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [m_baseTopView addSubview:xiaYiBuBt];
    [xiaYiBuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    
    UIScrollView *mianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    [self.view addSubview:mianScrollView];
    
    CGFloat gunDongHeight  = 0;
    
    for (int i = 0; i<3; i++) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 120*i+10, kWindowW, 110)];
        backView.backgroundColor = [UIColor whiteColor];
        [mianScrollView addSubview:backView];
        
        UILabel *la = [[UILabel alloc]init];
        la.font = [UIFont systemFontOfSize:13];
        la.textColor = [UIColor grayColor];
        [backView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        UIImageView *zuoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,40+ (40-15)/2, 16, 19)];
        [backView addSubview:zuoImageView];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, kWindowW, 1)];
        line.backgroundColor = kLineBgColor;
        [backView addSubview:line];
        
        if (i == 0) {
            zuoImageView.frame = CGRectMake(10,40+ (40-19)/2, 19*26/36, 19);
            zuoImageView.image = DJImageNamed(@"07_phone");
            UILabel *la2 = [[UILabel alloc]init];
            la2.font = [UIFont systemFontOfSize:13];
            la2.text = @"*";
            la2.textColor = [UIColor redColor];
            [backView addSubview:la2];
            [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(la.mas_right).mas_equalTo(5);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(40);
            }];
            la.text = @"请输入手机号";
            
            
            phoneTextField = [[UITextField alloc]init];
            phoneTextField.userInteractionEnabled = NO;
            NumberKeyboard *m_keyBoard2;
            m_keyBoard2 = [[NumberKeyboard alloc]init];
            m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
            m_keyBoard2.maxLength = 11;
            m_keyBoard2.myDelegate = self;
            m_keyBoard2.currentField = phoneTextField;
            phoneTextField.inputView = m_keyBoard2;
            phoneTextField.placeholder = @"请输入手机号";
            phoneTextField.font = [UIFont systemFontOfSize:14];
            [backView addSubview:phoneTextField];
            [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(5);
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(zuoImageView);
                make.height.mas_equalTo(40);
            }];
            
            UIButton *jieShaoBt = [[UIButton alloc]init];
            [jieShaoBt addTarget:self action:@selector(jieShaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [jieShaoBt setTitle:@"查看介绍" forState:(UIControlStateNormal)];
            [jieShaoBt setTitleColor:kRGBColor(155, 155, 155) forState:(UIControlStateNormal)];
            jieShaoBt.titleLabel.font = [UIFont systemFontOfSize:11];
            [backView addSubview:jieShaoBt];
            [jieShaoBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(40);
            }];
            UIImageView *biazhImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"car_tixing")];
            biazhImageView.frame = CGRectMake(10, (110-80-15)/2+80, 15, 15);
            [backView addSubview:biazhImageView];
            
            self.tishiLabel = [[UILabel alloc]init];
            self.tishiLabel.textColor = kRGBColor(253, 134, 73);
            self.tishiLabel.adjustsFontSizeToFitWidth = YES;
            self.tishiLabel.font = [UIFont systemFontOfSize:13];
            self.tishiLabel.text = @"工作人员会在1-2个工作日内与您联系，请保持电话畅通";
            [backView addSubview:self.tishiLabel];
            [self.tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(biazhImageView.mas_right).mas_equalTo(5);
                make.centerY.mas_equalTo(biazhImageView);
                make.right.mas_equalTo(-10);
            }];
        }else if (i == 1)
        {
            zuoImageView.frame = CGRectMake(10,40+ (40-19)/2, 19, 19);
            zuoImageView.image = DJImageNamed(@"07_store");
            la.text = @"请输入店铺名称";
            nameTextField = [[UITextField alloc]init];
            nameTextField.userInteractionEnabled = NO;
            nameTextField.placeholder = @"请输入店铺名称";
            nameTextField.returnKeyType = UIReturnKeyDone;
            nameTextField.font = [UIFont systemFontOfSize:14];
            nameTextField.delegate  = self;
            [backView addSubview:nameTextField];
            [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(5);
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(zuoImageView);
                make.height.mas_equalTo(40);
            }];
            
            UILabel *la2 = [[UILabel alloc]init];
            la2.font = [UIFont systemFontOfSize:13];
            la2.text = @"*";
            la2.textColor = [UIColor redColor];
            [backView addSubview:la2];
            [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(la.mas_right).mas_equalTo(5);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(40);
            }];
            
        }else
        {
            zuoImageView.frame = CGRectMake(10,40+ (40-19)/2, 16, 19);
            zuoImageView.image = DJImageNamed(@"07_address");
            la.text = @"收货地址";
            addressTextView = [[UITextView alloc]init];
            addressTextView.userInteractionEnabled = NO;
            addressTextView.backgroundColor = [UIColor clearColor];
            addressTextView.delegate = self;
            addressTextView.returnKeyType = UIReturnKeyDone;
            addressTextView.font = [UIFont systemFontOfSize:14];
            addressTextView.delegate  = self;
            [backView addSubview:addressTextView];
            [addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(5);
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(zuoImageView);
                make.height.mas_equalTo(40);
            }];
        }
        
        
        
    }
    gunDongHeight += 120*3;
    
    UIView *xiaBackeView = [[UIView alloc]initWithFrame:CGRectMake(0, gunDongHeight+10, kWindowW, 200)];
    xiaBackeView.backgroundColor = [UIColor whiteColor];
    [mianScrollView addSubview:xiaBackeView];
    
    self.animImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kWindowW, 150)];
    self.animImageView.contentMode = UIViewContentModeScaleAspectFit;
    [xiaBackeView addSubview:self.animImageView];
    
    
    
    
    UILabel *xiaShuoMingLabel = [[UILabel alloc]init];
    xiaShuoMingLabel.font = [UIFont systemFontOfSize:14];
    xiaShuoMingLabel.textColor = kRGBColor(120, 120, 120);
    xiaShuoMingLabel.text = @"购买AIT产品后的使用方法";
    [xiaBackeView addSubview:xiaShuoMingLabel];
    [xiaShuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(xiaBackeView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    gunDongHeight += 200;
    
    
    self.queDingBt = [[UIButton alloc]initWithFrame:CGRectMake(10, gunDongHeight+30, kWindowW-20, 47)];
    self.queDingBt.hidden = YES;
    self.queDingBt.backgroundColor = kZhuTiColor;
    [self.queDingBt setTitle:@"确认修改" forState:(UIControlStateNormal)];
    [self.queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [self.queDingBt.layer setCornerRadius:3];
    [mianScrollView addSubview:self.queDingBt];
    
    gunDongHeight += 60;
    
    mianScrollView.contentSize = CGSizeMake(kWindowW, gunDongHeight+50);
    [self postQingQiuGeRenInForMetion];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.animImageView.animationImages = [self animationImages]; //获取Gif图片列表
    self.animImageView.animationDuration = 8;     //执行一次完整动画所需的时长
    self.animImageView.animationRepeatCount = MAXFLOAT;  //动画重复次数
    [self.animImageView startAnimating];
}
-(void)jieShaoBtChick:(UIButton *)sender
{
    AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
    vc.shiFouGouMai = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)animationImages
{
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (int i = 0; i <28; i++) {
        UIImage *image;
        if (27-i>9) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"_00%d_图层 %d.jpg",27-i,i+1]];
        }else{
            image = [UIImage imageNamed:[NSString stringWithFormat:@"_000%d_图层 %d.jpg",27-i,i+1]];
            
        }
        if (image) {
            [imagesArr addObject:image];
        }
    }
    NPrintLog(@"imagesArr%ld",(unsigned long)imagesArr.count);
    return imagesArr;
}


-(void)queDingBtChick:(UIButton *)sender
{
    
    if (phoneTextField.text.length<=10) {
        [self showMessageWindowWithTitle:@"请填写正确手机号" point:self.view.center delay:1];
        return;
    }
    
    if (nameTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写店铺名称" point:self.view.center delay:1];
        return;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:phoneTextField.text forKey:@"mobile"];
    [mDict setObject:addressTextView.text forKey:@"address"];
    [mDict setObject:nameTextField.text forKey:@"store_name"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store/ait/modify_ait_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            weakSelf.aITBuyView.hidden = NO;

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
                        weakSelf.aITBuyView.daoLabel.text = [NSString stringWithFormat:@"(%@s返回)",timeStr];
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

-(void)postQingQiuGeRenInForMetion
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store/ait/store_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        phoneTextField.text = KISDictionaryHaveKey(dataDic, @"mobile");
        nameTextField.text = KISDictionaryHaveKey(dataDic, @"name");
        addressTextView.text = KISDictionaryHaveKey(dataDic, @"address");
    } failure:^(id error) {
        
    }];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [nameTextField resignFirstResponder];
        [addressTextView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [nameTextField resignFirstResponder];
        [addressTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
