//
//  ProjecAddProjectView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ProjecAddProjectView.h"
#import "ProjectDetailsADDErCell.h"
#import "ProjectDetailsADDSanVC.h"
@implementation ProjecAddProjectView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
       self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        xuanView = [[UIView alloc]init];
        xuanView.backgroundColor = [UIColor whiteColor];
        self.mainClass = @"";
        [xuanView.layer setMasksToBounds:YES];
        [xuanView.layer setCornerRadius:3];
        [self addSubview:xuanView];
        [xuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.mainArrary = [[NSMutableArray alloc]init];
        UIButton *fanHuiBt = [[UIButton alloc]init];
        fanHuiBt.imageView.contentMode = UIViewContentModeScaleAspectFit;
        fanHuiBt.imageEdgeInsets = UIEdgeInsetsMake(7, 3, 7, -3);
        fanHuiBt.titleLabel.font = [UIFont systemFontOfSize:12];
        [fanHuiBt addTarget:self action:@selector(fanHuiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [fanHuiBt setImage:DJImageNamed(@"ic_sa_blue_arrows") forState:(UIControlStateNormal)];
        [fanHuiBt setTitle:@"返回" forState:(UIControlStateNormal)];
        [fanHuiBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        [xuanView addSubview:fanHuiBt];
        [fanHuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(30);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        UIButton *bt = [[UIButton alloc]init];
        [bt addTarget:self action:@selector(queDingChick:) forControlEvents:(UIControlEventTouchUpInside)];
        bt.backgroundColor = kZhuTiColor;
        [bt setTitle:@"确定" forState:(UIControlStateNormal)];
        [bt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [xuanView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];

        self.main_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.main_tableView.delegate = self;
        self.main_tableView.dataSource = self;
        [xuanView addSubview:self.main_tableView];
        [self.main_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(bt.mas_top).mas_equalTo(0);
            make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(10);
        }];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(vietualViewTouch)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if ([touch.view isDescendantOfView:xuanView]) {
        return NO;
    }
    return YES;
}

-(void)queDingChick:(UIButton *)sender
{
    [self.xuanZhongFanHuiArray removeAllObjects];
    for (int i = 0; i<self.mainArrary.count; i++) {
        ProjecAddProjectSanModel *mode = self.mainArrary[i];
        NSMutableDictionary *dict = mode.zhuDict;
        if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"1"]) {
            [self.xuanZhongFanHuiArray addObject:mode];
        }
    }
    self.xuanZhongQueDingBlock(self.xuanZhongFanHuiArray);
}
-(void)fanHuiBtChick:(UIButton *)sender
{
    self.hidden = YES;
}
-(void)vietualViewTouch
{
    self.hidden = YES;
}
-(void)showView
{
    self.hidden = NO;
    if (!self.xuanZhongFanHuiArray) {
        self.xuanZhongFanHuiArray = [[NSMutableArray alloc]init];
    }
    [self.xuanZhongFanHuiArray removeAllObjects];
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"Cell";
    ProjectDetailsADDErCell *cell = (ProjectDetailsADDErCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[ProjectDetailsADDErCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    ProjecAddProjectSanModel *mode = self.mainArrary[indexPath.row];
    NSMutableDictionary *dict = mode.zhuDict;
    NSDictionary *model = KISDictionaryHaveKey(dict, @"data");
    
    cell.model = model;
    if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"0"]) {
        cell.zuoImageView.image = DJImageNamed(@"rect_check_box_unselect");
    }else{
        cell.zuoImageView.image = DJImageNamed(@"rect_check_box_selected");
    }
    
    if ([KISDictionaryHaveKey(model, @"have_next") integerValue] == 1) {
        cell.mainLabel.text = [NSString stringWithFormat:@"%@(共%@个小项目)",KISDictionaryHaveKey(model, @"name"),KISDictionaryHaveKey(model, @"next_num")];
        cell.sanJiBt.hidden = NO;
        //kWeakSelf(weakSelf)
        cell.tiaoZhanSanJiBlock = ^(NSDictionary *dict) {
      //[weakSelf huoQuSanChangYongWithDict:dict withShiFouTiaoZhuan:YES withXiuGaiDict:nil];
            NPrintLog(@"共识");
        };
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else
    {
        cell.mainLabel.text = KISDictionaryHaveKey(model, @"name");
        cell.sanJiBt.hidden = YES;
        cell.gongshiLable.text = [NSString stringWithFormat:@"工时:%@",KISDictionaryHaveKey(model, @"hour")];
        cell.gongshifeiLable.text = [NSString stringWithFormat:@"工时费:%@",KISDictionaryHaveKey(model, @"fee")];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainArrary.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * viewHeader = [[UIView alloc]init];
    UILabel * lable =[[UILabel alloc]init];
    lable.text = self.mainClass;
    lable.font = [UIFont boldSystemFontOfSize:15];
    viewHeader.backgroundColor = kRGBColor(255, 255, 255);
    [lable setTextColor:kRGBColor(74, 74, 74)];
    [viewHeader addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(viewHeader);
    }];
    return viewHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjecAddProjectSanModel *mode = self.mainArrary[indexPath.row];
    NSMutableDictionary *dict = mode.zhuDict;
    if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"0"]) {
        [dict setObject:@"1" forKey:@"xuanZhong"];
        NSDictionary *model = KISDictionaryHaveKey(dict, @"data");
        if ([KISDictionaryHaveKey(model, @"have_next") integerValue] == 1) {
            if (mode.sanJiArra.count<=0) {
                [dict setObject:@"0" forKey:@"xuanZhong"];
                self.diSanJiArrayBlcok(dict, mode);
            }
        }
    }else{
        [dict setObject:@"0" forKey:@"xuanZhong"];
    }
    [self.main_tableView reloadData];
}
@end
