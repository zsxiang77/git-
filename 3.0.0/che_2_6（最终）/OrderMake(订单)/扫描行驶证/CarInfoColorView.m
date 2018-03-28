//
//  CarInfoColorView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoColorView.h"
#import "CarInfoTitleView.h"
#import "BorderColorButton.h"

@interface CarInfoColorView () <UITextFieldDelegate>
@property (nonatomic, strong) CarInfoTitleView *titleView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray<BorderColorButton *> *colorBtns;

@property (nonatomic, strong) UITextField *customTf;

@property (nonatomic, assign) CGFloat btnWidth;
@end

@implementation CarInfoColorView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btnWidth = (kScreenWidth - 55) / 4;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _titleView = [[CarInfoTitleView alloc] init];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    _titleView.imageName = @"car_info_color_img";
    _titleView.title = @"车身颜色";
    _titleView.isHiddenButton = YES;
    
    _colorBtns = [self creatColorButtonArray];
    _colorBtns.firstObject.selected = YES;
    
    UIButton *lastBtn = _colorBtns.lastObject;
    
    _customTf = ({
        UITextField *tf = [[UITextField alloc] init];
        [self.contentView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastBtn.mas_right).mas_offset(11);
            make.top.mas_equalTo(lastBtn.mas_top);
            make.size.mas_equalTo(CGSizeMake(2 * _btnWidth + 11, 37));
        }];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.textColor = [UIColor colorWithHexString:@"333333"];
        tf.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        tf.placeholder = @"自定义";
        tf.layer.cornerRadius = 4;
        tf.layer.borderWidth = CGFloatFromPixel(1);
        tf.layer.borderColor = [UIColor colorWithHexString:@"979797"].CGColor;
        tf.layer.masksToBounds = YES;
        tf.delegate = self;
        tf.returnKeyType = UIReturnKeyDone;
        tf;
    });
}

- (void)changeCustomTextFieldStateIsSelected:(BOOL)isSeleted
{
    if (isSeleted) {
        _customTf.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
        _customTf.backgroundColor = [UIColor colorWithHexString:@"4A90E2"];
        _customTf.textColor = [UIColor whiteColor];
    }
    else {
        _customTf.layer.borderColor = [UIColor colorWithHexString:@"979797"].CGColor;
        _customTf.backgroundColor = [UIColor whiteColor];
        _customTf.textColor = [UIColor colorWithHexString:@"333333"];
    }
}

#pragma mark -
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self changeButtonSelectedStateFromClickButton:nil];
    [self changeCustomTextFieldStateIsSelected:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _selectedColor = textField.text;
    if ([textField.text isEmptyOrWhitespace]) {
        [self changeCustomTextFieldStateIsSelected:NO];
    } else {
        [self changeCustomTextFieldStateIsSelected:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSArray *)creatColorButtonArray
{
    NSMutableArray *arr = [NSMutableArray array];
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *btn1 = [self creatButtonWithTitle:@"黑色" relativeView:nil isTop:YES isLeft:YES];
    UIButton *btn2 = [self creatButtonWithTitle:@"白色" relativeView:btn1 isTop:YES isLeft:NO];
    UIButton *btn3 = [self creatButtonWithTitle:@"银色" relativeView:btn2 isTop:YES isLeft:NO];
    UIButton *btn4 = [self creatButtonWithTitle:@"红色" relativeView:btn3 isTop:YES isLeft:NO];
    
    UIButton *btn5 = [self creatButtonWithTitle:@"蓝色" relativeView:btn1 isTop:NO isLeft:YES];
    UIButton *btn6 = [self creatButtonWithTitle:@"灰色" relativeView:btn5 isTop:NO isLeft:NO];

    [arr addObject:btn1];
    [arr addObject:btn2];
    [arr addObject:btn3];
    [arr addObject:btn4];
    [arr addObject:btn5];
    [arr addObject:btn6];
    
    return [arr copy];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title relativeView:(UIView *)relativeView isTop:(BOOL)isTop isLeft:(BOOL)isLeft
{
    BorderColorButton *btn = [[BorderColorButton alloc] init];
    [_contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_btnWidth, 37));
        if (isLeft) {
            make.left.mas_equalTo(10);
        }else{
            make.left.mas_equalTo(relativeView.mas_right).mas_offset(11);
        }
        if (isTop) {
            make.top.mas_equalTo(8);
        }else{
            if (isLeft) {
                make.top.mas_equalTo(relativeView.mas_bottom).mas_offset(8);
            }else{
                make.top.mas_equalTo(relativeView.mas_top);
            }
        }
    }];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = NO;
    return btn;
}

- (void)clickButton:(BorderColorButton *)sender
{
    [_customTf resignFirstResponder];
    
    _customTf.text = nil;
    [self changeCustomTextFieldStateIsSelected:NO];
    _selectedColor = sender.titleLabel.text;
    
    sender.selected = !sender.selected;
    [self changeButtonSelectedStateFromClickButton:sender];
}

- (void)changeButtonSelectedStateFromClickButton:(UIButton *)button
{
    for (BorderColorButton *btn in _colorBtns) {
        if (btn == button) {
            continue;
        }
        btn.selected = NO;
    }
}

- (void)setSelectedColorWithColorText:(NSString *)colorText
{
    UIButton *selectedBtn = nil;
    for (UIButton *btn in _colorBtns) {
        if (![btn.titleLabel.text isEqualToString:colorText]) {
            continue;
        }
        selectedBtn = btn;
    }
    
    if (!selectedBtn) {
        _customTf.text = colorText;
        [self changeButtonSelectedStateFromClickButton:nil];
        [self changeCustomTextFieldStateIsSelected:YES];
    } else {
        selectedBtn.selected = YES;
        [self changeButtonSelectedStateFromClickButton:selectedBtn];
    }
    _selectedColor = colorText;
}
@end
