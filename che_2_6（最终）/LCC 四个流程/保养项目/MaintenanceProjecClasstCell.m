//
//  MaintenanceProjecClasstCell.m
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "MaintenanceProjecClasstCell.h"
#import "MaintenanceProjectModel.h"
@interface  MaintenanceProjecClasstCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *selectBT;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *timeLB;

//@property (nonatomic, strong) UILabel *feeLb;
@property (nonatomic, strong) UITextField *feeTextFild;
@property (nonatomic, strong) MaintenanceProjectModel *model;
@end

@implementation MaintenanceProjecClasstCell
{
    BOOL isHaveDian;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUpViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [self.contentView addSubview:bt];
        [bt setImage:[[UIImage imageNamed:@"rect_check_box_unselect"] imageByResizeToSize:CGSizeMake(18, 18)] forState:UIControlStateNormal];
        [bt setImage:[[UIImage imageNamed:@"rect_check_box_selected"] imageByResizeToSize:CGSizeMake(18, 18)] forState:UIControlStateSelected];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(38, 38));
            make.left.mas_equalTo(0);
        }];
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            sender.selected = !sender.selected;
            !self.selectBtClick ? : self.selectBtClick();
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LC_preChangeNotification" object:nil];
        }];
        bt;
    });
//    10 + 18 + 10
    self.iconImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.image = [UIImage imageNamed:@"机滤"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectBT.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(self.selectBT);
            make.size.mas_equalTo(CGSizeMake(16.5, 16.5));
        }];
        im;
    });
    
    self.nameLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.selectBT);
            make.right.mas_offset(-10);
        }];
        lb.text = @"油类";
        lb;
    });

    self.timeLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#666666);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLB);
        }];
        lb.text = @"工时3:";
        lb;
    });
    
    UILabel *gongShiFeiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLB.mas_right).mas_equalTo(25);
            make.centerY.mas_equalTo(self.timeLB);
        }];
        lb;
    });
    gongShiFeiLB.text = @"工时费";
    
    
    
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
    _feeTextFild.frame = CGRectMake(190, 38, 71.5, 32);
    
    [_feeTextFild addTarget:self action:@selector(feeTextFildChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *renMinBiImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(gongShiFeiLB);
            make.left.mas_equalTo(gongShiFeiLB.mas_right).mas_equalTo(4);
            make.size.mas_equalTo(CGSizeMake(8.5, 8.5));
            make.centerY.mas_equalTo(_feeTextFild);
        }];
        im;
    });
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEmptyOrWhitespace]) {
        textField.text = @"0.00";
    }
    self.model.fee = textField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LC_preChangeNotification" object:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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




- (void)feeTextFildChange:(UITextField *)textField{
    if (textField == self.feeTextFild) {
        if (textField.text.length > 8) {
            textField.text = [textField.text substringToIndex:8];
        }
    }
    
    CGFloat text_W = [self.feeTextFild.text widthForFont:[UIFont pf_PingFangSCRegularFontOfSize:14]];
    if (text_W < (71.5 - 30)) {
        
        self.feeTextFild.width = 71.5;
    }else{
        self.feeTextFild.width = text_W + 30;
    }
}

/*
 工时费：长度7位 ，小数点保留1位 （999999.9）
 工时：长度5位 ，  小数点保留1位 （9999.9）
 */

-(void)bingViewModel:(id)viewModel{
    MaintenanceProjectModel *model = viewModel;
    self.model = model;
    self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiangmu_%@",model.img_num]];
    self.selectBT.selected = model.isSelect;
    self.nameLB.text = model.name;
    self.timeLB.text = [NSString stringWithFormat:@"工时:%@",model.hour];
    self.feeTextFild.text = model.fee;
    
    CGFloat text_W = [self.feeTextFild.text widthForFont:[UIFont pf_PingFangSCRegularFontOfSize:14]];
    if (text_W < (71.5 - 30)) {
        
        self.feeTextFild.width = 71.5;
    }else{
        self.feeTextFild.width = text_W + 30;
    }

}
@end
