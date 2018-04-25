//
//  CalenderView.m
//  日历表
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "CalenderView.h"


@interface CalenderCell : UICollectionViewCell


@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation CalenderCell

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:14]];
        [_dateLabel setTextColor:kRGBColor(74, 74, 74)];
        _dateLabel.layer.cornerRadius = 18;
        _dateLabel.layer.masksToBounds = YES;
        [self addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.height.mas_equalTo(36);
        }];
    }
    return _dateLabel;
}
@end

@interface CalenderView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat itemHeight;
    CGFloat yearHeight;
    NSInteger strTimes;
}
@property (nonatomic,strong) NSCalendar *currentCalendar;
@property (nonatomic , strong) NSArray *yearArray;
@property (nonatomic , strong) NSArray *moucthArray;
@property (nonatomic,strong) NSDate *currentDate;
@property (weak, nonatomic) UICollectionView *collectionview;
@property (nonatomic,strong ) UICollectionView *yearLectionview;
@property(nonatomic,strong) UIScrollView * yueHeaderScroll;
@property(nonatomic,strong) UIScrollView * yearHeaderScroll;
@end

@implementation CalenderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        [self yesrdeskjkjkjkj];
        self.backgroundColor = [UIColor whiteColor];
        
        titleView = [UIView new];
        titleView.frame = CGRectMake(0, 0, frame.size.width, 50);
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(titleView);
            make.width.height.mas_equalTo(50);
        }];
   
        self.yearLable = [[UILabel alloc]init];
        self.yearLable.font = [UIFont systemFontOfSize:12];
        [self.yearLable setTextColor:[UIColor blackColor]];
        self.yearLable.text = @"hakhfkahfk";
        [titleView addSubview:self.yearLable];
        [self.yearLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftBtn.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(leftBtn);
        }];

        UIView * zuoYouButton = [[UIView alloc]init];
        [zuoYouButton.layer setMasksToBounds:YES];
        [zuoYouButton.layer setCornerRadius:25/2];
        [zuoYouButton.layer setBorderWidth:0.5];
        [zuoYouButton.layer setBorderColor:kLineBgColor.CGColor];
        [titleView addSubview:zuoYouButton];
        [zuoYouButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(titleView);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(172/2);
        }];
        
        for (int i =0; i<2; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(172/2/2*i, 0, 172/2/2, 25)];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:25/2];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = 500+i;
       
            [btn setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
            [btn setTitleColor:kRGBColor(255, 255, 255)forState:(UIControlStateSelected)];
            [btn setBackgroundImage:[UIImage imageWithColor:kZhuTiColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageWithColor:kRGBColor(255, 255, 255)] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
            if(i==0){
                [btn setTitle:@"日" forState:(UIControlStateNormal)];
                btn.selected = YES;
            }else{
                [btn setTitle:@"月" forState:(UIControlStateNormal)];
            }
            [zuoYouButton addSubview:btn];
        }
        
        
        
        self.yueHeaderScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, frame.size.width, 50)];
        [self.yueHeaderScroll  setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.yueHeaderScroll];
        self.yueHeaderScroll.delegate=self;
        self.yueHeaderScroll.pagingEnabled=YES;
        for (int i= 0; i<12; i++) {
            UIButton * dateBtn = [[UIButton alloc]init];
            dateBtn.frame = CGRectMake(kWindowW/5*i, 0, kWindowW/5, 50);
            dateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            dateBtn.tag = 600+i;
            [dateBtn addTarget:self action:@selector(yueFenSelectBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [dateBtn setTitle:self.moucthArray[i] forState:(UIControlStateNormal)];
            [dateBtn setTitleColor:kLineBgColor forState:UIControlStateNormal];
            [dateBtn setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
            [self.yueHeaderScroll addSubview:dateBtn];
        }
        self.yueHeaderScroll.contentSize = CGSizeMake(self.moucthArray.count*kWindowW/5, 50);
        [self.yueHeaderScroll setContentOffset:CGPointMake(kWindowW/5*2,0) animated:YES];
        
        
        self.yearHeaderScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, frame.size.width, 50)];
        [self.yearHeaderScroll  setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.yearHeaderScroll];
        self.yearHeaderScroll.delegate=self;
        self.yearHeaderScroll.pagingEnabled=YES;
        for (int i= 0; i<self.yearArray.count; i++) {
            UIButton * dateBtn = [[UIButton alloc]init];
            dateBtn.frame = CGRectMake(kWindowW/5*i, 0, kWindowW/5, 50);
            dateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            dateBtn.tag = 700+i;
            [dateBtn addTarget:self action:@selector(yearSelectBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [dateBtn setTitle:self.yearArray[i] forState:(UIControlStateNormal)];
            [dateBtn setTitleColor:kLineBgColor forState:UIControlStateNormal];
            [dateBtn setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
            [self.yearHeaderScroll addSubview:dateBtn];
        }
        self.yearHeaderScroll.hidden = YES;
        self.yearHeaderScroll.contentSize = CGSizeMake(self.yearArray.count*kWindowW/5, 50);
        [self.yearHeaderScroll setContentOffset:CGPointMake(kWindowW/5*2,0) animated:YES];
       // CGFloat itemWidth = (frame.size.width-2) / 7;
        itemHeight = (frame.size.width -2) / 7;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemHeight, itemHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        UICollectionView *collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(1, 100+1, frame.size.width-2, frame.size.height - 100-2) collectionViewLayout:layout];
        collectionview.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionview];
        [collectionview registerClass:[CalenderCell class] forCellWithReuseIdentifier:@"cell"];
        collectionview.dataSource = self;
        collectionview.delegate = self;
        collectionview.scrollEnabled = NO;
        collectionview.showsVerticalScrollIndicator = NO;
        _collectionview = collectionview;
        
        yearHeight = (frame.size.width -2) / 5;
        UICollectionViewFlowLayout *layoutYear = [[UICollectionViewFlowLayout alloc]init];
        layoutYear.itemSize = CGSizeMake(yearHeight, yearHeight);
        layoutYear.minimumLineSpacing = 0;
        layoutYear.minimumInteritemSpacing = 0;
         _yearLectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(1, 100+1, frame.size.width-2, frame.size.height - 100-2) collectionViewLayout:layoutYear];
         _yearLectionview.backgroundColor = [UIColor whiteColor];
        [self addSubview: _yearLectionview];
        [ _yearLectionview registerClass:[CalenderCell class] forCellWithReuseIdentifier:@"cell"];
         _yearLectionview.dataSource = self;
         _yearLectionview.delegate = self;
         _yearLectionview.scrollEnabled = NO;
         _yearLectionview.hidden = YES;
         _yearLectionview.showsVerticalScrollIndicator = NO;
        
        
    }
    return self;
}


#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView ==_collectionview){
         return [self getDaysOfMonth];
    }else{
         return 12;
        
    }
    
}

-(CalenderCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView ==_collectionview){
        CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        //一个月里所有的天数
        NSInteger daysInThisMonth = [self getDaysOfMonth];
        if(indexPath.row+1 <= daysInThisMonth){
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",indexPath.row+1]];
            
        }
        if(strTimes ==[cell.dateLabel.text integerValue])
        {
            cell.dateLabel.backgroundColor = kZhuTiColor;
        }
        return cell;
    }else{
        CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        //一个月里所有的天数
        if(indexPath.row+1 <= 12){
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li月",indexPath.row+1]];
        }
        
        return cell;
    }
    
 
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView ==_collectionview){
        CalenderCell *cell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if(cell.dateLabel.text.length != 0){
            cell.dateLabel.backgroundColor = kZhuTiColor;
            [cell.dateLabel setTextColor:[UIColor whiteColor]];
        }
    }else{
        CalenderCell *cell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if(cell.dateLabel.text.length != 0){
              cell.dateLabel.backgroundColor = kZhuTiColor;
              [cell.dateLabel setTextColor:[UIColor whiteColor]];
        }
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   if(collectionView ==_collectionview){
    CalenderCell *deselectedCell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(deselectedCell.dateLabel.text.length != 0){
        deselectedCell.dateLabel.backgroundColor = [UIColor clearColor];
         [deselectedCell.dateLabel setTextColor:kRGBColor(74, 74, 74)];
    }
   }else{
    CalenderCell *deselectedCell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
       if(deselectedCell.dateLabel.text.length != 0){
            deselectedCell.dateLabel.backgroundColor = [UIColor clearColor];
            [deselectedCell.dateLabel setTextColor:kRGBColor(74, 74, 74)];
       }
   }
}

#pragma -mark btn事件
//-(void)previous{
//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
//        _currentDate = [self getPerviousMonth:_currentDate];
//       // [_collectionview reloadData];
//    } completion:nil];
//}

//-(void)next{
//    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
//        _currentDate = [self getNextMonth:_currentDate];
//       // _titleLabel.text = [self stirngFromDate:_currentDate];
//        [_collectionview reloadData];
//    }completion:nil];
//}

#pragma mark - Get 初始化
-(NSCalendar *)currentCalendar{
    if(!_currentCalendar){
        _currentCalendar = [NSCalendar currentCalendar];
    }
    return _currentCalendar;
}

//  月
-(NSArray *)moucthArray{
    _moucthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    return _moucthArray;
}
//年
-(NSArray *)yearArray
{
    _moucthArray = @[@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018"];
    return _moucthArray;
}
/**
 *  取到北京时间
 *
 *  @return <#return value description#>
 */
-(NSDate *)getLocalDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}

/**
 *  得到这个月的天数
 *
 *  @return <#return value description#>
 */
-(NSUInteger)getDaysOfMonth{
    NPrintLog(@"hhfkahkfhkafk------------%@",_currentDate)
    NSUInteger daysCount = [self.currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_currentDate].length;
    return daysCount;
}

+ (NSDate *)dateFromString:(NSString *)timeStr format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}
/**
 *  NSDate 转成字符串
 *
 *  @param wtime <#wtime description#>
 *
 *  @return <#return value description#>
 */
//-(NSString *)stirngFromDate:(NSDate *)wtime{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM"];
//    return [dateFormatter stringFromDate:wtime];
//}

/**
 *  下一个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
//- (NSDate*)getNextMonth:(NSDate *)date{
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    dateComponents.month = +1;
//    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
//    return newDate;
//}

/**
 *  上一个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSDate*)getPerviousMonth:(NSDate *)date{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
-(void)showTimes
{
    NSString *dateString = @"2016-03-31";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *mydate=[formatter dateFromString:dateString];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:mydate] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:mydate]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:mydate] integerValue];
    
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",mydate,currentYear,currentMonth,currentDay);
}

-(void)yesrdeskjkjkjkj
{
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    self.yearLable.text = [NSString stringWithFormat:@"%ld年",currentYear];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    strTimes = currentDay;
    [formatter setDateFormat:@"yyyy-MM-dd"];
   
    
    NSDate *deancn = [CalenderView dateFromString:@"2018-11-4" format:@"yyyy-MM-dd"];
     _currentDate = deancn;
    NPrintLog(@"周岁祥%@",deancn);
}




-(void)selectClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<2; i++) {
        UIButton *bt = [titleView viewWithTag:500+i];
        bt.selected = NO;
    }
    sender.selected =! sender.selected;
    _collectionview.hidden = YES;
    _yueHeaderScroll.hidden =YES;
    _yearHeaderScroll.hidden = YES;
    _yearLectionview.hidden = YES;
    if(sender.tag == 500){
        _collectionview.hidden = NO;
        _yueHeaderScroll.hidden =NO;
      
    }else{
        _yearLectionview.hidden = NO;
        _yearHeaderScroll.hidden = NO;
    }
}
-(void)leftButtonClick:(UIButton *)sender
{
    self.rilianHidenBlock();
}
-(void)yueFenSelectBtn:(UIButton *)sender
{
    
}
-(void)yearSelectBtn:(UIButton *)sender
{
    
}
@end
