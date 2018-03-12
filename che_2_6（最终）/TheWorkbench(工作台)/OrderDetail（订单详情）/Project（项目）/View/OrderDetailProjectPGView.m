//
//  OrderDetailProjectPGView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectPGView.h"
#import "CheDianZhangCommon.h"
#import "OrderDetailProjectPGCell.h"

@implementation OrderDetailProjectPGView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.queDingArray = [[NSMutableArray alloc]init];
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.4);
        zhuView = [[UIView alloc]initWithFrame:CGRectMake(75, 0, kWindowW-75, kWindowH)];
        zhuView.backgroundColor = [UIColor whiteColor];
        zhuView.hidden = YES;
        [self addSubview:zhuView];
        
        zhuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kWindowW-75, kWindowH-100) style:UITableViewStyleGrouped];
        zhuTableView.backgroundColor = [UIColor clearColor];
        zhuTableView.delegate = self;
        zhuTableView.dataSource = self;
        zhuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [zhuView addSubview:zhuTableView];
        
        erJiView = [[UIView alloc]initWithFrame:CGRectMake(75, 0, kWindowW-75, kWindowH)];
        erJiView.backgroundColor = [UIColor whiteColor];
        erJiView.hidden = YES;
        [self addSubview:erJiView];
        
        UIButton *bt = [[UIButton alloc]init];
        [bt addTarget:self action:@selector(queDingChick:) forControlEvents:(UIControlEventTouchUpInside)];
        bt.backgroundColor = kZhuTiColor;
        [bt setTitle:@"确定" forState:(UIControlStateNormal)];
        [bt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [erJiView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        
        
        erJiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kWindowW-75, kWindowH-100-80) style:UITableViewStylePlain];
        erJiTableView.backgroundColor = [UIColor clearColor];
        erJiTableView.delegate = self;
        erJiTableView.dataSource = self;
        erJiTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [erJiView addSubview:erJiTableView];
        
        yiXuanLabel = [[UILabel alloc]init];
        yiXuanLabel.font = [UIFont systemFontOfSize:14];
        yiXuanLabel.textColor = kRGBColor(51, 51, 51);
        yiXuanLabel.text = [NSString stringWithFormat:@"已选 %ld",self.queDingArray.count];
        [erJiView addSubview:yiXuanLabel];
        [yiXuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-55);
        }];
        
        UIButton *fanHuiBt = [[UIButton alloc]init];
        fanHuiBt.imageView.contentMode = UIViewContentModeScaleAspectFit;
        fanHuiBt.imageEdgeInsets = UIEdgeInsetsMake(7, 3, 7, -3);
        fanHuiBt.titleLabel.font = [UIFont systemFontOfSize:12];
        [fanHuiBt addTarget:self action:@selector(fanHuiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [fanHuiBt setImage:DJImageNamed(@"ic_sa_blue_arrows") forState:(UIControlStateNormal)];
        [fanHuiBt setTitle:@"返回" forState:(UIControlStateNormal)];
        [fanHuiBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        [erJiView addSubview:fanHuiBt];
        [fanHuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(30);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(vietualViewTouch)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)fanHuiBtChick:(UIButton *)sender
{
    zhuView.hidden = NO;
    erJiView.hidden = YES;
    [zhuTableView reloadData];
}

-(void)vietualViewTouch
{
    self.hidden = YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if ([touch.view isDescendantOfView:zhuView]||[touch.view isDescendantOfView:erJiView]) {
        return NO;
    }
    return YES;
}

-(void)queDingChick:(UIButton *)sender
{
    self.queDingBlock();
}
-(void)zhuXianShi{
    zhuView.hidden = NO;
    erJiView.hidden = YES;
    [zhuTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.chuanZhiArray) {
        if (tableView == zhuTableView) {
            return self.chuanZhiArray.count;
        }else{
            if (self.xuanZhongArray) {
                return self.xuanZhongArray.count;
            }else{
                return 0;
            }
        }
    }else
    {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == zhuTableView) {
        static NSString *myIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiGongModel *model = self.chuanZhiArray[indexPath.row];
        cell.textLabel.text = model.type_name;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        static NSString *myIdentifier = @"Cell2";
        OrderDetailProjectPGCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailProjectPGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refeleseWithModel:self.xuanZhongArray[indexPath.row]];
        cell.accessoryType=UITableViewCellAccessoryNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headViw = [[UIView alloc]init];
    headViw.backgroundColor = [UIColor whiteColor];
    UILabel *la = [[UILabel alloc]init];
    la.font = [UIFont boldSystemFontOfSize:15];
    la.textColor = kRGBColor(74, 74, 74);
    [headViw addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(headViw);
    }];
    la.text = @"派工";
    return headViw;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == zhuTableView) {
        PaiGongModel *model = self.chuanZhiArray[indexPath.row];
        self.xuanZhongArray = model.staff;
        zhuView.hidden = YES;
        erJiView.hidden = NO;
        [erJiTableView reloadData];
    }else{
        if (self.queDingArray.count>=4) {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"最多选4人" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alt show];
            return;
        }
        PaiGongStaffModel *model = self.xuanZhongArray[indexPath.row];
        model.shiFouXuanZhong = !model.shiFouXuanZhong;
        [erJiTableView reloadData];
//        ====================
        [self.queDingArray removeAllObjects];
        for (int i = 0; i<self.chuanZhiArray.count; i++) {
            PaiGongModel *model2 = self.chuanZhiArray[i];
            NSArray *array = model2.staff;
            for (int h = 0; h<array.count; h++) {
                PaiGongStaffModel *modelNew = array[h];
                if (modelNew.shiFouXuanZhong == YES) {
                    [self.queDingArray addObject:modelNew];
                }
            }
        }
        yiXuanLabel.text = [NSString stringWithFormat:@"已选 %ld",self.queDingArray.count];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *fooV = [[UIView alloc]init];
    return fooV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

@end
