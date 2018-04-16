//
//  CPHFWeiViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/18.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CPHFWeiViewController.h"
#import "MJChiBaoZiHeader.h"
#import "JobBoardDeltailJiBenCell.h"
#import "JobBoardDeltailChuLICell.h"

#define kShangCuiViewHeight  (36)
#define kXiaCuiViewHeight  (64)

@interface CPHFWeiViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)CPHFWeiHeaderView *headerView;
@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,assign)BOOL  chuLiZhanHe;//处理绽和 YES展开 NO合并

@property(nonatomic,strong)UIView *shangCuiView;
@property(nonatomic,strong)UIView *xiaCuiView;
@property(nonatomic,strong)UILabel *shangCuilabel;
@property(nonatomic,strong)UIButton *xiaCuiBt;

@end

@implementation CPHFWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:self.chuanZhiModel.name withBackButton:YES];
    
    
    self.shangCuiView = [[UIView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kShangCuiViewHeight)];
    self.shangCuiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shangCuiView];
    [self.shangCuiView.layer setMasksToBounds:YES];
    self.shangCuiView.hidden = YES;
    
    UIView *banView = [[UIView alloc]init];
    banView.backgroundColor = kRGBColor(73, 189, 152);
    [banView.layer setMasksToBounds:YES];
    [banView.layer setCornerRadius:5];
    [self.shangCuiView addSubview:banView];
    [banView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *lineq = [[UILabel alloc]init];
    lineq.backgroundColor = kLineBgColor;
    [self.shangCuiView addSubview:lineq];
    [lineq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.shangCuilabel = [[UILabel alloc]init];
    self.shangCuilabel.textColor = [UIColor whiteColor];
    self.shangCuilabel.font = [UIFont systemFontOfSize:17];
    [self.shangCuiView addSubview:self.shangCuilabel];
    [self.shangCuilabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shangCuiView);
        make.bottom.mas_equalTo(-5);
    }];
    
    
    self.xiaCuiView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-kXiaCuiViewHeight, kWindowW, kXiaCuiViewHeight)];
    self.xiaCuiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.xiaCuiView];
    self.xiaCuiView.hidden = YES;
    
    
    UILabel *xialineq = [[UILabel alloc]init];
    xialineq.backgroundColor = kLineBgColor;
    [self.xiaCuiView addSubview:xialineq];
    [xialineq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.xiaCuiBt = [[UIButton alloc]init];
    self.xiaCuiBt.backgroundColor = kRGBColor(74, 144, 226);
    [self.xiaCuiBt addTarget:self action:@selector(cuiBanChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.xiaCuiBt.layer setMasksToBounds:YES];
    [self.xiaCuiBt.layer setCornerRadius:5];
    [self.xiaCuiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.xiaCuiBt.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.xiaCuiView addSubview:self.xiaCuiBt];
    [self.xiaCuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(48);
        make.center.mas_equalTo(self.xiaCuiView);
    }];
    
    
    self.chuLiZhanHe = NO;
    [self posttask_detail];
    
    
}

-(void)cuiBanChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.task_id forKey:@"task_id"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/work_board/do_unit" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            [weakSelf showAlertViewWithTitle:nil Message:@"催办成功,五分钟内不可以再次催办" buttonTitle:@"确定"];
            [weakSelf posttask_detail];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {
        
    }];
    
}

-(CPHFWeiHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[CPHFWeiHeaderView alloc]init];
    }
    return _headerView;
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStyleGrouped];
//        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
        [self.view addSubview:_mainTableView];
        [self.view bringSubviewToFront:_mainTableView];
    }
    return _mainTableView;
}
-(void)requestMatchInfoData
{
    [self.mainTableView.mj_header endRefreshing];
    [self posttask_detail];
}

-(void)posttask_detail
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.task_id forKey:@"task_id"];
    
    kWeakSelf(weakSelf)
    [self showOrHideLoadView:YES];
    NSString *path = [NSString stringWithFormat:@"%@user/work_board/task_detail",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress){
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }

        if (code == 200) {
            NSDictionary* dataDic = kParseData(responseObject);
            weakSelf.mainDataDict = [[JobBoardDetailModel alloc]init];
            [weakSelf.mainDataDict setdataWithDict:dataDic];
            
            [weakSelf.headerView refreshData:weakSelf.mainDataDict];
            
            weakSelf.mainTableView.tableHeaderView = weakSelf.headerView;
            [weakSelf.maiChuLiArray removeAllObjects];
            if (weakSelf.mainDataDict.task_detail.count>0) {
                for (int i = 0; i<weakSelf.mainDataDict.task_detail.count; i++) {
                    [weakSelf.maiChuLiArray addObject:weakSelf.mainDataDict.task_detail[i]];
                }
            }
            weakSelf.shangCuiView.hidden = YES;
            weakSelf.xiaCuiView.hidden = YES;
            if ([weakSelf.mainDataDict.info.status integerValue] == 0 && weakSelf.mainDataDict.info.press_time.length>0) {
                weakSelf.mainTableView.frame = CGRectMake(0, kBOSSNavBarHeight+kShangCuiViewHeight, kWindowW, kWindowH-kBOSSNavBarHeight-kShangCuiViewHeight - kXiaCuiViewHeight);
//                weakSelf.mainTableView.hidden = YES;
                weakSelf.shangCuiView.hidden = NO;
                weakSelf.shangCuilabel.text = [NSString stringWithFormat:@"已催办 %@",weakSelf.mainDataDict.info.press_time];
                weakSelf.xiaCuiView.hidden = NO;
                [weakSelf.xiaCuiBt setTitle:@"再次催办" forState:(UIControlStateNormal)];
            }else if ([weakSelf.mainDataDict.info.status integerValue] == 0 && !(weakSelf.mainDataDict.info.press_time.length>0)) {
                weakSelf.mainTableView.frame = CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight-kXiaCuiViewHeight );
                weakSelf.xiaCuiView.hidden = NO;
                [weakSelf.xiaCuiBt setTitle:@"催办" forState:(UIControlStateNormal)];
            }else{
                weakSelf.mainTableView.frame = CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight);
            }
            
            
            [weakSelf.mainTableView reloadData];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

//设置催办
-(void)sheCuiban{
    
}
-(NSMutableArray *)maiChuLiArray
{
    if (!_maiChuLiArray) {
        _maiChuLiArray = [[NSMutableArray alloc]init];
    }
    return _maiChuLiArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.maiChuLiArray.count>0) {
        return 2;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.maiChuLiArray.count>0) {
        if (section == 0) {
            if (self.chuLiZhanHe == YES) {//展开
                return self.maiChuLiArray.count;
            }else{
                return 1;
            }
            
        }else{
            return 5;
        }
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.maiChuLiArray.count>0  && indexPath.section == 0) {
        static NSString *Identifier = @"Identifier";
        JobBoardDeltailChuLICell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[JobBoardDeltailChuLICell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.chuLiZhanHe == NO || self.maiChuLiArray.count<=1) {
            [cell refreshIndex:indexPath.row withdict:self.maiChuLiArray[indexPath.row] xian:NO];
        }else{
            [cell refreshIndex:indexPath.row withdict:self.maiChuLiArray[indexPath.row] xian:YES];
        }
        
        return cell;
    }else{
        static NSString *Identifier = @"Identifier2";
        JobBoardDeltailJiBenCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[JobBoardDeltailJiBenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        JobBoardInfoModel *mdoel = self.mainDataDict.info;
        
        if (indexPath.row == 0) {
            [cell refreshIndex:indexPath.row withYouStr:mdoel.car_info];
        }else if (indexPath.row == 1) {
            [cell refreshIndex:indexPath.row withYouStr:mdoel.car_number];
        }else if (indexPath.row == 2) {
            [cell refreshIndex:indexPath.row withYouStr:mdoel.ordercode];
        }else if (indexPath.row == 3) {
            [cell refreshIndex:indexPath.row withYouStr:mdoel.order_type];
        }else{
            [cell refreshIndex:indexPath.row withYouStr:mdoel.end_time];
        }
        
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.maiChuLiArray.count>0  && indexPath.section == 0) {
        NSDictionary *dict = self.maiChuLiArray[indexPath.row];
        CGFloat jisuHei = 90;
        NSDictionary *content = KISDictionaryHaveKey(dict, @"content");
        NSArray *coupon = KISDictionaryHaveKey(content, @"coupon");
        if ([coupon isKindOfClass:[NSArray class]]) {
            if (coupon.count>0) {
                jisuHei += (coupon.count+1) * 30;
            }
            
        }
        
        return jisuHei;
    }else{
        return 49;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    UILabel *zuoline = [[UILabel alloc]init];
    zuoline.backgroundColor = kZhuTiColor;
    [headerV addSubview:zuoline];
    [zuoline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(headerV);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(15);
    }];
    
    UILabel  *biaoTiLabel = [[UILabel alloc]init];
    biaoTiLabel.textColor = kRGBColor(74, 74, 74);
    biaoTiLabel.font = [UIFont boldSystemFontOfSize:17];
    [headerV addSubview:biaoTiLabel];
    [biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(headerV);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [headerV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = kLineBgColor;
    [headerV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    if (self.maiChuLiArray.count>0  && section == 0) {
        biaoTiLabel.text = @"处理结果";
    }else{
        biaoTiLabel.text = @"基本信息";
    }
    
    return headerV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *foootView = [[UIView alloc]init];
    if (self.maiChuLiArray.count>1  && section == 0) {
        UILabel *la = [[UILabel alloc]init];
        la.textColor = kRGBColor(155, 155, 155);
        la.font = [UIFont systemFontOfSize:14];
        [foootView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(foootView);
        }];
        if (self.chuLiZhanHe == YES) {//展开
            la.text = @"收起历史记录";
        }else{
            la.text = @"展开查看历史记录";
        }
        
        
        UIButton *bt = [[UIButton alloc]init];
        [bt addTarget:self action:@selector(zhanHeChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [foootView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return foootView;
}

-(void)zhanHeChick:(UIButton *)sender
{
    self.chuLiZhanHe = !self.chuLiZhanHe;
    [self.mainTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.maiChuLiArray.count>1  && section == 0) {
        return 30;
    }else{
        return 0;
    }
}

@end
