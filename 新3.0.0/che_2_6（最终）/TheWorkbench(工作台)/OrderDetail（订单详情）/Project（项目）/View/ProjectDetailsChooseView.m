//
//  ProjectDetailsChooseView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsChooseView.h"
#import "CheDianZhangCommon.h"

@implementation ProjectDetailsChooseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        fenLeiArray = @[@"车身部分",@"车身电器",@"发动机",@"悬挂系统",@"传动系统",@"转向系统",@"空调系统",@"烤漆美容",@"制动系统",@"整车保养",@"钣金",@"制动系统"];
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        UIView *xuanView = [[UIView alloc]init];
        xuanView.backgroundColor = [UIColor whiteColor];
        [xuanView.layer setMasksToBounds:YES];
        [xuanView.layer setCornerRadius:3];
        [self addSubview:xuanView];
        [xuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        UILabel *la = [[UILabel alloc]init];
        la.text = @"项目分类";
        [xuanView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
        
        self.main_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.main_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        self.main_tableView.delegate = self;
        self.main_tableView.dataSource = self;
        //self.main_tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [xuanView addSubview:self.main_tableView];
        [self.main_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.top.mas_equalTo(150);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(vietualViewTouch)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)vietualViewTouch
{
    self.hidden = YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if ([touch.view isDescendantOfView:self.main_tableView]) {
        return NO;
    }
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fenLeiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = fenLeiArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.fenLeiBlcok(fenLeiArray[indexPath.row]);
    
    self.hidden = YES;
    
}
@end
