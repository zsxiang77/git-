//
//  CustomerInformationYYueView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CustomerInformationYYueView.h"

@implementation CustomerInformationYYueView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.4);
        
        self.mainView = [[UIView alloc]init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self.mainView.layer setMasksToBounds:YES];
        [self.mainView.layer setCornerRadius:10];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(916/2);
        }];
        
        
        UIButton *queDingBt = [[UIButton alloc]init];
        queDingBt.titleLabel.font = [UIFont systemFontOfSize:17];
        [queDingBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
        [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.mainView addSubview:queDingBt];
        [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.mainView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(queDingBt.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *shangView = [[UIView alloc]init];
        [self.mainView addSubview:shangView];
        [shangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        UILabel*lines=[[UILabel alloc]init];
        lines.backgroundColor=kLineBgColor;
        [shangView addSubview:lines];
        [lines mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(39);
            make.height.mas_equalTo(0.5);
        }];
        
        
        lableJect=[[UILabel alloc]init];
        lableJect.textColor=kRGBColor(74, 74, 74);
        lableJect.font=[UIFont systemFontOfSize:13];
        [shangView addSubview:lableJect];
        [lableJect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(shangView);
        }];
        
        lableTime=[[UILabel alloc]init];
        lableTime.textColor=kRGBColor(74, 74, 74);
        lableTime.font=[UIFont systemFontOfSize:13];
        [shangView addSubview:lableTime];
        [lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lableJect.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(shangView);
        }];
        
        lableShengTime=[[UILabel alloc]init];
        lableShengTime.textColor=kRGBColor(74, 144, 266);
        
        lableShengTime.font=[UIFont systemFontOfSize:12];
        [shangView addSubview:lableShengTime];
        [lableShengTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(shangView);
        }];
        
       
        
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mainView addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(shangView.mas_bottom);
            make.bottom.mas_equalTo(line.mas_top);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(disMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}
-(void)queDingBtChick:(UIButton *)sender
{
    [self disMissView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            return self.mainModel.subject.count;
        }else{
            return 0;
        }

    }else if (section == 1) {
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            return self.mainModel.parts.count;
        }else{
            return 0;
        }
    }else{
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            return 1;
        }else{
            return 0;
        }
    }
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0){
        static NSString *myIdentifier = @"Cell1";
        CustomerInformationYYueCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[CustomerInformationYYueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell shuxinCellXiangMu:self.mainModel.subject[indexPath.row]];
        return cell;
    }else
    if(indexPath.section==1){
        static NSString *myIdentifier = @"Cell2";
        CustomerInformationYYueCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[CustomerInformationYYueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell shuxinCellPeiJian:self.mainModel.parts[indexPath.row]];
        return cell;
        
    }else
    {
        static NSString *myIdentifier = @"Cell3";
        CustomerInformationYYueCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[CustomerInformationYYueCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        return cell;
    }
    
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
};

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 38*self.mainModel.info.count;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headreV = [[UIView alloc]init];
    
    UIImageView*img=[[UIImageView alloc]init];
    [headreV addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(7);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    UILabel*lable1=[[UILabel alloc]init];
    lable1.textColor=kColorWithRGB(74,74,74,1);
    [headreV addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(img);
    }];
    
    UILabel*lable2=[[UILabel alloc]init];
    lable2.textColor=kColorWithRGB(255,0,31,1);
    [headreV addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(img);
    }];
    
    
    if (section == 0) {
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            lable1.text= [NSString stringWithFormat:@"项目 (%ld)",self.mainModel.subject.count];;
            lable2.text= [NSString stringWithFormat:@"¥ %@",[CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.f",[self jiSuanSubjectOrParts:YES]]]];
            img.image = DJImageNamed(@"ic_sa_info_project");
        }
    }else if (section == 1) {
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            lable1.text= [NSString stringWithFormat:@"配件 (%ld)",self.mainModel.parts.count];;
            lable2.text= [NSString stringWithFormat:@"¥ %@",[CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.f",[self jiSuanSubjectOrParts:NO]]]];
            img.image = DJImageNamed(@"ic_sa_info_parts");
        }
    }else{
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            lable1.text= [NSString stringWithFormat:@"故障描述 (%ld)",self.mainModel.info.count];;
            lable2.text= @"";
            img.image = DJImageNamed(@"故障描述");
        }
    }

    return headreV;
}

-(CGFloat)jiSuanSubjectOrParts:(BOOL)Subject
{
    CGFloat jiE = 0;
    
    
    if(Subject){
        for (int i = 0; i<self.mainModel.subject.count; i++) {
            OrderDetailSubjectsModel *model = self.mainModel.subject[i];
            
            jiE += [model.reality_fee floatValue];
        }
    }else{
        for (int i = 0; i<self.mainModel.parts.count; i++) {
            OrderDetailPartsModel *model = self.mainModel.parts[i];
            jiE += [model.parts_fee floatValue];
        }
    }
    
    return  jiE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}


-(void)shouView
{
    self.hidden = NO;
}
-(void)disMissView
{
    self.hidden = YES;
}


-(void)shuaXinDaTaShuJu{
    [self.mainTableView reloadData];
    lableShengTime.text=[NSString stringWithFormat:@"还剩%@天到期",self.mainModel.end_days];
    if([self.mainModel.status integerValue] == 8){
        lableJect.text=@"预约到店时间:";
        lableTime.text=self.mainModel.appointment;
    }else{
        lableJect.text=@"询价时间:";
        lableTime.text=self.mainModel.create_time;
    }
}

@end
