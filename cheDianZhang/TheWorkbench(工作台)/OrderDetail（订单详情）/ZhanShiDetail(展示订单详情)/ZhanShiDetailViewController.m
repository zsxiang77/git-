//
//  ZhanShiDetailViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ZhanShiDetailViewController.h"
#import "MJChiBaoZiHeader.h"
#import "DetailZhiJianCell.h"
#import "DetailPingJiaCell.h"
#import "DetailShiGongCell.h"
#import "DetailShiGongHeaderCell.h"

@interface ZhanShiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ZhanShiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单详情" withBackButton:YES];
    shiGongZhanHe = NO;
    zhiJianZhanHe = NO;
    pingJiaZhanHe = NO;
    
    _xiangMuMingXiArrayCun = [[NSMutableArray alloc]init];
    _peiJianMingXiArrayCun = [[NSMutableArray alloc]init];
    
    [self setrequest_methodwithOrdercodevarchar:self.chuanZhiModel];
    [self postpeiJianMingXiWithModel:self.chuanZhiModel];
    [self postrequest_methodMingXiWithModel :self.chuanZhiModel];
    
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
}
-(void)viewWillAppear:(BOOL)animate
{
    [super viewWillAppear:animate];
    
}

-(WeiXiuZhanShiModel *)zhuModel
{
    if (!_zhuModel){
        _zhuModel = [[WeiXiuZhanShiModel alloc]init];
    }
    return _zhuModel;
}
//-(WeiXiuZhanShiView *)headerViwe
//{
//    if (!_headerViwe) {
//        _headerViwe = [[WeiXiuZhanShiView alloc]init];
//    }
//}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.tableHeaderView = self.orderDetailHeaderView;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}
-(void)loadNewData0
{
    [self setrequest_methodwithOrdercodevarchar:self.chuanZhiModel];
    [self postpeiJianMingXiWithModel:self.chuanZhiModel];
    [self postrequest_methodMingXiWithModel :self.chuanZhiModel];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
        if (self.chuanZhiModel.ait_switch == YES) {
            return 5;
        }else{
            return 4;
        }
    }else{
        if (self.chuanZhiModel.ait_switch == YES) {
            return 2;
        }else{
            return 1;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
        if (self.chuanZhiModel.ait_switch == YES) {
            if (section == 2) {
                if (shiGongZhanHe == YES) {
                    return _xiangMuMingXiArrayCun.count + _peiJianMingXiArrayCun.count +2;
                }else{
                    return 0;
                }
            }else if(section == 3)
            {
                if ([self.zhuModel.is_builder boolValue] == YES && zhiJianZhanHe == YES) {
                    return 3;
                }else{
                    return 0;
                }
            }else if(section == 4)
            {
                if ([self.zhuModel.is_comment boolValue] == YES && pingJiaZhanHe == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        return 3;
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        return 1;
                    }else{
                        return 0;
                    }
                }else{
                    return 0;
                }
            }
            return 0;
        }else{
            if (section == 1 && shiGongZhanHe == YES) {
                return _xiangMuMingXiArrayCun.count + _peiJianMingXiArrayCun.count +2;
            }else if(section == 2 && zhiJianZhanHe == YES)
            {
                if ([self.zhuModel.is_builder boolValue] == YES) {
                    return 3;
                }else{
                    return 0;
                }
            }else if(section == 3 && pingJiaZhanHe == YES)
            {
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        return 3;
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        return 1;
                    }else{
                        return 0;
                    }
                }else{
                    return 0;
                }
            }
            return 0;
        }
    }else{
        if (section == 0) {
            if (shiGongZhanHe == YES) {
                if ([self.zhuModel.service_info isKindOfClass:[NSDictionary class]]) {
                    return 2;
                }
                return 0;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }
}

-(NSMutableAttributedString *)jisuanXiangMuZongE{
    CGFloat jiaGe = 0.00;
    if (_xiangMuMingXiArrayCun.count>0) {
        for (int i = 0; i<_xiangMuMingXiArrayCun.count; i++) {
            OrignalModel *model = _xiangMuMingXiArrayCun[i];
            jiaGe += [model.reality_fee floatValue];
        }
    }
    
    NSString *qudianStr = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jiaGe]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总价：%@",qudianStr]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, qudianStr.length)];
    return att;
}
-(NSMutableAttributedString *)jisuanPeiJianZongE{
    CGFloat jiaGe = 0.00;
    if (_peiJianMingXiArrayCun.count>0) {
        for (int i = 0; i<_peiJianMingXiArrayCun.count; i++) {
            PeiJianListModel *model = _peiJianMingXiArrayCun[i];
            jiaGe += [model.parts_total floatValue];
        }
    }
    NSString *qudianStr = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jiaGe]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总价：%@",qudianStr]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, qudianStr.length)];
    return att;
}
-(NSMutableAttributedString *)jisuanZongE{
    CGFloat jiaGe = 0.00;
    if (_peiJianMingXiArrayCun.count>0) {
        for (int i = 0; i<_peiJianMingXiArrayCun.count; i++) {
            PeiJianListModel *model = _peiJianMingXiArrayCun[i];
            jiaGe += [model.parts_total floatValue];
        }
    }
    
    if (_xiangMuMingXiArrayCun.count>0) {
        for (int i = 0; i<_xiangMuMingXiArrayCun.count; i++) {
            OrignalModel *model = _xiangMuMingXiArrayCun[i];
            jiaGe += [model.reality_fee floatValue];
        }
    }
    NSString *qudianStr = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jiaGe]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总价：%@",qudianStr]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, qudianStr.length)];
    return att;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
        if (self.chuanZhiModel.ait_switch == YES) {
            if (indexPath.section == 2) {
                if (shiGongZhanHe == YES) {
                    if (indexPath.row == 0 || indexPath.row == _xiangMuMingXiArrayCun.count+1) {
                        static NSString *myIdentifier = @"DetailShiGongHeaderCell";
                        DetailShiGongHeaderCell *cell = (DetailShiGongHeaderCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                        if (cell == nil)
                            cell = [[DetailShiGongHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        if (indexPath.row == 0) {
                            cell.zuoLabel.text = [NSString stringWithFormat:@"项目明细(%ld)",_xiangMuMingXiArrayCun.count];
                            
                            cell.youLabel.attributedText = [self jisuanXiangMuZongE];
                        }
                        if (indexPath.row == _xiangMuMingXiArrayCun.count+1) {
                            cell.zuoLabel.text = [NSString stringWithFormat:@"配件明细(%ld)",_peiJianMingXiArrayCun.count];
                            cell.youLabel.attributedText = [self jisuanPeiJianZongE];
                        }
                        return cell;
                    }else{
                        static NSString *myIdentifier = @"DetailShiGongCell";
                        DetailShiGongCell *cell = (DetailShiGongCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                        if (cell == nil)
                            cell = [[DetailShiGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        if ((indexPath.row >=_xiangMuMingXiArrayCun.count+2)&&(_xiangMuMingXiArrayCun.count+2+_peiJianMingXiArrayCun.count)) {
                            if (indexPath.row == _xiangMuMingXiArrayCun.count+1+_peiJianMingXiArrayCun.count) {
                                [cell refleshData:_peiJianMingXiArrayCun[indexPath.row-2-_xiangMuMingXiArrayCun.count] whitshiFouXian:YES];
                            }else{
                                [cell refleshData:_peiJianMingXiArrayCun[indexPath.row-2-_xiangMuMingXiArrayCun.count] whitshiFouXian:NO];
                            }
                            
                            
                        }else{
                            if (indexPath.row == _xiangMuMingXiArrayCun.count) {
                                [cell refleshDataxianMu:_xiangMuMingXiArrayCun[indexPath.row-1] whitshiFouXian:YES];
                            }else{
                                [cell refleshDataxianMu:_xiangMuMingXiArrayCun[indexPath.row-1] whitshiFouXian:NO];
                            }
                            
                        }
                        
                        return cell;
                    }
                }else{
                    return nil;
                }
            }else if(indexPath.section == 3)
            {
                if ([self.zhuModel.is_builder boolValue] == YES && zhiJianZhanHe == YES) {
                    static NSString *myIdentifier = @"Cell2";
                    DetailZhiJianCell *cell = (DetailZhiJianCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailZhiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell refleshData:self.zhuModel.builder_info whitRow:indexPath.row];
                    return cell;
                }else{
                    return nil;
                }
            }else if(indexPath.section == 4)
            {
                if ([self.zhuModel.is_comment boolValue] == YES && pingJiaZhanHe == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        if (indexPath.row == 1) {
                            static NSString *myIdentifier = @"Cell1";
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
                            if (cell == nil)
                                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.backgroundColor = kRGBColor(227, 227, 227);
                            cell.textLabel.font = [UIFont systemFontOfSize:14];
                            cell.textLabel.textColor = kRGBColor(74, 74, 74);
                            cell.textLabel.text = @"追评";
                            return cell;
                        }else{
                            static NSString *myIdentifier = @"DetailPingJiaCell";
                            DetailPingJiaCell *cell = (DetailPingJiaCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                            if (cell == nil)
                                cell = [[DetailPingJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            if (indexPath.row == 0) {
                                [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"comm")];
                            }
                            if (indexPath.row == 2) {
                                [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm")];
                            }
                            
                            return cell;
                        }
                        
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        static NSString *myIdentifier = @"DetailPingJiaCell";
                        DetailPingJiaCell *cell = (DetailPingJiaCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                        if (cell == nil)
                            cell = [[DetailPingJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm")];
                        return cell;
                    }else{
                        return nil;
                    }
                }else{
                    return nil;
                }
            }
            return nil;
        }else{
            if (indexPath.section == 1 && shiGongZhanHe == YES) {
                if (indexPath.row == 0 || indexPath.row == _xiangMuMingXiArrayCun.count+2) {
                    static NSString *myIdentifier = @"DetailShiGongHeaderCell";
                    DetailShiGongHeaderCell *cell = (DetailShiGongHeaderCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailShiGongHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (indexPath.row == 0) {
                        cell.zuoLabel.text = [NSString stringWithFormat:@"项目明细(%ld)",_xiangMuMingXiArrayCun.count];
                        
                        cell.youLabel.attributedText = [self jisuanXiangMuZongE];
                    }
                    if (indexPath.row == _xiangMuMingXiArrayCun.count+2) {
                        cell.zuoLabel.text = [NSString stringWithFormat:@"配件明细(%ld)",_peiJianMingXiArrayCun.count];
                        cell.youLabel.attributedText = [self jisuanPeiJianZongE];
                    }
                    return cell;
                }else{
                    static NSString *myIdentifier = @"DetailShiGongCell";
                    DetailShiGongCell *cell = (DetailShiGongCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailShiGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if ((indexPath.row >=_xiangMuMingXiArrayCun.count+2)&&(_xiangMuMingXiArrayCun.count+2+_peiJianMingXiArrayCun.count)) {
                        if (indexPath.row == _xiangMuMingXiArrayCun.count+1+_peiJianMingXiArrayCun.count) {
                            [cell refleshData:_peiJianMingXiArrayCun[indexPath.row-2-_xiangMuMingXiArrayCun.count] whitshiFouXian:YES];
                        }else{
                            [cell refleshData:_peiJianMingXiArrayCun[indexPath.row-2-_xiangMuMingXiArrayCun.count] whitshiFouXian:NO];
                        }
                        
                        
                    }else{
                        if (indexPath.row == _xiangMuMingXiArrayCun.count) {
                            [cell refleshDataxianMu:_xiangMuMingXiArrayCun[indexPath.row-1] whitshiFouXian:YES];
                        }else{
                            [cell refleshDataxianMu:_xiangMuMingXiArrayCun[indexPath.row-1] whitshiFouXian:NO];
                        }
                        
                    }
                    
                    return cell;
                }
            }else if(indexPath.section == 2 && zhiJianZhanHe == YES)
            {
                if ([self.zhuModel.is_builder boolValue] == YES) {
                    static NSString *myIdentifier = @"Cell2";
                    DetailZhiJianCell *cell = (DetailZhiJianCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailZhiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell refleshData:self.zhuModel.builder_info whitRow:indexPath.row];
                    return cell;
                }else{
                    return nil;
                }
            }else if(indexPath.section == 3 && pingJiaZhanHe == YES)
            {
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        if (indexPath.row == 0) {
                            static NSString *myIdentifier = @"DetailPingJiaCell";
                            DetailPingJiaCell *cell = (DetailPingJiaCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                            if (cell == nil)
                                cell = [[DetailPingJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"comm")];
                            return cell;
                            
                        }else if(indexPath.row ==1){
                            static NSString *myIdentifier = @"Cell1";
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
                            if (cell == nil)
                                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.backgroundColor = kRGBColor(227, 227, 227);
                            cell.textLabel.font = [UIFont systemFontOfSize:14];
                            cell.textLabel.textColor = kRGBColor(74, 74, 74);
                            cell.textLabel.text = @"追评";
                            return cell;
                        }else{
                            static NSString *myIdentifier = @"DetailPingJiaCell";
                            DetailPingJiaCell *cell = (DetailPingJiaCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                            if (cell == nil)
                                cell = [[DetailPingJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm")];
                            return cell;
                        }
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        static NSString *myIdentifier = @"DetailPingJiaCell";
                        DetailPingJiaCell *cell = (DetailPingJiaCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                        if (cell == nil)
                            cell = [[DetailPingJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        [cell refleshData:KISDictionaryHaveKey(self.zhuModel.comment, @"comm")];
                        return cell;
                    }else{
                        return nil;
                    }
                }else{
                    return nil;
                }
            }
            return nil;
        }
    }else{
        if (indexPath.section == 0) {
            if (shiGongZhanHe == YES) {
                NSUInteger puanDuan = 0;
                if ([self.zhuModel.service_info isKindOfClass:[NSDictionary class]]) {
                    puanDuan = 2;
                }
                
                
                if (indexPath.row == 0) {
                    static NSString *myIdentifier = @"DetailShiGongHeaderCell";
                    DetailShiGongHeaderCell *cell = (DetailShiGongHeaderCell*)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailShiGongHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    if (indexPath.row == 0) {
                        cell.zuoLabel.text = @"项目明细";
                        CGFloat jiaGe = [KISDictionaryHaveKey(self.zhuModel.service_info, @"service_fee") floatValue];
                        NSString *qudianStr = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jiaGe]];
                        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总价：%@",qudianStr]];
                        [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, qudianStr.length)];
                        cell.youLabel.attributedText = att;
                    }
                    
                    return cell;
                }else{
                    static NSString *myIdentifier = @"DetailShiGongCell";
                    DetailShiGongCell *cell = (DetailShiGongCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
                    if (cell == nil)
                        cell = [[DetailShiGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell refleshDataXiMei:self.zhuModel.service_info whitshiFouXian:YES];
                    
                    return cell;
                }
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
        if (self.chuanZhiModel.ait_switch == YES) {
            if (indexPath.section == 2) {
                if (indexPath.row == 0 || (indexPath.row == _xiangMuMingXiArrayCun.count +1)) {
                    return 23;
                }
                return 232/4;
            }else if(indexPath.section == 3)
            {
                return 307/6;
            }else if(indexPath.section == 4)
            {
                if ([self.zhuModel.is_comment boolValue] == YES && pingJiaZhanHe == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        if (indexPath.row == 0) {
                            CGFloat height = 0;
                            CGSize wordSize = CGSizeZero;
                            wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"content"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                            height = wordSize.height+20+70;
                            return height;
                        }else if(indexPath.row == 1)
                        {
                            return 23;
                        }else{
                            CGFloat height = 0;
                            CGSize wordSize = CGSizeZero;
                            wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"z_comm"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                            height = wordSize.height+20+70+30;
                            return height;
                        }
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        CGFloat height = 0;
                        CGSize wordSize = CGSizeZero;
                        wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"content"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                        height = wordSize.height+20+70;
                        return height;
                    }else{
                        return 0;
                    }
                }else{
                    return 0;
                }
            }
            return 0;
        }else{
            if (indexPath.section == 1) {
                if (indexPath.row == 0 || indexPath.row == _xiangMuMingXiArrayCun.count +1) {
                    return 23;
                }else{
                    return 232/4;
                }
            }else if(indexPath.section == 2)
            {
                return 307/6;
            }else if(indexPath.section == 3)
            {
                if ([self.zhuModel.is_comment boolValue] == YES && pingJiaZhanHe == YES) {
                    NSDictionary *comm = KISDictionaryHaveKey(self.zhuModel.comment, @"comm");
                    NSDictionary *z_comm = KISDictionaryHaveKey(self.zhuModel.comment, @"z_comm");
                    if ([comm isKindOfClass:[NSDictionary class]] && [z_comm isKindOfClass:[NSDictionary class]]) {
                        if (indexPath.row == 0) {
                            CGFloat height = 0;
                            CGSize wordSize = CGSizeZero;
                            wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"content"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                            height = wordSize.height+20+70;
                            return height;
                        }else if(indexPath.row == 1)
                        {
                            return 23;
                        }else{
                            CGFloat height = 0;
                            CGSize wordSize = CGSizeZero;
                            wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"z_comm"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                            height = wordSize.height+20+70+30;
                            return height;
                        }
                    }else if ([comm isKindOfClass:[NSDictionary class]] && (![z_comm isKindOfClass:[NSDictionary class]])){
                        CGFloat height = 0;
                        CGSize wordSize = CGSizeZero;
                        wordSize = DAJIANG_MULTILINE_TEXTSIZE(KISDictionaryHaveKey(comm, @"content"), DJSystemFont(14), CGSizeMake(kWindowW-20, 200));
                        height = wordSize.height+20+70;
                        return height;
                    }else{
                        return 0;
                    }
                }else{
                    return 0;
                }
            }
            return 0;
        }
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 23;
            }else{
                return 232/4;
            }
        }else{
            return 0;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *zhanShiIm = [[UIImageView alloc]init];
    zhanShiIm.contentMode =  UIViewContentModeScaleAspectFit;
    [headView addSubview:zhanShiIm];
    [zhanShiIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(headView);
        make.width.height.mas_equalTo(22);
    }];
    
    UILabel *zhanshiLabel = [[UILabel alloc]init];
    zhanshiLabel.font = [UIFont systemFontOfSize:16];
    zhanshiLabel.textColor = kRGBColor(102, 102, 102);
    [headView addSubview:zhanshiLabel];
    [zhanshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zhanShiIm.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(headView);
    }];
    
    UIImageView *jianTouIm = [[UIImageView alloc]init];
    jianTouIm.contentMode =  UIViewContentModeScaleAspectFit;
    [headView addSubview:jianTouIm];
    [jianTouIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(19);
        make.centerY.mas_equalTo(headView);
    }];
    
    UIButton *bt = [[UIButton alloc]init];
    [bt addTarget:self action:@selector(zhanHeChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setTitleColor:[UIColor clearColor] forState:(UIControlStateNormal)];
    [headView addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(10);
    }];
    
    if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
        if (self.chuanZhiModel.ait_switch == YES) {
            if (section == 0) {
                zhanShiIm.image = DJImageNamed(@"detail_jieChe");
                zhanshiLabel.text = @"接车信息";
                jianTouIm.image = DJImageNamed(@"back_btn-1");
                [bt setTitle:@"接车信息" forState:(UIControlStateNormal)];
            }else if(section == 1){
//                [zhanShiIm mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(headView.mas_centerY).mas_equalTo(-10);
//                }];
//                [zhanshiLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(headView.mas_centerY).mas_equalTo(-10);
//                }];
                
                zhanShiIm.image = DJImageNamed(@"detail_baoGao");
                zhanshiLabel.text = @"检测报告";
                [bt setTitle:@"检测报告" forState:(UIControlStateNormal)];
                
                
                
//                UILabel *aitLbal = [[UILabel alloc]init];
//                aitLbal.font = [UIFont systemFontOfSize:13];
//                [headView addSubview:aitLbal];
//                [aitLbal mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(10);
//                    make.top.mas_equalTo(zhanshiLabel.mas_bottom).mas_equalTo(5);
//                }];
//                NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.zhuModel.ait, @"massage")] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//                aitLbal.attributedText = attrString;
//                if ([KISDictionaryHaveKey(self.zhuModel.ait, @"num")integerValue]>0) {
//                    jianTouIm.hidden = YES;
//                    
//                    UILabel *chaKanLabel = [[UILabel alloc]init];
//                    chaKanLabel.font = [UIFont systemFontOfSize:16];
//                    chaKanLabel.textColor = kZhuTiColor;
//                    chaKanLabel.text = @"查看详情";
//                    [headView addSubview:chaKanLabel];
//                    [chaKanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.right.mas_equalTo(-10);
//                        make.centerY.mas_equalTo(headView);
//                    }];
//                    
//                }else{
//                    jianTouIm.hidden = NO;
//                    jianTouIm.image = DJImageNamed(@"back_btn-1");
//                }
                
                jianTouIm.hidden = NO;
                jianTouIm.image = DJImageNamed(@"back_btn-1");
            }else if(section == 2){
                zhanShiIm.image = DJImageNamed(@"detail_shiGong");
                zhanshiLabel.text = @"施工信息";
                UILabel *youHeaLabel = [[UILabel alloc]init];
                youHeaLabel.font = [UIFont systemFontOfSize:16];
                youHeaLabel.textColor = kRGBColor(102, 102, 102);
                youHeaLabel.attributedText = [self jisuanZongE];
                [headView addSubview:youHeaLabel];
                [youHeaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-40);
                    make.centerY.mas_equalTo(headView);
                }];
                
                [bt setTitle:@"施工信息" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                if (shiGongZhanHe == YES) {
                    [UIView animateWithDuration:0.2 animations:^{
                        jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                    } completion:^(BOOL finished) {
                    }];
                }
            }else if(section == 3){
                if ([self.zhuModel.is_builder boolValue] == YES) {
                    zhanShiIm.image = DJImageNamed(@"detail_zhiJian");
                    zhanshiLabel.text = @"车辆质检单";
                    [bt setTitle:@"车辆质检单" forState:(UIControlStateNormal)];
                    jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                    if (zhiJianZhanHe == YES) {
                        [UIView animateWithDuration:0.2 animations:^{
                            jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                        } completion:^(BOOL finished) {
                        }];
                    }
                }else{
                    zhanShiIm.image = DJImageNamed(@"detail_zhiJian_hui");
                    zhanshiLabel.text = @"车辆质检单";
                    zhanshiLabel.textColor = kRGBColor(155, 155, 155);
                    jianTouIm.hidden = YES;
                }
            }else if(section == 4){
                zhanShiIm.image = DJImageNamed(@"detail_pingJIa");
                zhanshiLabel.text = @"评价";
                [bt setTitle:@"评价" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                line.hidden = YES;
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    zhanShiIm.image = DJImageNamed(@"detail_pingJIa");
                    if (pingJiaZhanHe == YES) {
                        [UIView animateWithDuration:0.2 animations:^{
                            jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                        } completion:^(BOOL finished) {
                        }];
                    }
                }else{
                    zhanShiIm.image = DJImageNamed(@"detail_pingJIa_hui");
                    zhanshiLabel.textColor = kRGBColor(155, 155, 155);
                    jianTouIm.hidden = YES;
                }
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    NSInteger stars = [KISDictionaryHaveKey(self.zhuModel.comment, @"stars") integerValue];
                    for (int i= 0; i<5; i++) {
                        UIImageView *im = [[UIImageView alloc]init];
                        [headView addSubview:im];
                        [im mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-(39+(15+8)*i));
                            make.centerY.mas_equalTo(headView);
                            make.width.height.mas_equalTo(15);
                        }];
                        if (stars == 0) {
                            im.image = DJImageNamed(@"detail_xing");
                        }else if (stars == 1)
                        {
                            if (i==4) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 2)
                        {
                            if (i==4||i==3) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 3)
                        {
                            if (i==4||i==3 ||i==2 ) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 4)
                        {
                            if (i==4||i==3 ||i==2 ||i==1) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else{
                            im.image = DJImageNamed(@"detail_xing_select");
                        }
                    }
                }
            }
        }else{
            if (section == 0) {
                zhanShiIm.image = DJImageNamed(@"detail_jieChe");
                zhanshiLabel.text = @"接车信息";
                [bt setTitle:@"接车信息" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"back_btn-1");
            }else if(section == 1){
                zhanShiIm.image = DJImageNamed(@"detail_shiGong");
                zhanshiLabel.text = @"施工信息";
                UILabel *youHeaLabel = [[UILabel alloc]init];
                youHeaLabel.font = [UIFont systemFontOfSize:16];
                youHeaLabel.textColor = kRGBColor(102, 102, 102);
                youHeaLabel.attributedText = [self jisuanZongE];
                [headView addSubview:youHeaLabel];
                [youHeaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-40);
                    make.centerY.mas_equalTo(headView);
                }];
                [bt setTitle:@"施工信息" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                if (shiGongZhanHe == YES) {
                    [UIView animateWithDuration:0.2 animations:^{
                        jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                    } completion:^(BOOL finished) {
                    }];
                }
            }else if(section == 2){
                if ([self.zhuModel.is_builder boolValue] == YES) {
                    zhanShiIm.image = DJImageNamed(@"detail_zhiJian");
                    zhanshiLabel.text = @"车辆质检单";
                    [bt setTitle:@"车辆质检单" forState:(UIControlStateNormal)];
                    jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                    if (zhiJianZhanHe == YES) {
                        [UIView animateWithDuration:0.2 animations:^{
                            jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                        } completion:^(BOOL finished) {
                        }];
                    }
                }else{
                    zhanShiIm.image = DJImageNamed(@"detail_zhiJian_hui");
                    zhanshiLabel.text = @"车辆质检单";
                    zhanshiLabel.textColor = kRGBColor(155, 155, 155);
                    jianTouIm.hidden = YES;
                }
            }else if(section == 3){
                zhanShiIm.image = DJImageNamed(@"detail_pingJIa");
                zhanshiLabel.text = @"评价";
                [bt setTitle:@"评价" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                line.hidden = YES;
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    zhanShiIm.image = DJImageNamed(@"detail_pingJIa");
                }else{
                    zhanShiIm.image = DJImageNamed(@"detail_pingJIa_hui");
                    zhanshiLabel.textColor = kRGBColor(155, 155, 155);
                    jianTouIm.hidden = YES;
                }
                
                if ([self.zhuModel.is_comment boolValue] == YES) {
                    NSInteger stars = [KISDictionaryHaveKey(self.zhuModel.comment, @"stars") integerValue];
                    for (int i= 0; i<5; i++) {
                        UIImageView *im = [[UIImageView alloc]init];
                        [headView addSubview:im];
                        [im mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-(39+(15+8)*i));
                            make.centerY.mas_equalTo(headView);
                            make.width.height.mas_equalTo(15);
                        }];
                        if (stars == 0) {
                            im.image = DJImageNamed(@"detail_xing");
                        }else if (stars == 1)
                        {
                            if (i==4) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 2)
                        {
                            if (i==4||i==3) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 3)
                        {
                            if (i==4||i==3 ||i==2 ) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else if (stars == 4)
                        {
                            if (i==4||i==3 ||i==2 ||i==1) {
                                im.image = DJImageNamed(@"detail_xing_select");
                            }else{
                                im.image = DJImageNamed(@"detail_xing");
                            }
                        }else{
                            im.image = DJImageNamed(@"detail_xing_select");
                        }
                    }
                    if (pingJiaZhanHe == YES) {
                        [UIView animateWithDuration:0.2 animations:^{
                            jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                        } completion:^(BOOL finished) {
                        }];
                    }
                }
//                ======
            }
        }
    }else{
        if (self.chuanZhiModel.ait_switch == YES) {
            if (section == 0) {
                zhanShiIm.image = DJImageNamed(@"detail_shiGong");
                zhanshiLabel.text = @"施工信息";
                [bt setTitle:@"施工信息" forState:(UIControlStateNormal)];
                jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
                if (shiGongZhanHe == YES) {
                    [UIView animateWithDuration:0.2 animations:^{
                        jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                    } completion:^(BOOL finished) {
                    }];
                }
            }else if(section == 2){
                [zhanShiIm mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(headView.mas_centerY).mas_equalTo(-10);
                }];
                [zhanshiLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(headView.mas_centerY).mas_equalTo(-10);
                }];
                zhanShiIm.image = DJImageNamed(@"detail_baoGao");
                zhanshiLabel.text = @"检测报告";
                [bt setTitle:@"检测报告" forState:(UIControlStateNormal)];
                
                
                UILabel *aitLbal = [[UILabel alloc]init];
                aitLbal.font = [UIFont systemFontOfSize:13];
                [headView addSubview:aitLbal];
                [aitLbal mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.top.mas_equalTo(zhanshiLabel.mas_bottom).mas_equalTo(5);
                }];
                NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.zhuModel.ait, @"massage")] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                aitLbal.attributedText = attrString;
                if ([KISDictionaryHaveKey(self.zhuModel.ait, @"num")integerValue]>0) {
                    jianTouIm.hidden = YES;
                    
                    UILabel *chaKanLabel = [[UILabel alloc]init];
                    chaKanLabel.font = [UIFont systemFontOfSize:16];
                    chaKanLabel.textColor = kZhuTiColor;
                    chaKanLabel.text = @"查看详情";
                    [headView addSubview:chaKanLabel];
                    [chaKanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-10);
                        make.centerY.mas_equalTo(headView);
                    }];
                    
                }else{
                    jianTouIm.hidden = NO;
                    jianTouIm.image = DJImageNamed(@"back_btn-1");
                }
                line.hidden = YES;
            }
        }else{
            zhanShiIm.image = DJImageNamed(@"detail_shiGong");
            zhanshiLabel.text = @"施工信息";
            [bt setTitle:@"施工信息" forState:(UIControlStateNormal)];
            jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
            line.hidden = YES;
            if (shiGongZhanHe == YES) {
                [UIView animateWithDuration:0.2 animations:^{
                    jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
                } completion:^(BOOL finished) {
                }];
            }
        }
    }
    [headView bringSubviewToFront:bt];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        if ([self.chuanZhiModel.class_name isEqualToString:@"维修"]) {
            
            return 109/2;
        }else{
            if (self.chuanZhiModel.ait_switch == YES) {
                return 109/2;
            }else{
                return 109/2;
            }
        }
}

-(void)zhanHeChick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"接车信息"]) {
        CarInformationViewController *vc = [[CarInformationViewController alloc]init];
        vc.ordercode = self.chuanZhiModel.ordercode;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"检测报告"]) {
        if ([KISDictionaryHaveKey(self.zhuModel.ait, @"num")integerValue]>0) {
            
            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
            [mDict setObject:self.chuanZhiModel.ordercode forKey:@"ordercode"];
            kWeakSelf(weakSelf)
            [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_report" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                
                if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
                    AITHTMLViewController *vc = [[AITHTMLViewController alloc]init];
                    NSArray* dataDic = kParseData(responseObject);
                    if (![dataDic isKindOfClass:[NSArray class]]) {
                        return;
                    }
                    vc.chuanZhiArray = dataDic;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else
                {
                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                }
                
            } failure:^(id error) {
                
            }];
            
        }else{
            AITProductInformationVC *vc = [[AITProductInformationVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"施工信息"]) {
        shiGongZhanHe =!shiGongZhanHe;
        [self.mainTableView reloadData];
    }
    if ([sender.titleLabel.text isEqualToString:@"车辆质检单"]) {
        zhiJianZhanHe =!zhiJianZhanHe;
        [self.mainTableView reloadData];
    }
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        pingJiaZhanHe =!pingJiaZhanHe;
        [self.mainTableView reloadData];
    }
}

#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NPrintLog(@"notification上不去%@",notification);
    //    NSDictionary * userInfo2 = (NSDictionary *)notification;
    //    userInfo2 = [notification userInfo];
    NSDictionary * userInfo = [notification userInfo];
    NPrintLog(@"%@",userInfo);
    
    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
    
    if (![extras isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([KISDictionaryHaveKey(extras, @"is_ait") boolValue] == YES) {
        if ([self.chuanZhiModel.ordercode isEqualToString:KISDictionaryHaveKey(extras, @"ordercode")]) {
            UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
            artView.tag = 200;
            [artView show];
            self.tiaoZhuanordercode = KISDictionaryHaveKey(extras, @"ordercode");
        }
    }
    
}

@end
