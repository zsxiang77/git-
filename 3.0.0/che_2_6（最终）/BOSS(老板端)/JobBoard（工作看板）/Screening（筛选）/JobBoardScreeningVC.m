//
//  JobBoardScreeningVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardScreeningVC.h"
#import "JobBoardScreeningCell.h"

@interface JobBoardScreeningVC ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *mianCollecView;
@property(nonatomic,strong)NSMutableArray *lotteryInfos;

@end

@implementation JobBoardScreeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"筛选" withBackButton:YES];
    
    [self huQuShuJu];
    
}

-(UICollectionView *)mianCollecView
{
    if (!_mianCollecView) {
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        float itemWidth = kWindowW/3-1;
        float itemHeight = 99.5;//itemWidth/2.0;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.headerReferenceSize = (CGSize){kWindowW,  0};
        
        _mianCollecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW,kWindowH-kBOSSNavBarHeight) collectionViewLayout:layout];
        _mianCollecView.backgroundColor = kRGBColor(248, 248, 248);
        //    m_collectionView.backgroundColor = [UIColor whiteColor];
        _mianCollecView.showsVerticalScrollIndicator = NO;
        _mianCollecView.delegate = self;
        _mianCollecView.dataSource = self;
        [_mianCollecView registerClass:[JobBoardScreeningCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.view addSubview:_mianCollecView];
        
    }
    return _mianCollecView;
}
-(NSMutableArray *)lotteryInfos
{
    if (!_lotteryInfos) {
        _lotteryInfos = [[NSMutableArray alloc]init];
        
    }
    return _lotteryInfos;
}

-(void)huQuShuJu
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[NSString stringWithFormat:@"%ld",self.status] forKey:@"status"];
    [self showOrHideLoadView:YES];
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@user/work_board/task_type",HOST_URL];
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
            [BOSSNetWorkManager loginAgain:self];
            return;
        }
        
        NSArray *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSArray class]]) {
            return ;
        }
        [weakSelf.lotteryInfos removeAllObjects];
        for (int i = 0; i<adData.count; i++) {
            NSDictionary *model = adData[i];
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
    JobBoardScreeningCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell refilshData:self.lotteryInfos[indexPath.row]];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.dianJiChcickBlaock(self.lotteryInfos[indexPath.row]);
    [self.navigationController  popViewControllerAnimated:YES];
}


@end
