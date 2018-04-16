//
//  MaintenanceProjecPartstCell.m
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "MaintenanceProjecPartstCell.h"

@interface MaintenanceProjecPartstCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *partBianMaLB;
//@property (nonatomic, strong) UILabel *partsfeeLB;
@property (nonatomic, strong) UITextField *feeTextFild;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) MaintenanceProjectPartstModel *model;
@end

@implementation MaintenanceProjecPartstCell
{
    BOOL isHaveDian;
}
-(void)setUpViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:12];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(10);
            make.height.mas_equalTo(16.5);
            make.right.mas_offset(-100);
        }];
        lb.text = @"美 Fu";
        lb;
    });
    
    UILabel *pDuanLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:11];
        lb.textColor = UIColorHex(#858488);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(15);
        }];
        lb;
    });
    pDuanLB.text = @"配件编码:";
    
    self.partBianMaLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:11];
        lb.textColor = UIColorHex(#858488);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(pDuanLB.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(15);
        }];
        lb;
    });

    UIView *bkView = ({
        UIView *v = [[UIView alloc]init];
        v.layer.cornerRadius = 4;
        v.layer.borderColor = UIColorHex(#979797).CGColor;
        v.layer.borderWidth = 0.25;
        v.layer.masksToBounds = YES;
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pDuanLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(90, 30));
        }];
        v;
    });

    UIButton *jianBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [bkView addSubview:bt];
        bt.backgroundColor = UIColorHex(#F0F0F0);
        [bt setTitle:@"-" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:12];
        [bt setTitleColor:UIColorHex(#848484) forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(0);
        }];
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            int textFiledNum = [_textField.text intValue];
            if (textFiledNum - 1 <= 0) {
                textFiledNum = 0;
            }else{
                textFiledNum = textFiledNum - 1;
            }
            self.textField.text = [NSString stringWithFormat:@"%d",textFiledNum];
            self.model.parts_num = self.textField.text;
            [self calculateAllParts_fee];
        }];
        bt;
    });

    self.textField = [UITextField new];
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.returnKeyType = UIReturnKeySend;\
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
    [bkView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(jianBT.mas_right).mas_equalTo(0);
        make.width.mas_equalTo(30);
    }];
    
    UIButton *addBT = (({
        UIButton *bt = [[UIButton alloc]init];
        [bkView addSubview:bt];
        bt.backgroundColor = UIColorHex(#F0F0F0);
        [bt setTitle:@"+" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:12];
        [bt setTitleColor:UIColorHex(#848484) forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(0);
        }];
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            int textFiledNum = [_textField.text intValue];
            if (textFiledNum + 1 > [self.model.count floatValue]) {
                UIAlertView *act = [[UIAlertView alloc]initWithTitle:nil message:@"不能大于库存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [act show];
                return ;
            }
            self.textField.text = [NSString stringWithFormat:@"%d",textFiledNum + 1 ];
            self.model.parts_num = self.textField.text;
            [self calculateAllParts_fee];
        }];
        bt;
    }));
    
    UIImageView *renMinBiImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bkView);
            make.left.mas_equalTo(bkView.mas_right).mas_equalTo(13.5);
            make.size.mas_equalTo(CGSizeMake(8.5, 8.5));
        }];
        im;
    });
    
    
    
    self.feeTextFild = [UITextField new];
    _feeTextFild.delegate = self;
    _feeTextFild.layer.cornerRadius = 8;
    _feeTextFild.layer.borderColor = UIColorHex(#979797).CGColor;
    _feeTextFild.layer.borderWidth = 0.25;
    _feeTextFild.keyboardType = UIKeyboardTypeDecimalPad;
    _feeTextFild.textAlignment = NSTextAlignmentCenter;
    _feeTextFild.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
    _feeTextFild.textColor = UIColorHex(#FF001F);
    [self.contentView addSubview:_feeTextFild];
    _feeTextFild.frame = CGRectMake(127, 60.5, 71.5, 32);
    [_feeTextFild addTarget:self action:@selector(feeTextFildChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *changBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [self.contentView addSubview:bt];
        bt.layer.cornerRadius = 4;
        bt.layer.borderWidth = 0.25;
        bt.layer.borderColor = UIColorHex(#4B8EE2).CGColor;
        [bt setTitle:@"更换" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [bt setTitleColor:UIColorHex(#4C8CE2) forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(7.5);
            make.size.mas_equalTo(CGSizeMake(42.5, 24));
            make.right.mas_equalTo(-10);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            !self.changePartst ? : self.changePartst(self.model);
        }];
        bt;
    });
}
- (void)bingViewModel:(id)viewModel{
    /*
     @property (nonatomic, strong) UILabel *nameLB;
     @property (nonatomic, strong) UILabel *partBianMaLB;
     @property (nonatomic, strong) UILabel *partsfeeLB;
     @property (nonatomic, strong) UITextField *textField;
     */
    self.model = viewModel;
    self.nameLB.text = _model.parts_name;
    self.partBianMaLB.text = _model.parts_code;
    self.textField.text = _model.parts_num;
    self.feeTextFild.text = _model.parts_fee;
    
    CGFloat text_W = [self.feeTextFild.text widthForFont:[UIFont pf_PingFangSCRegularFontOfSize:14]];
    if (text_W < (71.5 - 30)) {
        
        self.feeTextFild.width = 71.5;
    }else{
        self.feeTextFild.width = text_W + 30;
    }
    
}

- (void)feeTextFildChange:(UITextField *)textField{
    if (textField == self.feeTextFild) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    CGFloat text_W = [self.feeTextFild.text widthForFont:[UIFont pf_PingFangSCRegularFontOfSize:14]];
    if (text_W < (71.5 - 30)) {
        
        self.feeTextFild.width = 71.5;
    }else{
        self.feeTextFild.width = text_W + 30;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEmptyOrWhitespace]) {
        textField.text = @"0";
    }
    if (textField == self.textField) {
        self.model.parts_num = self.textField.text;
    }else if (textField == self.feeTextFild){
        self.model.parts_fee = self.feeTextFild.text;
    }
    
    [self calculateAllParts_fee];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.textField) {
        return YES;
    }
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }else{
        isHaveDian = YES;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    
                    if (range.location - ran.location <= 1) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

- (void)calculateAllParts_fee{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LC_preChangeNotification" object:nil];
}
@end
