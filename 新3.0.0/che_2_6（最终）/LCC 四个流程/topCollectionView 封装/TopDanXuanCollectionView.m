//
//  TopDanXuanCollectionView.m
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TopDanXuanCollectionView.h"
//#import "CheDianZhangCommon.h"

@interface TopDanXuanCell ()
@property (nonatomic, strong) UIImageView *bkImageView;
@property (nonatomic, strong) UIImageView *isSelectImageView;
@property (nonatomic, strong) UILabel *titleLB;
@end

@implementation TopDanXuanCell

- (void)setUpViews{
    self.bkImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.layer.cornerRadius = 30;
        im.layer.masksToBounds = YES;
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.centerX.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        im;
    });
    
    self.isSelectImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.image = [UIImage imageNamed:@"ic_checked"];
        im.layer.cornerRadius = 10;
        im.layer.masksToBounds = YES;
        im.backgroundColor = [UIColor redColor];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.bkImageView);
            make.right.mas_equalTo(self.bkImageView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        im;
    });
    
    self.titleLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentCenter;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(16);
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.bkImageView.mas_bottom).mas_equalTo(3);
        }];
        lb;
    });

}

-(void)bingViewModel:(id)viewModel{
    TopDanXuanViewModel *model = viewModel;
    if (model.imageUrl) {
        [self.bkImageView setImageURL:[NSURL URLWithString:model.imageUrl]];
    }else{
        self.bkImageView.image = [UIImage imageNamed:model.imageName];
    }
    self.titleLB.text = model.title;
    self.isSelectImageView.hidden = !model.isSelect;
}
@end

@interface TopDanXuanCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) CGPoint locationPoint;
@end
@implementation TopDanXuanCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout * flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.itemSize = CGSizeMake(kWindowW/4, 60+10+6+14);
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, kWindowW, 0) collectionViewLayout:flowlayout]) {
        [self registerClass:[TopDanXuanCell class] forCellWithReuseIdentifier:@"TopDanXuanCell"];
        self.delegate = self;
        self.dataSource = self;
        self.locationPoint = CGPointMake(frame.origin.x, frame.origin.y);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopDanXuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopDanXuanCell" forIndexPath:indexPath];
    [cell bingViewModel:self.dataArr[indexPath.row]];
    return cell;
}

- (void)setDataArr:(NSArray<TopDanXuanViewModel *> *)dataArr{
    _dataArr = dataArr;
    [self reloadData];
    [self layoutIfNeeded];

    CGRect rect = CGRectMake(self.locationPoint.x, self.locationPoint.y, self.contentSize.width, self.contentSize.height);
    self.frame = rect;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    !self.didSelect ? : self.didSelect(self.dataArr[indexPath.row]);
    [self reloadData];
}
@end
