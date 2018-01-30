//
//  GTVerifyCodeView.m
//  codeView
//
//  Created by Thinkive on 2017/11/19.
//  Copyright © 2017年 Thinkive. All rights reserved.
//

#import "GTVerifyCodeView.h"

#import "UIView+MBLayout.h"
#import "UIColor+Extend.h"
#import "UITextField+GTExtend.h"
#import "CheDianZhangCommon.h"


@interface GTVerifyCodeView ()<UITextFieldDelegate,GTTextFieldDelegate,VINinPutViewDelegate>
/** */
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label6;
@property (nonatomic, strong) UILabel *label7;
@property (nonatomic, strong) UILabel *label8;
@property (nonatomic, strong) UILabel *label9;
@property (nonatomic, strong) UILabel *label10;
@property (nonatomic, strong) UILabel *label11;
@property (nonatomic, strong) UILabel *label12;
@property (nonatomic, strong) UILabel *label13;
@property (nonatomic, strong) UILabel *label14;
@property (nonatomic, strong) UILabel *label15;
@property (nonatomic, strong) UILabel *label16;
@property (nonatomic, strong) UILabel *label17;
/** */
@property (nonatomic, copy) OnFinishedEnterCode onFinishedEnterCode;
@end

@implementation GTVerifyCodeView

- (instancetype)initWithFrame:(CGRect)frame onFinishedEnterCode:(OnFinishedEnterCode)onFinishedEnterCode {
    if (self = [super initWithFrame:frame]) {
        CGFloat labWidth = (kWindowW-60)/17;
        CGFloat labHeight = 30;
        CGFloat margin = 10;
        
        if (onFinishedEnterCode) {
            _onFinishedEnterCode = [onFinishedEnterCode copy];
        }
        
        for (NSInteger i = 0; i<17; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(margin*(i/4+1)+labWidth*i, 0, labWidth, labHeight);
//            if (i%2) {
//                label.backgroundColor = [UIColor yellowColor];
//            }else{
//                label.backgroundColor = [UIColor greenColor];
//            }
            label.tag = 100+i;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            if (KIS_IPHONE_6P) {
                label.font = [UIFont systemFontOfSize:19];
            }else{
                label.font = [UIFont systemFontOfSize:18];
            }
            
            label.adjustsFontSizeToFitWidth = YES;
            label.textColor = kRGBColor(74, 74, 74);
            label.text = @"";
//            [label setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor clearColor]];
            
            if (i == 0) {
                _label1 = label;
            }else if (i == 1) {
                _label2 = label;
            }else if (i == 2) {
                _label3 = label;
            }else if (i == 3)  {
                _label4 = label;
            }else if (i == 4)  {
                _label5 = label;
            }else if (i == 5)  {
                _label6 = label;
            }else if (i == 6)  {
                _label7 = label;
            }else if (i == 7)  {
                _label8 = label;
            }else if (i == 8)  {
                _label9 = label;
            }else if (i == 9)  {
                _label10 = label;
            }else if (i == 10)  {
                _label11 = label;
            }else if (i == 11)  {
                _label12 = label;
            }else if (i == 12)  {
                _label13 = label;
            }else if (i == 13)  {
                _label14 = label;
            }else if (i == 14)  {
                _label15 = label;
            }else if (i == 15)  {
                _label16 = label;
            }else if (i == 16)  {
                _label17 = label;
            }
            
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(margin*(i/4+1)+labWidth*i+1, labHeight, labWidth-3, 1)];
            
            line.backgroundColor = kRGBColor(199, 199, 199);
            [self addSubview:line];
            
            
            [self addSubview:label];
        }
        
        self.mainTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, labWidth, labHeight)];
        self.mainTextField.font = [UIFont systemFontOfSize:13];
        self.mainTextField.textColor = kRGBColor(74, 74, 74);
        self.mainTextField.delegate = self;
        self.mainTextField.tintColor = kZhuTiColor;
        self.mainTextField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mainTextField];
        
        self.vINinPutView = [[VINinPutView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 100)];
        self.vINinPutView.myDelegate = self;
        self.mainTextField.inputView = self.vINinPutView;
        self.vINinPutView.mainTextField = self.mainTextField;
        
        [self.mainTextField becomeFirstResponder];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(dissMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}
-(void)dissMissView
{
    [self codeBecomeFirstResponder];
}

- (void)shouldChangeCharactersInRangreplacementString:(NSString *)string{
    if (string.length>0) {
        
        if (!self.label1.text.length) {
            self.label1.text = string;
//            [self.label1 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label2.left;
        }else if (!self.label2.text.length) {
            self.label2.text = string;
//            [self.label2 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label3.left;
        }else if (!self.label3.text.length) {
            self.label3.text = string;
//            [self.label3 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label4.left;
        }else if (!self.label4.text.length) {
            self.label4.text = string;
//            [self.label4 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label5.left;
        }else if (!self.label5.text.length) {
            self.label5.text = string;
//            [self.label5 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label6.left;
        }else if (!self.label6.text.length) {
            self.label6.text = string;
//            [self.label6 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label7.left;
        }else if (!self.label7.text.length) {
            self.label7.text = string;
//            [self.label7 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label8.left;
        }else if (!self.label8.text.length) {
            self.label8.text = string;
//            [self.label8 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label9.left;
        }else if (!self.label9.text.length) {
            self.label9.text = string;
//            [self.label9 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label10.left;
        }else if (!self.label10.text.length) {
            self.label10.text = string;
//            [self.label10 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label11.left;
        }else if (!self.label11.text.length) {
            self.label11.text = string;
//            [self.label11 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label12.left;
        }else if (!self.label12.text.length) {
            self.label12.text = string;
//            [self.label12 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label13.left;
        }else if (!self.label13.text.length) {
            self.label13.text = string;
//            [self.label13 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label14.left;
        }else if (!self.label14.text.length) {
            self.label14.text = string;
//            [self.label14 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label15.left;
        }else if (!self.label15.text.length) {
            self.label15.text = string;
//            [self.label15 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label16.left;
        }else if (!self.label16.text.length) {
            self.label16.text = string;
//            [self.label16 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label17.left;
        }else if (!self.label17.text.length) {
            self.label17.text = string;
//            [self.label17 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = _label17.left;
            self.mainTextField.tintColor = [UIColor clearColor];
//            [self.mainTextField resignFirstResponder];
            
            
            
        }
    }else{
        if (self.label17.text.length) {
            self.mainTextField.tintColor = kZhuTiColor;
            self.label17.text = @"";
//            [self.label17 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor clearColor]];
            self.mainTextField.left = self.label17.left;
        }else if (self.label16.text.length) {
            
            self.label16.text = @"";
//            [self.label16 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor clearColor]];
            self.mainTextField.left = self.label16.left;
        }else if (self.label15.text.length) {
            self.label15.text = @"";
//            [self.label15 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label15.left;
        }else if (self.label14.text.length) {
            self.label14.text = @"";
//            [self.label14 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label14.left;
        }else if (self.label13.text.length) {
            self.label13.text = @"";
//            [self.label13 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label13.left;
        }else if (self.label12.text.length) {
            self.label12.text = @"";
//            [self.label12 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label12.left;
        }else if (self.label11.text.length) {
            self.label11.text = @"";
//            [self.label11 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label11.left;
        }else if (self.label10.text.length) {
            self.label10.text = @"";
//            [self.label10 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label10.left;
        }else if (self.label9.text.length) {
            self.label9.text = @"";
//            [self.label9 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label9.left;
        }else if (self.label8.text.length) {
            self.label8.text = @"";
//            [self.label8 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label8.left;
        }else if (self.label7.text.length) {
            self.label7.text = @"";
//            [self.label7 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label7.left;
        }else if (self.label6.text.length) {
            self.label6.text = @"";
//            [self.label6 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label6.left;
        }else if (self.label5.text.length) {
            self.label5.text = @"";
//            [self.label5 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label5.left;
        }else if (self.label4.text.length) {
            self.label4.text = @"";
//            [self.label4 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label4.left;
        }else if (self.label3.text.length) {
            self.label3.text = @"";
//            [self.label3 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label3.left;
        }else if (self.label2.text.length) {
            self.label2.text = @"";
//            [self.label2 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor disabledColor]];
            self.mainTextField.left = self.label2.left;
        }else if (self.label1.text.length) {
            self.label1.text = @"";
//            [self.label1 setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
//            [self.mainTextField setCornerWithRadius:0 borderWidth:.5 borderColor:[UIColor appBaseColor]];
            self.mainTextField.left = self.label1.left;
        }
    }
    
    
    
    if (_onFinishedEnterCode) {
        NSString *code = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",_label1.text,_label2.text,_label3.text,_label4.text,_label5.text,_label6.text,_label7.text,_label8.text,_label9.text,_label10.text,_label11.text,_label12.text,_label13.text,_label14.text,_label15.text,_label16.text,_label17.text];
        _onFinishedEnterCode(code);
    }
    
    
}
- (void)fieldChangeing:(VINinPutView*) vINinPutView
{
    
}


- (void)codeBecomeFirstResponder {
    [self.mainTextField becomeFirstResponder];
}

@end
