//
//  StoreBottomView.m
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreBottomView.h"
#import "StorePeiJianCell.h"

@implementation StoreBottomView
-(instancetype)initWithFrame:(CGRect)frame withTaberHei:(CGFloat)taberHei
{
    if(self == [super initWithFrame:frame])
    {
        _taberHei = taberHei;
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0);
        mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 160)];
        [self addSubview:mainView];
        
        dianJiShouQibt = [[UIButton alloc]init];
        dianJiShouQibt.backgroundColor = [UIColor redColor];
        [dianJiShouQibt addTarget:self action:@selector(dianJiShouQibtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [mainView addSubview:dianJiShouQibt];
        [dianJiShouQibt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(0);
            make.width.height.mas_equalTo(50);
        }];
        self.mainTable = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        self.mainTable.backgroundColor = [UIColor whiteColor];
        self.mainTable.delegate = self;
        self.mainTable.dataSource = self;
        [mainView addSubview:self.mainTable];
        [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(50);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [mainView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(50);
        }];
    }
    return self;
}
-(NSMutableArray *)listModelArray
{
    if (!_listModelArray) {
        _listModelArray = [[NSMutableArray alloc]init];
    }
    return _listModelArray;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"Identifier";
    StorePeiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[StorePeiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    listPeiJianModel * model = self.listModelArray[indexPath.row];
    [cell refleshData:model dieIndex:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 74/2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listModelArray.count;;
    
    
}
-(void)shouqiAnniuClick:(UIButton*)sender
{
    
}

-(void)dianJiShouQibtChick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [self show];
    }else{
        [self dismiss];
    }
}


//弹入视图
- (void)show
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0,0, kWindowW, kWindowH - _taberHei);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        mainView.frame = CGRectMake(0, self.frame.size.height - 320, kWindowW, 320);
    }];
}

//弹出视图
- (void)dismiss
{
    self.backgroundColor = kColorWithRGB(0, 0, 0, 0);
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, kWindowH - _taberHei -160, kWindowW, 160);
//        NSInteger xianHei = 320;
//        if (xianHei>160) {
//            xianHei = xianHei- mainView.frame.origin.y;
//        }else{
//            xianHei = 160;
//        }
        mainView.frame = CGRectMake(0, 0, kWindowW, 160);
    }];
}
@end
