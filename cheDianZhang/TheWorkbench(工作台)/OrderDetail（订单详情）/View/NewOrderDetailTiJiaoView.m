//
//  NewOrderDetailTiJiaoView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewOrderDetailTiJiaoView.h"
#import "CheDianZhangCommon.h"
#import "UIImage+ImageWithColor.h"


@implementation NewOrderDetailTiJiaoView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        
        
        UIView *backV = [[UIView alloc]init];
        [backV.layer setMasksToBounds:YES];
        [backV.layer setCornerRadius:3];
        backV.backgroundColor = [UIColor whiteColor];
        [self addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(300);
        }];
        
        UIButton *guanBiBt = [[UIButton alloc]init];
        guanBiBt.imageEdgeInsets = UIEdgeInsetsMake(35, 10, 0, 10);
        [guanBiBt setImage:DJImageNamed(@"tankuang_close") forState:(UIControlStateNormal)];
        [guanBiBt addTarget:self action:@selector(guanBiButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:guanBiBt];
        [guanBiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backV);
            make.bottom.mas_equalTo(backV.mas_top);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(75);
        }];
        
        UILabel *la1 = [[UILabel alloc]init];
        la1.font = [UIFont systemFontOfSize:14];
        la1.text = @"进厂里程";
        la1.textColor = [UIColor grayColor];
        [backV addSubview:la1];
        [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(0);
        }];
        
        UILabel *la2 = [[UILabel alloc]init];
        la2.font = [UIFont systemFontOfSize:14];
        la2.text = @"出厂里程";
        la2.textColor = [UIColor grayColor];
        [backV addSubview:la2];
        [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(40);
        }];
        
        self.jinChangLabei = [[UILabel alloc]init];
        self.jinChangLabei.font = [UIFont systemFontOfSize:14];
        self.jinChangLabei.textColor = [UIColor grayColor];
        [backV addSubview:self.jinChangLabei];
        [self.jinChangLabei mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(0);
        }];
        
        UILabel *la3 = [[UILabel alloc]init];
        la3.font = [UIFont systemFontOfSize:14];
        la3.text = @"KM";
        la3.textColor = [UIColor grayColor];
        [backV addSubview:la3];
        [la3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(40);
        }];
        
        NumberKeyboard *m_keyBoard2;
        m_keyBoard2 = [[NumberKeyboard alloc]init];
        m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
        m_keyBoard2.maxLength = 8;
        m_keyBoard2.myDelegate = self;
        
        self.chuChangTextField = [[UITextField alloc]init];
        self.chuChangTextField.font = [UIFont systemFontOfSize:14];
        m_keyBoard2.currentField = self.chuChangTextField;
        self.chuChangTextField.inputView = m_keyBoard2;
        self.chuChangTextField.placeholder = @"请输入公里数...";
        self.chuChangTextField.delegate = self;
        [backV addSubview:self.chuChangTextField];
        [self.chuChangTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(la3.mas_left).mas_equalTo(5);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(40);
            make.width.mas_equalTo(150);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [backV addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(85);
        }];
        
        
        UILabel *la4 = [[UILabel alloc]init];
        la4.font = [UIFont systemFontOfSize:14];
        la4.text = @"质保方案";
        la4.textColor = [UIColor grayColor];
        [backV addSubview:la4];
        [la4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(90);
        }];
        
        for (int i = 0; i<4; i++) {
            UIButton *bt = [[UIButton alloc]init];
            bt.titleLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                [bt setTitle:@"小修保养" forState:(UIControlStateNormal)];
            }else if (i == 1) {
                [bt setTitle:@"总成大修" forState:(UIControlStateNormal)];
            }else if (i == 2) {
                [bt setTitle:@"整车维修" forState:(UIControlStateNormal)];
            }else if (i == 3) {
                [bt setTitle:@"二级维护" forState:(UIControlStateNormal)];
            }
            bt.tag = 3000+i;
            [bt.layer setMasksToBounds:YES];
            [bt.layer setCornerRadius:3];
            [bt.layer setBorderWidth:0.5];
            [bt.layer setBorderColor:kLineBgColor.CGColor];
            [bt addTarget:self action:@selector(zhiBaoFangAnChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [bt setBackgroundImage:[UIImage imageWithUIColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
            [bt setBackgroundImage:[UIImage imageWithUIColor:[UIColor orangeColor]] forState:(UIControlStateSelected)];
            
            [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [bt setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
            
            [backV addSubview:bt];
            [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(80);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(90+i*40);
            }];
        }
        
        UIButton *queDingBt = [[UIButton alloc]init];
        [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [queDingBt.layer setCornerRadius:3];
        queDingBt.backgroundColor = kNavBarColor;
        [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
        [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [backV addSubview:queDingBt];
        [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(35);
        }];
        
        self.zhiBaoStr = @"";
    }
    return self;
}

-(void)queDingBtChick:(UIButton *)sender
{
    OrderDetailViewController *vc = (OrderDetailViewController *)self.superViewController;
    
    if (self.chuChangTextField.text.length<=0) {
        [vc showMessageWindowWithTitle:@"请输入出厂里程" point:vc.view.center delay:1.5];
        return;
    }
    if ([self.jinChangLabei.text floatValue]>[self.chuChangTextField.text floatValue]) {
        [vc showMessageWindowWithTitle:@"出厂里程必须大于进厂里程" point:vc.view.center delay:1.5];
        return;
    }
    
    if (self.zhiBaoStr.length<=0) {
        [vc showMessageWindowWithTitle:@"请选择质保方案" point:vc.view.center delay:1.5];
        return;
    }
    
    [self shiGongWanCheng];
}
#pragma mark - 施工完成
-(void)shiGongWanCheng{
    OrderDetailViewController *vc = (OrderDetailViewController *)self.superViewController;
    NSString *images = @"";
    NSString *video = @"";
//    for (int i = 0; i<vc.wenTiArray.count; i++) {
//        CarInspectionModel *model = vc.wenTiArray[i];
//        if (model.cunImage) {
//            if (images.length<=0) {
//                images = model.tuPianNameStr;
//            }else
//            {
//                images = [NSString stringWithFormat:@"%@,%@",images,model.tuPianNameStr];
//            }
//        }else
//        {
//            if (video.length<=0) {
//                video = model.tuPianNameStr;
//            }else
//            {
//                video = [NSString stringWithFormat:@"%@,%@",video,model.tuPianNameStr];
//            }
//        }
//    }
    
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:vc.chuanzhiModel.ordercode forKey:@"ordercode"];
    [mDict setObject:images forKey:@"images"];
    [mDict setObject:@"" forKey:@"remark"];
    [mDict setObject:video forKey:@"video"];
    [mDict setObject:self.chuChangTextField.text forKey:@"out_value"];
    [mDict setObject:self.zhiBaoStr forKey:@"qal_plan"];
    [mDict setObject:@"" forKey:@"out_date"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/commit_order" viewController:self.superViewController withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
            [vc.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [vc showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.chuChangTextField && self.chuChangTextField.text.length>0) {
        NSArray *xiashuArray = [self.chuChangTextField.text componentsSeparatedByString:@"."];
        if (xiashuArray.count>=2) {
            NSString *xiashuStr = xiashuArray[1];
            if (xiashuStr.length>=3) {
                return NO;
            }
        }
    }
    
    
    return YES;
}


-(void)zhiBaoFangAnChick:(UIButton *)sender
{
    for (int i = 0; i<4; i++) {
        UIButton *bt = [self viewWithTag:3000+i];
        bt.selected = NO;
    }
    
    sender.selected = !sender.selected;
    self.zhiBaoStr = sender.titleLabel.text;
}


-(void)guanBiButton:(UIButton *)sender
{
    self.hidden = YES;
}
@end
