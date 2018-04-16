//
//  OrderClassCell.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderClassCell.h"
#import "TopDanXuanViewModel.h"
@interface orderClassCollectionCell()
@property (nonatomic, strong) UIImageView *bkImageView;
@property (nonatomic, strong) UILabel *titleLB;
@end

@implementation orderClassCollectionCell
-(void)setUpViews{
    _bkImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            //-15
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
    _bkImageView.image = [UIImage imageNamed:model.imageName];
    _titleLB.text = model.title;
}
@end


@interface OrderClassCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation OrderClassCell

- (void)setUpViews{
    UILabel *classLb = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        lb;
    });
    classLb.text = @"分类";
    
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.itemSize = CGSizeMake(kScreenWidth/4, 10+60+16+3+15); //104 + 45
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 10+60+16+3+15) collectionViewLayout:flowlayout]; //130;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[orderClassCollectionCell class] forCellWithReuseIdentifier:@"orderClassCollectionCell"];
    [self.contentView addSubview:self.collectionView];
    
    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        v;
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    orderClassCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderClassCollectionCell" forIndexPath:indexPath];
    [cell bingViewModel:self.dataArr[indexPath.row]];
    return cell;
}

-(void)bingViewModel:(id)viewModel{
    if (self.dataArr == viewModel) {
        return;
    }
    self.dataArr = viewModel;
    [self.collectionView reloadData];
}
@end
