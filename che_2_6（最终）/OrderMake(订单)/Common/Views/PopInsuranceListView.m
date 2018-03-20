//
//  PopInsuranceListView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PopInsuranceListView.h"
#import "PopInsuranceListModel.h"
#import "KLCPopup.h"

@interface PopInsuranceListCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UIImageView *selectedIv;
@property (nonatomic, strong) UITextField *customTf;

@property (nonatomic, strong) PopInsuranceListCellModel *model;

@end

@implementation PopInsuranceListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _iconIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.layer.cornerRadius = 4;
        iv.layer.borderWidth = CGFloatFromPixel(1);
        iv.layer.borderColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
        iv.layer.masksToBounds = YES;
        iv;
    });

    _selectedIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.iconIv.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.iconIv.mas_bottom).mas_offset(-5);
        }];
        iv.image = [UIImage imageNamed:@"ic_checked"];
        iv.hidden = YES;
        iv;
    });
    
    _customTf = ({
        UITextField *tf = [[UITextField alloc] init];
        [self.contentView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.iconIv);
            make.center.mas_equalTo(tf.superview);
        }];
        tf.textColor = [UIColor colorWithHexString:@"333333"];
        tf.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        tf.placeholder = @"自定义";
        tf.layer.cornerRadius = 4;
        tf.layer.borderWidth = CGFloatFromPixel(1);
        tf.layer.borderColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
        tf.layer.masksToBounds = YES;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.returnKeyType = UIReturnKeyDone;
        tf;
    });
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _model.isSelected = selected;
    
    if (selected) {
        _selectedIv.hidden = NO;
        if (_model.isCustom) {
            _selectedIv.hidden = YES;
        }
    }
    else {
        _selectedIv.hidden = YES;
        _customTf.text = @"";
    }
}

- (void)setModel:(PopInsuranceListCellModel *)model
{
    _model = model;
    
    [_iconIv setImageURL:model.iconURL];
    _customTf.hidden = !model.isCustom;
//    _iconIv.hidden = !model.isSelected;
}

@end


@interface PopInsuranceListView () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) PopInsuranceListModel *model;

@property (nonatomic, weak) KLCPopup *popup;
@property (nonatomic, assign) BOOL isCommit;
//@property (nonatomic, copy) NSIndexPath *selectedIndexPath;
@end

@implementation PopInsuranceListView
static NSString *const PopInsuranceListCellIdf = @"PopInsuranceListCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    _titleLb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
    _titleLb.textColor = [UIColor colorWithHexString:@"333333"];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.text = @"请选择保险公司";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    layout.itemSize = CGSizeMake((self.width - 32) / 3, 48);
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.multipleTouchEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[PopInsuranceListCell class] forCellWithReuseIdentifier:PopInsuranceListCellIdf];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(230);
    }];
    
    CGFloat btnW = (self.width - 20 - 28) * 0.5;
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(47);
    }];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    _cancelBtn.layer.cornerRadius = 4;
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.borderWidth = CGFloatFromPixel(1);
    _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
    [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelBtn.mas_top);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - Action
- (void)clickCancelButton:(UIButton *)sender
{
    [self endEditing:YES];
    self.isCommit = NO;
    [self.popup dismiss:YES];
}

- (void)clickCommitButton:(UIButton *)sender
{
    [self endEditing:YES];
    self.isCommit = YES;
    [self.popup dismiss:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    PopInsuranceListCellModel *cellModel = _model.dataSource.lastObject;
    cellModel.name = textField.text;
    cellModel.isSelected = ![cellModel.name isEmptyOrWhitespace];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PopInsuranceListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PopInsuranceListCellIdf forIndexPath:indexPath];
    cell.customTf.delegate = self;
    cell.model = _model.dataSource[indexPath.item];
    return cell;
}

#pragma mark -
- (void)showFromModel:(PopInsuranceListModel *)model
{
    _model = model;
    [_collectionView reloadData];
    
    KLCPopup *popup = [KLCPopup popupWithContentView:self showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    self.popup = popup;
    popup.willStartDismissingCompletion = ^{
        [self endEditing:YES];
    };
    popup.didFinishDismissingCompletion = ^{
        if (self.isCommit) {
            PopInsuranceListCellModel *model = [self getSelectedModel];
            !self.didSecectedCallBack ?: self.didSecectedCallBack(model.name, model.iconURL);
        }
    };
    
    [popup show];
    
}

- (PopInsuranceListCellModel *)getSelectedModel
{
    PopInsuranceListCellModel *customModel = _model.dataSource.lastObject;
    PopInsuranceListCellModel *selectedModel = nil;
    
    NSMutableArray *selectedModels = [NSMutableArray array];
    NSArray *selectedItemsIndexPath = self.collectionView.indexPathsForSelectedItems;
    for (NSIndexPath *index in selectedItemsIndexPath) {
        [selectedModels addObject:_model.dataSource[index.item]];
    }
    
    if ([selectedModels containsObject:customModel]) {
        [selectedModels removeObject:customModel];
    }
    
    if (selectedModels.count > 0) {
        selectedModel =  selectedModels.lastObject;
    }
    else {
        selectedModel = customModel;
    }
    
    return selectedModel;
}
@end
