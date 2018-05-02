//
//  AddXiMeiViewController.m
//  测试
//
//  Created by lcc on 2018/2/4.
//  Copyright © 2018年 lcc. All rights reserved.
//  新增洗美单

#import "AddXiMeiViewController.h"
#import "TopDanXuanCollectionView.h"
#import "LCMessageListView.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionModel.h"
#import "LCBottomView.h"
#import "TopDanXuanCollectionView.h"
#import "XiMeiNewOrdersCell.h"
#import "XiMeiNewOrdersModer.h"

#import "XiMeiNewOrdersErVC.h"

@interface AddXiMeiViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *classDataArr;
@property (nonatomic, strong) NSMutableArray *messageDataArr;
@property (nonatomic, strong) OrderSectionModel *sectionModel;

@property(nonatomic,strong)UICollectionView *mianCollecView;
@property(nonatomic,strong)NSMutableArray *lotteryInfos;

@end

@implementation AddXiMeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增洗美单" withBackButton:YES];
    _messageDataArr = @[].mutableCopy;
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[LCMessageListViewCell class] forCellReuseIdentifier:@"LCMessageListViewCell"];
        [tableView registerClass:[OrderSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"OrderSectionHeaderView"];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.bottom.mas_offset(-49);
    }];
    LCBottomView *bottomView = [LCBottomView new];
    [self.view addSubview:bottomView];
    kWeakSelf(weakSelf)
    bottomView.sendMessage = ^(id model) {
        
        [weakSelf.messageDataArr addObject:model];
        
        if (weakSelf.messageDataArr.count>0) {
            weakSelf.sectionModel.title = [NSString stringWithFormat:@"需求描述(%lu)",(unsigned long)weakSelf.messageDataArr.count];
        }else{
            weakSelf.sectionModel.title = @"需求描述";
        }
        
        [weakSelf.tableView reloadData];
    };
    
    
    bottomView.nextStep = ^() {
        XiMeiNewOrdersErVC *vc = [[XiMeiNewOrdersErVC alloc]init];
        XiMeiNewOrdersModer *model;
        for (int i = 0; i<self.classDataArr.count; i++) {
            XiMeiNewOrdersModer *model2 = self.classDataArr[i];
            if (model2.isSelect) {
                model = model2;
            }
        }
        if (!model) {
            return ;
        }
        NSMutableArray *arrayMiaoShu = [[NSMutableArray alloc]init];
        if (weakSelf.messageDataArr.count>0) {
            for (int i = 0; i<weakSelf.messageDataArr.count; i++) {
                [arrayMiaoShu addObject:weakSelf.messageDataArr[i]];
            }
        }
        weakSelf.xiMeiZuiZhongModel.miaoShuArray = arrayMiaoShu;
        vc.zuiZongModel = weakSelf.xiMeiZuiZhongModel;
        vc.userInformetionDict = weakSelf.userInformetionDict;
        vc.chuZhiModel = model;
//        vc.zhuModel = self.zhuModel;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        NPrintLog(@"下一步");
    };
    
    
    _sectionModel = [OrderSectionModel new];
    _sectionModel.title = @"需求描述";
    _sectionModel.imageName = @"故障描述";

    self.classDataArr = [[NSMutableArray alloc]init];
    [self huQuShuJu];
}

-(void)setBuJU{
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    float itemWidth = kWindowW/3;
    float itemHeight = 120;//itemWidth/2.0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.sectionInset = UIEdgeInsetsZero;
    layout.headerReferenceSize = (CGSize){kWindowW,  0};
    
    _mianCollecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWindowW,120*(self.classDataArr.count/3+1)) collectionViewLayout:layout];
    _mianCollecView.backgroundColor = [UIColor whiteColor];
    _mianCollecView.showsVerticalScrollIndicator = NO;
    _mianCollecView.delegate = self;
    _mianCollecView.dataSource = self;
    [_mianCollecView registerClass:[XiMeiNewOrdersCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
    
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
        }else if (code == 605)
        {
            
            UIAlertView *alc = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(parserDict, @"msg") delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil];
            [alc show];
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
        
        for (int i=0; i<services.count; i++) {
            XiMeiNewOrdersModer *model = [XiMeiNewOrdersModer new];
            [model setDictData:services[i]];
            [weakSelf.classDataArr addObject:model];
        }
        [weakSelf setBuJU];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 1;
    }
    return self.messageDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            
        }else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.mianCollecView];
        
        [self.mianCollecView reloadData];
        return cell;
    }else if (indexPath.section == 1) {
        LCMessageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMessageListViewCell" forIndexPath:indexPath];
        [cell bingViewModel:self.messageDataArr[indexPath.row]];
        return cell;
    }
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderSectionHeaderView"];
    [headerView bingViewModel:_sectionModel];
    return headerView;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    <#SectionFooterViewClass#> *footerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:<#Identifier#>];
//    return footerView;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return self.mianCollecView.height;
    }else if(indexPath.section == 1 && self.messageDataArr> 0){
        LCMessageViewModel *mode = self.messageDataArr[indexPath.row];
        return mode.cell_H;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
       
        return 35;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        return YES;
    }
    return NO;
    
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LCMessageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMessageListViewCell" forIndexPath:indexPath];
        [cell bingViewModel:self.messageDataArr[indexPath.row]];

        
        
        [self.messageDataArr removeObjectAtIndex:indexPath.row];
        if (self.messageDataArr.count>0) {
            _sectionModel.title = [NSString stringWithFormat:@"需求描述(%lu)",(unsigned long)self.messageDataArr.count];
        }else{
            _sectionModel.title = @"需求描述";
        }
        
        [self.tableView reloadData];
    }
}



#pragma mark collection delegete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.classDataArr count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    XiMeiNewOrdersCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    XiMeiNewOrdersModer *model = self.classDataArr[indexPath.row];
    
    
    cell.lotteryImage.hidden = NO;
    [cell.lotteryImage sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:DJImageNamed(@"Login_01-logo")];
    NPrintLog(@"%@",model.title);
    cell.lotteryName.text = model.title;
    
    cell.xuanZhongImage.hidden = !model.isSelect;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i<self.classDataArr.count; i++) {
        XiMeiNewOrdersModer *model = self.classDataArr[i];
        model.isSelect = NO;
    }
    XiMeiNewOrdersModer *model = self.classDataArr[indexPath.row];
    model.isSelect = YES;
    [self.mianCollecView reloadData];
}



@end
