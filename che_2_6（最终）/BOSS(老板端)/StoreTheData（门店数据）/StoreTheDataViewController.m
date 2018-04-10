//
//  StoreTheDataViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataViewController.h"
#import "MJRefresh.h"
#import<WebKit/WebKit.h>

@interface StoreTheDataViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UILabel * lineLable;
    CGFloat widths;
}

@end

@implementation StoreTheDataViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"门店数据"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"门店数据"];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * shangview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 64)];
    [self.view addSubview:shangview];
    widths = kWindowW/4;
    lineLable = [[UILabel alloc]init];
    lineLable.backgroundColor = kRGBColor(74, 144, 266);
    lineLable.hidden = YES;
    lineLable.frame = CGRectMake(widths/4, 61, widths/2, 2);
    [shangview addSubview:lineLable];
    [self renWuTableView];
    [self renYuanTableView];
    [self peiJianTableView];
    [self shouRuTableView];
    
    
    for (int i=0; i<4; i++) {
        UIButton  *btn =[[UIButton alloc]init];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag=200+i;
        [self.view addSubview:btn];
       
        btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
       // btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0,3);
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
        if(i==0){
            btn.frame=CGRectMake(0, 20, widths, 40);
            [btn setTitle:@"任务" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"renWu2"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [btn setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
               lineLable.hidden=NO;
            _renWuTableView.hidden=NO;
        }else if(i==1){
            btn.frame=CGRectMake(widths, 20, widths, 40);
            [btn setTitle:@"人员" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"renYuan1"] forState:UIControlStateNormal];
        }else if(i==2){
            btn.frame=CGRectMake(widths*2, 20, widths, 40);
            [btn setTitle:@"配件" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"peiJian1"] forState:UIControlStateNormal];
        }else if(i==3){
            btn.frame=CGRectMake(widths*3, 20, widths, 40);
            [btn setTitle:@"收入" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"liRun1"] forState:UIControlStateNormal];
        }
    }
    UILabel * line=[[UILabel alloc]init];
    line.backgroundColor=kRGBColor(217, 217, 217);
    [shangview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
    }];
}
-(void)clickBtn:(UIButton*)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i = 0; i<4; i++) {
        UIButton *bt = [self.view viewWithTag:200+i];
        bt.titleLabel.font=[UIFont systemFontOfSize:15];
        [bt setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
        lineLable.hidden=YES;
        _renWuTableView.hidden=YES;
        _renYuanTableView.hidden=YES;
        _peiJianTableView.hidden=YES;
        _shouRuTableView.hidden=YES;
         bt.selected = NO;
        if(i==0){
            [bt setImage:[UIImage imageNamed:@"renWu1"] forState:UIControlStateNormal];
        }else if(i==1){
            [bt setImage:[UIImage imageNamed:@"renYuan1"] forState:UIControlStateNormal];
        }else if(i==2){
            [bt setImage:[UIImage imageNamed:@"peiJian1"] forState:UIControlStateNormal];
        }else if(i==3){
            [bt setImage:[UIImage imageNamed:@"liRun1"] forState:UIControlStateNormal];
        }
    }
        if(sender.tag==200){
            lineLable.hidden=NO;
            sender.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [sender setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:@"renWu2"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                 lineLable.frame = CGRectMake(widths/4, 61, widths/2, 2);
            }];
            _renWuTableView.hidden=NO;
            
        }else if(sender.tag==201){
            lineLable.hidden=NO;
            sender.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [sender setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:@"renYuan2"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                lineLable.frame = CGRectMake(widths/4+widths, 61, widths/2, 2);
            }];
            _renYuanTableView.hidden=NO;
           
        }else if(sender.tag==202){
            lineLable.hidden=NO;
            sender.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [sender setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:@"peiJian2"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                lineLable.frame = CGRectMake(widths/4+widths*2, 61, widths/2, 2);
            }];
            _peiJianTableView.hidden=NO;
            
        }else if(sender.tag==203){
            lineLable.hidden=NO;
            sender.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [sender setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
              [sender setImage:[UIImage imageNamed:@"liRun2"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                lineLable.frame = CGRectMake(widths/4+widths*3, 61, widths/2, 2);
            }];
            _shouRuTableView.hidden=NO;
        }
}
#pragma mark - 任务代理
-(UITableView*)renWuTableView
{
    if(!_renWuTableView){
        //任务
       _renWuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWindowW, kWindowH-64) style:(UITableViewStyleGrouped)];
       _renWuTableView.dataSource=self;
       _renWuTableView.delegate=self;
       _renWuTableView.hidden=YES;
        [self.view addSubview:_renWuTableView];
    }
    return _renWuTableView;
}
#pragma mark - 人员代理
-(UITableView*)renYuanTableView
{
    if(!_renYuanTableView){
        //任务
        _renYuanTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWindowW, kWindowH-64) style:(UITableViewStyleGrouped)];
        _renYuanTableView.dataSource=self;
        _renYuanTableView.delegate=self;
        _renYuanTableView.hidden=YES;
        [self.view addSubview:_renYuanTableView];
    }
    return _renYuanTableView;
}
#pragma mark - 配件代理
-(UITableView*)peiJianTableView
{
    if(!_peiJianTableView){
        //任务
        _peiJianTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWindowW, kWindowH-64) style:(UITableViewStyleGrouped)];
        _peiJianTableView.dataSource=self;
        _peiJianTableView.delegate=self;
        _peiJianTableView.hidden=YES;
        [self.view addSubview:_peiJianTableView];
    }
    return _peiJianTableView;
}
#pragma mark - 收入代理
-(UITableView*)shouRuTableView
{
    if(!_shouRuTableView){
        //任务
        _shouRuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWindowW, kWindowH-64) style:(UITableViewStyleGrouped)];
        _shouRuTableView.dataSource=self;
        _shouRuTableView.delegate=self;
        _shouRuTableView.hidden=YES;
        [self.view addSubview:_shouRuTableView];
    }
    return _shouRuTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.renWuTableView){
           return 56;
    }else if(tableView==self.renYuanTableView){
        return 30;
    }else if(tableView==self.peiJianTableView){
        return 150;
    }else{
        return 90;
    }
};
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text=@"hfhjahfjh";
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==self.renWuTableView){
        UIView * view=[[UIView alloc]init];
        view.backgroundColor=[UIColor greenColor];
        return view;
    }else if(tableView==self.renYuanTableView){
        UIView * view=[[UIView alloc]init];
        view.backgroundColor=[UIColor purpleColor];
        return view;
    }else if(tableView==self.peiJianTableView){
        UIView * view=[[UIView alloc]init];
        view.backgroundColor=[UIColor redColor];
        return view;
    }else{
        UIView * view=[[UIView alloc]init];
        view.backgroundColor=[UIColor blueColor];
        return view;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(tableView==self.renWuTableView){
        return 403;
    }else if(tableView==self.renYuanTableView){
        return 403;
    }else if(tableView==self.peiJianTableView){
        return 403;
    }else{
        return 403;
    }
}
@end
