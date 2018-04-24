//
//  CalenderView.m
//  日历表
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "CalenderView.h"
#import "UIColor+ZXLazy.h"

@interface CalenderCell : UICollectionViewCell


@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation CalenderCell

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.frame = self.bounds;
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        _dateLabel.layer.cornerRadius = _dateLabel.bounds.size.height * 0.5;
        _dateLabel.layer.masksToBounds = YES;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end

@interface CalenderView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat itemHeight;
}
@property (nonatomic,strong) NSCalendar *currentCalendar;
@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) NSArray *moucthArray;
@property (nonatomic,strong) NSDate *currentDate;
@property (weak, nonatomic) UICollectionView *collectionview;
@property (weak, nonatomic) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *selectStauts;
@property(nonatomic,strong) UIScrollView * yueHeaderScroll;
@end

@implementation CalenderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        _currentDate = [self getLocalDate];
        _selectStauts = @[].mutableCopy;
        
        self.backgroundColor = [UIColor whiteColor];
        
        titleView = [UIView new];
        titleView.frame = CGRectMake(0, 0, frame.size.width, 50);
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
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
        [zuoYouButton.layer setBorderWidth:1];
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
            [dateBtn setTitle:self.moucthArray[i] forState:(UIControlStateNormal)];
            [dateBtn setTitleColor:kLineBgColor forState:UIControlStateNormal];
            [dateBtn setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
            [self.yueHeaderScroll addSubview:dateBtn];
        }
        self.yueHeaderScroll.contentSize = CGSizeMake(self.moucthArray.count*kWindowW/5, 50);
        [self.yueHeaderScroll setContentOffset:CGPointMake(kWindowW/5*2,0) animated:YES];
        CGFloat itemWidth = (frame.size.width-2) / 7;
        itemHeight = (frame.size.height -2) / 7;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
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
    }
    return self;
}


#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return self.weekDayArray.count;
    }else{
        return 47;
    }
}

-(CalenderCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        //一个月里所有的天数
        NSInteger daysInThisMonth = [self getDaysOfMonth];
        //一个月里的第一天是星期几
        NSInteger firstWeekday = [self getWeekOfDayOfMonth];
        NSInteger day = 0;
        
        //行数不大于第一天的星期数
        if (indexPath.row < firstWeekday) {
            [cell.dateLabel setText:@""];
            
        //行数大于第一天所在的星期数＋这个月的天数－1
        }else if (indexPath.row > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
        }else{
            day = indexPath.row - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        CalenderCell *cell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if(cell.dateLabel.text.length != 0){
            [cell.contentView.layer setCornerRadius:itemHeight/2];
            [cell.contentView setBackgroundColor:[UIColor redColor]];
        }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalenderCell *deselectedCell = (CalenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(deselectedCell.dateLabel.text.length != 0){
        [deselectedCell.contentView.layer setCornerRadius:itemHeight/2];
        [deselectedCell.contentView setBackgroundColor:[UIColor clearColor]];
    }
}

#pragma -mark btn事件
-(void)previous{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        _currentDate = [self getPerviousMonth:_currentDate];
        _titleLabel.text = [self stirngFromDate:_currentDate];
        [_collectionview reloadData];
    } completion:nil];
}

-(void)next{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        _currentDate = [self getNextMonth:_currentDate];
        _titleLabel.text = [self stirngFromDate:_currentDate];
        [_collectionview reloadData];
    }completion:nil];
}

#pragma mark - Get 初始化
-(NSCalendar *)currentCalendar{
    if(!_currentCalendar){
        _currentCalendar = [NSCalendar currentCalendar];
    }
    return _currentCalendar;
}

-(NSArray *)weekDayArray{
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    return _weekDayArray;
}
-(NSArray *)moucthArray{
    _moucthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
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
 *  得到这个月的第一天
 *
 *  @return <#return value description#>
 */
-(NSDate *)getFirstDayOfCurrentMonth
{
    double interval = 0;
    NSDate *beginDate = nil;
    //    NSDate *endDate = nil;
    
    [self.currentCalendar setFirstWeekday:1];//设定周一为周首日
    BOOL ok = [self.currentCalendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:_currentDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        //        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
    }
    return beginDate;
}
/**
 *  得到这个月的第一天是星期几
 *
 *  @return <#return value description#>
 */
-(NSUInteger)getWeekOfDayOfMonth{
    NSUInteger weekCount = [self.currentCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:[self getFirstDayOfCurrentMonth]] - 1;
    return weekCount;
}

/**
 *  得到这个月的天数
 *
 *  @return <#return value description#>
 */
-(NSUInteger)getDaysOfMonth{
    NSUInteger daysCount = [self.currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_currentDate].length;
    NPrintLog(@"_currentDate%@",_currentDate);
    return daysCount;
}

/**
 *  得到这个月的周数
 *
 *  @return <#return value description#>
 */
-(NSUInteger)getWeeksOfMonth{
    NSUInteger weekDay = [self getWeekOfDayOfMonth];
    NSUInteger days = [self getDaysOfMonth];
    NSUInteger weeks = 0;
    
    if(weekDay > 1){
        weeks+=1;
        days-=(7-weekDay+1);
    }
    
    weeks+=days/7;
    weeks+=(days%7>0)?1:0;
    return weeks;
}

/**
 *  NSDate 转成字符串
 *
 *  @param wtime <#wtime description#>
 *
 *  @return <#return value description#>
 */
-(NSString *)stirngFromDate:(NSDate *)wtime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    return [dateFormatter stringFromDate:wtime];
}

/**
 *  下一个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSDate*)getNextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

/**
 *  上一个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSDate*)getPerviousMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
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
}
-(void)leftButtonClick:(UIButton *)sender
{
    self.rilianHidenBlock();
}


@end
