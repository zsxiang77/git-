//
//  BuyAITProductsViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BuyAITProductsViewController.h"
#import "NumberKeyboard.h"

@interface BuyAITProductsViewController ()<UITextFieldDelegate,NumKeyboardDelegate,UITextViewDelegate>
{
    UITextField   *phoneTextField;
    UITextField   *nameTextField;
    UITextView   *addressTextView;
}

@end

@implementation BuyAITProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"购买AIT产品" withBackButton:YES];

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
        }else if (i == 1)
        {
            zuoImageView.frame = CGRectMake(10,40+ (40-19)/2, 19, 19);
            zuoImageView.image = DJImageNamed(@"07_store");
            la.text = @"请输入店铺名称";
            nameTextField = [[UITextField alloc]init];
            nameTextField.placeholder = @"请输入店铺名称";
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
            la.text = @"收获地址";
            addressTextView = [[UITextView alloc]init];
            addressTextView.backgroundColor = [UIColor clearColor];
            addressTextView.delegate = self;
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
    
    UIImageView *animImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kWindowW, 150)];
    animImageView.contentMode = UIViewContentModeScaleAspectFit;
    animImageView.animationImages = [self animationImages]; //获取Gif图片列表
    animImageView.animationDuration = 8;     //执行一次完整动画所需的时长
    animImageView.animationRepeatCount = MAXFLOAT;  //动画重复次数
    [animImageView startAnimating];
    [xiaBackeView addSubview:animImageView];
    

    
    
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
    
    
    UIButton *queDingBt = [[UIButton alloc]initWithFrame:CGRectMake(10, gunDongHeight+30, kWindowW-20, 40)];
    queDingBt.backgroundColor = kNavBarColor;
    [queDingBt setTitle:@"提交" forState:(UIControlStateNormal)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    [mianScrollView addSubview:queDingBt];
    
    gunDongHeight += 60;
    
    mianScrollView.contentSize = CGSizeMake(kWindowW, gunDongHeight+50);
    [self postQingQiuGeRenInForMetion];
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
    [NetWorkManager requestWithParameters:mDict withUrl:@"store/ait/ait_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            [weakSelf showMessageWindowWithTitle:@"成功,请保持电话畅通" point:weakSelf.view.center delay:1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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


@end
