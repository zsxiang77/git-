//
//  JobBoardHeaderView.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardHeaderView.h"
#import "CommonControlOrView.h"
#import "BOSSCheDianZhangCommon.h"
#define kTopButtonTag 2000

@interface JobBoardHeaderView()
{
    UIButton *selectBt1;
    UIButton *selectBt2;
    UIButton *selectBt3;
    
    UIImageView *selectMeunImageView;
    UIButton *selectBtMeun;
    
    UILabel *selectTitleLa1;
    UILabel *selectTitleLa2;
    UILabel *selectTitleLa3;
    
    UILabel *selectNumberLa1;
    UILabel *selectNumberLa2;
    UILabel *selectNumberLa3;
    
    UILabel *selectLineLa1;
    UILabel *selectLineLa2;
    UILabel *selectLineLa3;
    
    
    UIView *dingWeiViwenew;
    UIView *dingWeiViwe;
    UIView *dingWeiViweCenter;
    
    UIButton *quanBuBt;
    UIButton *jingJiBt;
    UIButton *zhongYaoBt;
}

@property(nonatomic,strong)UIView *mainView;


@end

@implementation JobBoardHeaderView
-(void)setTitleDiYiwithStr:(NSString *)set
{
    selectTitleLa1.text = set;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNoRecieveTouch = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *shangView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*320/750)];
        shangView.image = DJImageNamed(@"BOSS_JOP_header");
        [self addSubview:shangView];
        
        self.touImaage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 20, 32, 32)];
        [self.touImaage.layer setMasksToBounds:YES];
        [self.touImaage.layer setCornerRadius:32/2];
        self.touImaage.image = DJImageNamed(@"BOSS_tou");
        [self addSubview:self.touImaage];
        
        self.topTitleButton = [[UIButton alloc] initWithFrame:CGRectMake((kWindowW-190)/2.0-10, 20, 190, 34)];
        self.topTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.topTitleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.topTitleButton setTitle:@"未处理" forState:UIControlStateNormal];
        self.topTitleButton.tag = kTopButtonTag;
        [self addSubview:self.topTitleButton];
        UIImageView* iamge = [[UIImageView alloc] initWithFrame:CGRectMake(130, 12, 15, 11)];
        iamge.image = [UIImage imageNamed:@"sanjiao_down"];
        iamge.tag = 1;
        [self.topTitleButton addSubview:iamge];
        [self.topTitleButton addTarget:self action:@selector(playTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *toubt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [toubt addTarget:self action:@selector(toubtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:toubt];
        
        
        
        
        self.mainView = [[UIView alloc]init];
        [self.mainView.layer setCornerRadius:10];
        self.mainView.layer.shadowColor = [UIColor blueColor].CGColor;//shadowColor阴影颜色
        self.mainView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.mainView.layer.shadowOpacity = 0.5;
        self.mainView.layer.shadowRadius = 2;// 阴影扩散的范围控制
        self.mainView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self bringSubviewToFront:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(107);
        }];
        
        
        
        selectMeunImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"BOSS_CaiDan")];
        [self.mainView addSubview:selectMeunImageView];
        [selectMeunImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo((43-31)/2);
            make.width.height.mas_equalTo(31);
        }];
        selectBtMeun = [[UIButton alloc]init];
        [self addSubview:selectBtMeun];
        [selectBtMeun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.mainView);
            make.width.height.mas_equalTo(43);
        }];



        UILabel *line1 = [[UILabel alloc]init];
        line1.backgroundColor = kLineBgColor;
        [self.mainView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(43+((kWindowW-20-43)/3) *(1));
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(1);
        }];

        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [self.mainView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-(kWindowW-20-43)/3);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(1);
        }];



        dingWeiViwenew = [[UIView alloc]init];
        [self.mainView addSubview:dingWeiViwenew];
        [dingWeiViwenew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(line1.mas_left).mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];

        dingWeiViwe = [[UIView alloc]init];
        [self.mainView addSubview:dingWeiViwe];
        [dingWeiViwe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(line2.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];

        dingWeiViweCenter = [[UIView alloc]init];
        [self.mainView addSubview:dingWeiViweCenter];
        [dingWeiViweCenter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.left.mas_equalTo(line1.mas_left).mas_equalTo(0);
            make.right.mas_equalTo(line2.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];



        selectTitleLa1 = [[UILabel alloc]init];
        selectTitleLa1.text = @"全部任务";
        selectTitleLa1.adjustsFontSizeToFitWidth = YES;
        selectTitleLa1.font = [UIFont systemFontOfSize:17];
        selectTitleLa1.textColor = kZhuTiColor;
        [self.mainView addSubview:selectTitleLa1];
        [selectTitleLa1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.centerX.mas_equalTo(dingWeiViwenew.mas_centerX).mas_equalTo(10);
        }];

        selectTitleLa2 = [[UILabel alloc]init];
        selectTitleLa2.text = @"紧急";
        selectTitleLa2.font = [UIFont systemFontOfSize:17];
        [self.mainView addSubview:selectTitleLa2];
        [selectTitleLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.centerX.mas_equalTo(dingWeiViweCenter);
        }];



        selectTitleLa3 = [[UILabel alloc]init];
        selectTitleLa3.text = @"重要";
        selectTitleLa3.font = [UIFont systemFontOfSize:17];
        [self.mainView addSubview:selectTitleLa3];
        [selectTitleLa3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(selectBtMeun);
            make.centerX.mas_equalTo(dingWeiViwe);
        }];

        selectNumberLa3 = [[UILabel alloc]init];
        selectNumberLa3.font = [UIFont systemFontOfSize:40];
        selectNumberLa3.textColor = kRGBColor(74, 74, 74);
//        selectNumberLa3.text = @"44";
        [self.mainView addSubview:selectNumberLa3];
        [selectNumberLa3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(10);
            make.centerX.mas_equalTo(dingWeiViwe);
        }];

        selectNumberLa2 = [[UILabel alloc]init];
        selectNumberLa2.font = [UIFont systemFontOfSize:40];
//        selectNumberLa2.text = @"33";
        selectNumberLa2.textColor = kRGBColor(74, 74, 74);
        [self.mainView addSubview:selectNumberLa2];
        [selectNumberLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(10);
            make.centerX.mas_equalTo(dingWeiViweCenter);
        }];

        selectNumberLa1 = [[UILabel alloc]init];
        selectNumberLa1.font = [UIFont systemFontOfSize:40];
//        selectNumberLa1.text = @"22";
        selectNumberLa1.textColor = kZhuTiColor;
        [self.mainView addSubview:selectNumberLa1];
        [selectNumberLa1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(10);
            make.centerX.mas_equalTo(dingWeiViwenew);
        }];

        selectLineLa1 = [[UILabel alloc]init];
        selectLineLa1.backgroundColor = kZhuTiColor;
        [self.mainView addSubview:selectLineLa1];
        [selectLineLa1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(32);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(3);
            make.centerX.mas_equalTo(dingWeiViwenew);
        }];
        selectLineLa1.hidden = NO;

        selectLineLa2 = [[UILabel alloc]init];
        selectLineLa2.backgroundColor = kZhuTiColor;
        [self.mainView addSubview:selectLineLa2];
        [selectLineLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(32);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(3);
            make.centerX.mas_equalTo(dingWeiViweCenter);
        }];
        selectLineLa2.hidden = YES;

        selectLineLa3 = [[UILabel alloc]init];
        selectLineLa3.backgroundColor = kZhuTiColor;
        [self.mainView addSubview:selectLineLa3];
        [selectLineLa3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(32);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(3);
            make.centerX.mas_equalTo(dingWeiViwe);
        }];
        selectLineLa3.hidden = YES;


        self.xuanZhongIndex = 0;
        quanBuBt = [[UIButton alloc]init];
        [quanBuBt addTarget:self action:@selector(quanBuBtChick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:quanBuBt];
        [self bringSubviewToFront:quanBuBt];
        [quanBuBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(dingWeiViwenew);
            make.top.bottom.mas_equalTo(self.mainView);
        }];

        jingJiBt = [[UIButton alloc]init];
        [jingJiBt addTarget:self action:@selector(jingJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:jingJiBt];
        [self bringSubviewToFront:jingJiBt];
        [jingJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(dingWeiViweCenter);
            make.top.bottom.mas_equalTo(self.mainView);
        }];

        zhongYaoBt = [[UIButton alloc]init];
        [zhongYaoBt addTarget:self action:@selector(zhongYaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:zhongYaoBt];
        [self bringSubviewToFront:zhongYaoBt];
        [zhongYaoBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(dingWeiViwe);
            make.top.bottom.mas_equalTo(self.mainView);
        }];

        [selectBtMeun addTarget:self action:@selector(selectBtMeunChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self bringSubviewToFront:selectBtMeun];
    }
    return self;
}

-(void)quanBuBtChick:(UIButton *)sender
{
    
    
    if (sender.selected == YES) {
        return;
    }
    
    zhongYaoBt.selected = NO;
    jingJiBt.selected = NO;
    self.xuanZhongIndex = 0;
    sender.selected = !sender.selected;
    
    selectTitleLa1.textColor = kZhuTiColor;
    selectNumberLa1.textColor = kZhuTiColor;
    selectLineLa1.hidden = NO;
    
    selectTitleLa2.textColor = kRGBColor(74, 74, 74);
    selectNumberLa2.textColor = kRGBColor(74, 74, 74);
    selectLineLa2.hidden = YES;
    
    selectTitleLa3.textColor = kRGBColor(74, 74, 74);
    selectNumberLa3.textColor = kRGBColor(74, 74, 74);
    selectLineLa3.hidden = YES;
    
    
    self.zhongQieHUanBlock();
}
-(void)jingJiBtChick:(UIButton *)sender
{
    
    
    if (sender.selected == YES) {
        return;
    }
    
    zhongYaoBt.selected = NO;
    quanBuBt.selected = NO;
    self.xuanZhongIndex = 1;
    sender.selected = !sender.selected;
    
    selectTitleLa2.textColor = kZhuTiColor;
    selectNumberLa2.textColor = kZhuTiColor;
    selectLineLa2.hidden = NO;
    
    selectTitleLa1.textColor = kRGBColor(74, 74, 74);
    selectNumberLa1.textColor = kRGBColor(74, 74, 74);
    selectLineLa1.hidden = YES;
    
    selectTitleLa3.textColor = kRGBColor(74, 74, 74);
    selectNumberLa3.textColor = kRGBColor(74, 74, 74);
    selectLineLa3.hidden = YES;
    self.zhongQieHUanBlock();
    
}
-(void)zhongYaoBtChick:(UIButton *)sender
{
    
    
    if (sender.selected == YES) {
        return;
    }
    
    quanBuBt.selected = NO;
    jingJiBt.selected = NO;
    self.xuanZhongIndex = 2;
    sender.selected = !sender.selected;
    
    selectTitleLa3.textColor = kZhuTiColor;
    selectNumberLa3.textColor = kZhuTiColor;
    selectLineLa3.hidden = NO;
    
    selectTitleLa1.textColor = kRGBColor(74, 74, 74);
    selectNumberLa1.textColor = kRGBColor(74, 74, 74);
    selectLineLa1.hidden = YES;
    
    selectTitleLa2.textColor = kRGBColor(74, 74, 74);
    selectNumberLa2.textColor = kRGBColor(74, 74, 74);
    selectLineLa2.hidden = YES;
    self.zhongQieHUanBlock();
    
}
-(void)selectBtMeunChick:(UIButton *)sender
{
    self.selectBtMeunChickBlock();
}

-(void)playTypeClick:(UIButton *)sender
{
    self.playTypeClickBlock();
}

-(void)toubtChick:(UIButton *)sender
{
    self.touXiangDianJiBlock();
}



- (void)refreshAllData:(NSDictionary*)dic
{
    
}


- (void)startAnimation:(float)offy
{
    float mainViewWidth = (kWindowW - 20)+offy;
    if (mainViewWidth>=kWindowW) {
        mainViewWidth = kWindowW;
    }
    
    float y = 100+offy;
    if (y>=kWindowW*320/750) {
        y = kWindowW*320/750;
    }
    
    if (y<=90) {
        y = 90;
    }
    
    float mainViewHei = 107;
    mainViewHei -= offy;
    if (mainViewHei<=43) {
        mainViewHei = 43;
    }
    
    CGFloat yuanJiao = 10;
    
    yuanJiao -= offy;
    if (yuanJiao<=0) {
        yuanJiao = 0;
    }
    
    
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((kWindowW-mainViewWidth)/2);
        make.right.mas_equalTo(-(kWindowW-mainViewWidth)/2);
        make.height.mas_equalTo(mainViewHei);
    }];
    [self.mainView.layer setCornerRadius:yuanJiao];
    
    CGFloat titiZiHao = 17;
    titiZiHao -= offy;
    if (titiZiHao<=14) {
        titiZiHao = 14;
    }
    selectTitleLa1.font = [UIFont systemFontOfSize:titiZiHao];
    selectTitleLa2.font = [UIFont systemFontOfSize:titiZiHao];
    selectTitleLa3.font = [UIFont systemFontOfSize:titiZiHao];
    
    CGFloat numberZiHao = 40;
    numberZiHao -= offy;
    if (numberZiHao<=14) {
        numberZiHao = 14;
    }
    selectNumberLa1.font = [UIFont systemFontOfSize:numberZiHao];
    selectNumberLa2.font = [UIFont systemFontOfSize:numberZiHao];
    selectNumberLa3.font = [UIFont systemFontOfSize:numberZiHao];
    
    
    CGFloat numberCenteY = 10;
    numberCenteY -= offy;
    if (numberCenteY<=0) {
        numberCenteY = 0;
    }
    

    CGFloat number1CenteX = 0;
    number1CenteX += offy;
    if (number1CenteX>=selectTitleLa1.frame.size.width/2) {
        number1CenteX = selectTitleLa1.frame.size.width/2;
    }
    [selectNumberLa1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(numberCenteY);
        make.centerX.mas_equalTo(dingWeiViwenew.mas_centerX).mas_equalTo(number1CenteX);
    }];
    CGFloat title1CenteX = -10;
    title1CenteX += offy;
    if (title1CenteX>=selectNumberLa1.frame.size.width/2+5) {
        title1CenteX = selectNumberLa1.frame.size.width/2+5;
    }
    [selectTitleLa1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(dingWeiViwenew.mas_centerX).mas_equalTo(-title1CenteX);
    }];
    
    CGFloat number2CenteX = 0;
    number2CenteX += offy;
    if (number2CenteX>=selectTitleLa2.frame.size.width/2) {
        number2CenteX = selectTitleLa2.frame.size.width/2;
    }
    [selectNumberLa2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(numberCenteY);
        make.centerX.mas_equalTo(dingWeiViweCenter.mas_centerX).mas_equalTo(number2CenteX);
    }];
    
    CGFloat title2CenteX = 0;
    title2CenteX += offy;
    if (title2CenteX>=selectNumberLa2.frame.size.width/2+5) {
        title2CenteX = selectNumberLa2.frame.size.width/2+5;
    }
    [selectTitleLa2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(dingWeiViweCenter.mas_centerX).mas_equalTo(-title2CenteX);
    }];
    
    CGFloat number3CenteX = 0;
    number3CenteX += offy;
    if (number3CenteX>=selectTitleLa3.frame.size.width/2) {
        number3CenteX = selectTitleLa3.frame.size.width/2;
    }
    [selectNumberLa3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mainView.mas_centerY).mas_equalTo(numberCenteY);
        make.centerX.mas_equalTo(dingWeiViwe.mas_centerX).mas_equalTo(number3CenteX);
    }];
    
    
    CGFloat title3CenteX = 0;
    title3CenteX += offy;
    if (title3CenteX>=selectNumberLa3.frame.size.width/2+5) {
        title3CenteX = selectNumberLa3.frame.size.width/2+5;
    }
    [selectTitleLa3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(dingWeiViwe.mas_centerX).mas_equalTo(-title3CenteX);
    }];
    
    CGFloat dingweiView1 = 0;
    dingweiView1 += offy;
    if (dingweiView1>=43) {
        dingweiView1 = 43;
    }
    [dingWeiViwenew mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dingweiView1);
    }];
    
    CGFloat lineHeight = 3;
    lineHeight -= offy;
    if (lineHeight<=1) {
        lineHeight = 1;
    }
    
    [selectLineLa1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lineHeight);
    }];
    
    [selectLineLa2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lineHeight);
    }];
    
    [selectLineLa3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lineHeight);
    }];
}

-(void)setTitleStrWithArrar:(NSArray *)array
{
    selectNumberLa1.text = array[0];
    selectNumberLa2.text = array[1];
    selectNumberLa3.text = array[2];
}

- (void)scrollViewDidScroll:(float)offy
{
//        NPrintLog(@"移动 %f", offy);
    if (offy <= 200 && offy >= 0) {
        [self startAnimation:offy];

    }
    else if (offy > 0){

        if(offy > 32 && offy <= 95){
        }
        else{

        }
        if (offy > 64) {

        }
        else{

        }
    }
    else{
//        if(CGRectGetWidth(m_homeIcon.frame) != 55)
//            [self startAnimation:0];
    }
}


@end
