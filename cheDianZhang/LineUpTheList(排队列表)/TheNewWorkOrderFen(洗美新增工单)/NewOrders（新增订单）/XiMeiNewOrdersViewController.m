//
//  XiMeiNewOrdersViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersViewController.h"
#import "MJChiBaoZiHeader.h"
#import "XiMeiNewOrdersCell.h"
#import "UIImageView+WebCache.h"
#import "YYModel.h"
#import "XiMeiNewOrdersModer.h"
#import "XiMeiNewOrdersErVC.h"

@interface XiMeiNewOrdersViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *mianCollecView;
@property(nonatomic,strong)NSMutableArray *lotteryInfos;

@end

@implementation XiMeiNewOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增订单" withBackButton:YES];
    UILabel *biaoTiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavBarHeight, kWindowW-20, 40)];
    biaoTiLabel.text = @"洗美";
    biaoTiLabel.font = [UIFont systemFontOfSize:14];
    biaoTiLabel.textColor = [UIColor grayColor];
    [self.view addSubview:biaoTiLabel];
    self.lotteryInfos = [[NSMutableArray alloc]init];
    
    [self huQuShuJu];
    
}

-(UICollectionView *)mianCollecView
{
    if (!_mianCollecView) {
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 1;
        float itemWidth = kWindowW/3-1;
        float itemHeight = 120;//itemWidth/2.0;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.headerReferenceSize = (CGSize){kWindowW,  0};
        
        _mianCollecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+40, kWindowW,kWindowH-kNavBarHeight-40) collectionViewLayout:layout];
        _mianCollecView.backgroundColor = kRGBColor(248, 248, 248);
        //    m_collectionView.backgroundColor = [UIColor whiteColor];
        _mianCollecView.showsVerticalScrollIndicator = NO;
        _mianCollecView.delegate = self;
        _mianCollecView.dataSource = self;
        [_mianCollecView registerClass:[XiMeiNewOrdersCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.view addSubview:_mianCollecView];
        
    }
    return _mianCollecView;
}

-(void)loadNewData
{
    [self.mianCollecView.mj_header endRefreshing];
    [self huQuShuJu];
}

-(void)huQuShuJu
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"2" forKey:@"channel_id"];
    [self showOrHideLoadView:YES];
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/services",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"get参数%@\n返回：%@",mDict,parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSArray *services = KISDictionaryHaveKey(adData, @"services");
        
        [weakSelf.lotteryInfos removeAllObjects];
        for (int i = 0; i<services.count; i++) {
            XiMeiNewOrdersModer *model = [XiMeiNewOrdersModer yy_modelWithDictionary:services[i]];
            [weakSelf.lotteryInfos addObject:model];
        }
        
        [weakSelf.mianCollecView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
    
}

#pragma mark collection delegete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.lotteryInfos count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    XiMeiNewOrdersCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    XiMeiNewOrdersModer *model = self.lotteryInfos[indexPath.row];


    cell.lotteryImage.hidden = NO;
    [cell.lotteryImage sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:DJImageNamed(@"peiJianBack")];
    cell.lotteryName.text = model.title;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XiMeiNewOrdersErVC *vc = [[XiMeiNewOrdersErVC alloc]init];
    XiMeiNewOrdersModer *model = self.lotteryInfos[indexPath.row];
    self.zuiZongModel.service_name = model.title;
    vc.zuiZongModel = self.zuiZongModel;
    vc.chuZhiModel = model;
    vc.zhuModel = self.zhuModel;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
