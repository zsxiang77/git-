
//
//  RepairSecondCell.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "RepairSecondCell.h"

@interface RepairSecondCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITextField *feeTextFild;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UIView *line;
@end

@implementation RepairSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _selectBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.top.mas_equalTo(13);
        }];
        [btn setImage:[UIImage imageNamed:@"rect_check_box_unselect"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"rect_check_box_selected"] forState:UIControlStateSelected];
//        btn.userInteractionEnabled = NO;
        @weakify(self)
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            @strongify(self)
            sender.selected = !sender.selected;
            self.model.isSelect = sender.selected;
        }];
        btn;
    });
    
//    ();
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(self.selectBtn);
            make.right.mas_equalTo(-2);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:13];
        lb;
    });
    
    
    UILabel *gongShiFeiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLb);
        }];
        lb;
    });
    gongShiFeiLB.text = @"工时费";
    
    
    
    
    UIImageView *renMinBiImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(gongShiFeiLB);
            make.left.mas_equalTo(gongShiFeiLB.mas_right).mas_equalTo(13.5);
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
    [_feeTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(gongShiFeiLB);
        make.top.mas_equalTo(_titleLb.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(71.5, 32));
        make.left.mas_equalTo(renMinBiImageView.mas_right).mas_equalTo(5);
    }];
    
    
    self.timeLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#666666);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.feeTextFild.mas_right).mas_equalTo(30);
            make.centerY.mas_equalTo(self.feeTextFild);
        }];
        lb;
    });
    
    
    _line = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
        vi;
    });
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEmptyOrWhitespace]) {
        textField.text = @"0.00";
    }
    self.model.fee = textField.text;
    
}

/*
 @property (nonatomic, copy) NSString *subject_id;
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *hour;
 @property (nonatomic, copy) NSString *fee;
 @property (nonatomic, assign) BOOL isSelect;
 @property (nonatomic, assign) BOOL isLast;
 */

-(void)setModel:(RepairSecondDataListModel *)model{
    _model = model;
    _titleLb.text = model.name;
    _timeLB.text = [NSString stringWithFormat:@"工时:%@",model.hour];
    _feeTextFild.text = model.fee;
    _selectBtn.selected = model.isSelect;
}

//- (void)setModel:(RepairSecondCellModel *)model
//{
//    _model = model;
//
//    _selectBtn.selected = model.isSelected;
//    _titleLb.text = model.title;
//    _descLb.attributedText = model.desc;
//    _line.hidden = model.isHiddenLine;
//}


@end
