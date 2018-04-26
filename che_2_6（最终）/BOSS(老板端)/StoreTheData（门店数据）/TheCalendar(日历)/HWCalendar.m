//
//  HWCalendar.m
//  HWCalendar
//
//  Created by wqb on 2017/1/12.
//  Copyright © 2017年 hero_wqb. All rights reserved.
//

#import "HWCalendar.h"
#import "HWOptionButton.h"

#define KCol 7
#define KBtnW 44
#define KBtnH 44
#define KMaxCount 37
#define KBtnTag 100
#define KTipsW 60
#define KShowYearsCount 20
#define KMainColor [UIColor colorWithRed:0.0f green:139/255.0f blue:125/255.0f alpha:1.0f]
#define KbackColor [UIColor colorWithRed:173/255.0f green:212/255.0f blue:208/255.0f alpha:1.0f]

@interface HWCalendar ()<UIPickerViewDelegate, UIPickerViewDataSource, HWOptionButtonDelegate>

@property (nonatomic, strong) NSArray *weekArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) UIPickerView *timePicker;
@property (nonatomic, weak) UIView *calendarView;
@property (nonatomic, weak) HWOptionButton *yearBtn;
@property (nonatomic, weak) HWOptionButton *monthBtn;
@property (nonatomic, weak) UILabel *weekLabel;
@property (nonatomic, weak) UILabel *yearLabel;
@property (nonatomic, weak) UILabel *monthLabel;
@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentDay;

//===========================
@property(nonatomic,strong)UIView   *mainView;
@property(nonatomic,strong)UIView   *riView;
@property(nonatomic,strong)UIView   *nianView;
@property(nonatomic,strong)UIView   *headerView;
@property(nonatomic,strong)UILabel   *yearLable;

@end

@implementation HWCalendar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ((kWindowH-780/2)-20)/2, kWindowW, 780/2)];
        [self.mainView.layer setMasksToBounds:YES];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 50)];
        [self.mainView addSubview:self.headerView];
        
        self.nianView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kWindowW, 714/2-50)];
        [self.mainView addSubview:self.nianView];
        
        self.riView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kWindowW, 714/2-50)];
        
        [self.mainView addSubview:self.riView];
        
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headerView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.headerView);
            make.width.height.mas_equalTo(50);
        }];
        
        self.yearLable = [[UILabel alloc]init];
        self.yearLable.font = [UIFont systemFontOfSize:12];
        [self.yearLable setTextColor:[UIColor blackColor]];
        self.yearLable.text = @"hakhfkahfk";
        [self.headerView addSubview:self.yearLable];
        [self.yearLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftBtn.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(leftBtn);
        }];
        
        zuoYouButton = [[UIView alloc]init];
        [zuoYouButton.layer setMasksToBounds:YES];
        [zuoYouButton.layer setCornerRadius:25/2];
        [zuoYouButton.layer setBorderWidth:0.5];
        [zuoYouButton.layer setBorderColor:kLineBgColor.CGColor];
        [self.headerView addSubview:zuoYouButton];
        [zuoYouButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.headerView);
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
        
        
        
        
        //获取当前时间
        [self getCurrentDate];

        //获取数据源
        [self getDataSource];

        self.shiFouNianShuaXin = YES;
        //创建控件
        [self setZhiNianView];
        [self creatControl];

        //初始化设置
        [self setDefaultInfo];

        //刷新数据
        [self reloadData];
    }
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(selfViewTouch:)];
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.mainView]) {
        return NO;
    }
    return YES;
}
-(void)selfViewTouch:(UIButton*)sender
{
    [self dismiss];
}

-(void)selectClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<2; i++) {
        UIButton * btn = [zuoYouButton viewWithTag:500+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    if ([sender.titleLabel.text isEqualToString:@"月"]) {
        self.riView.hidden = YES;
        self.nianView.hidden = NO;
    }else{
        self.riView.hidden = NO;
        self.nianView.hidden = YES;
    }
}

- (void)creatControl
{
    self.yueSlideView = [[YQNumberSlideView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 60)];
    [self.yueSlideView setLableCount:12];
    self.yueSlideView.delegate = self;
    [self.riView addSubview:self.yueSlideView];
    [self.yueSlideView setShowArray:@[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"]];
    [self.yueSlideView show];
    
    
    //日历核心视图
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kWindowW, 614/2-60)];
    [self.riView addSubview:calendarView];
    self.calendarView = calendarView;
    
    //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
    for (int i = 0; i < KMaxCount; i++) {
        CGFloat btnX = i % KCol * KBtnW;
        CGFloat btnY = i / KCol * KBtnH;
        
        UIView *jiaV = [[UIView alloc]initWithFrame:CGRectMake(btnX, btnY, KBtnW, KBtnH)];
        [calendarView addSubview:jiaV];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i + KBtnTag;
        btn.layer.cornerRadius = 25 * 0.5;
        btn.layer.masksToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[self imageWithColor:kZhuTiColor] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[self imageWithColor:kZhuTiColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(dateBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [jiaV addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(jiaV);
            make.width.height.mas_equalTo(25);
        }];
    }
    
}

-(void)setZhiNianView{
    
    self.nianSlideView = [[YQNumberSlideView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 60)];
    [self.nianSlideView setLableCount:20];
    self.nianSlideView.delegate = self;
    [self.nianView addSubview:self.nianSlideView];
    [self.nianSlideView setShowArray:self.yearArray];
    [self.nianSlideView show];
    
    yueView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kWindowW, 614/2-60)];
    [self.nianView addSubview:yueView];
    for (int i = 0; i<self.monthArray.count; i++) {
        UIView *jiaV = [[UIView alloc]initWithFrame:CGRectMake((kWindowW/5)*((i%5)), (i/5)*60, (kWindowW/5), 60)];
        jiaV.tag = 200+i;
        [yueView addSubview:jiaV];
        
        UIButton *yueBt = [[UIButton alloc]init];
        yueBt.tag = 500;
        [yueBt addTarget:self action:@selector(yueBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [yueBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [yueBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        [yueBt setTitle:[NSString stringWithFormat:@"%d",i+1] forState:(UIControlStateNormal)];
        [yueBt setBackgroundImage:[self imageWithColor:kZhuTiColor] forState:(UIControlStateSelected)];
        [yueBt.layer setMasksToBounds:YES];
        [yueBt.layer setCornerRadius:35/2];
        [jiaV addSubview:yueBt];
        [yueBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(jiaV);
            make.width.height.mas_equalTo(35);
        }];
    }
    self.nianView.hidden = YES;
}

-(void)yueBtChick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    
    _month = [sender.titleLabel.text integerValue];
    
    [self reloadData];
}

- (void)getDataSource
{
    _weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    _timeArray = @[@[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"], @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59"]];
    
    NSInteger firstYear = _year - KShowYearsCount / 2;
    NSMutableArray *yearArray = [NSMutableArray array];
    for (int i = 0; i < KShowYearsCount; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld", firstYear + i]];
    }
    _yearArray = yearArray;
    _monthArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
}

- (void)setDefaultInfo
{
    [_timePicker selectRow:_hour inComponent:0 animated:NO];
    [_timePicker selectRow:_minute - 1 inComponent:1 animated:NO];
    _currentYear = _year;
    _currentMonth = _month;
    _currentDay = _day;
}



//set方法
- (void)setShowTimePicker:(BOOL)showTimePicker
{
    _showTimePicker = showTimePicker;
    
    if (showTimePicker) {
        _timePicker.hidden = YES;
        _dayLabel.frame = CGRectMake(0, CGRectGetMaxY(_monthLabel.frame) + 10, KTipsW, 120);
        _timePicker.frame = CGRectMake(10, CGRectGetMaxY(_dayLabel.frame), KTipsW - 20, 88);
    }else {
        _timePicker.hidden = YES;
        _dayLabel.frame = CGRectMake(0, CGRectGetMaxY(_monthLabel.frame) + 30, 200, 120);
    }
}

//上一月按钮点击事件
- (void)preBtnOnClick
{
    if (_month == 1) {
        if (_yearBtn.row == 0) return;
        _year --;
        _month = 12;
        _yearBtn.row --;
    }else {
        _month --;
    }
    
    _monthBtn.row = _month - 1;
    [self reloadData];
}

//下一月按钮点击事件
- (void)nextBtnOnClick
{
    if (_month == 12) {
        if (_yearBtn.row == KShowYearsCount - 1) return;
        _year ++;
        _month = 1;
        _yearBtn.row ++;
    }else {
        _month ++;
    }
    
    _monthBtn.row = _month - 1;
    [self reloadData];
}

//返回今天
- (void)backTodayBtnOnClick
{
    _year = _currentYear;
    _month = _currentMonth;
    _monthBtn.row = _month - 1;
    _yearBtn.row = KShowYearsCount / 2;
    
    [self reloadData];
}

//刷新数据
- (void)reloadData
{
    NSInteger totalDays = [self numberOfDaysInMonth];
    NSInteger firstDay = [self firstDayOfWeekInMonth];
    
//    _yearLabel.text = [NSString stringWithFormat:@"%ld年", _year];
//    _monthLabel.text = [NSString stringWithFormat:@"%ld月", _month];
//    _yearBtn.title = [NSString stringWithFormat:@"%ld年", _year];
//    _monthBtn.title = [NSString stringWithFormat:@"%ld月", _month];
    self.yearLable.text = [NSString stringWithFormat:@"%ld年", _year];
    
    
    for (int i = 0; i < KMaxCount; i++) {
        UIButton *btn = (UIButton *)[self.calendarView viewWithTag:i + KBtnTag];
        btn.selected = NO;
        
        if (i < firstDay - 1 || i > totalDays + firstDay - 2) {
            btn.enabled = NO;
            [btn setTitle:@"" forState:UIControlStateNormal];
        }else {
            if (_year == _currentYear && _month == _currentMonth) {
                if (btn.tag - KBtnTag - (firstDay - 2) == _currentDay) {
                    btn.selected = YES;
                    _day = _currentDay;
                    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
                    _dayLabel.text = [NSString stringWithFormat:@"%ld日", _day];
                }
            }else {
                if (i == firstDay - 1) {
//                    btn.selected = YES;
                    _day = btn.tag - KBtnTag - (firstDay - 2);
                    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
                    _dayLabel.text = [NSString stringWithFormat:@"%ld日", _day];
                }
            }
            btn.enabled = YES;
            [btn setTitle:[NSString stringWithFormat:@"%ld", i - (firstDay - 1) + 1] forState:UIControlStateNormal];
        }
    }
    
    
    
//    if (self.shiFouGengXin == YES) {
//        self.shiFouGengXin = NO;
//    }else
//    {
//        [self.yueSlideView nextWitnCount:_month];
//    }
    [self.yueSlideView nextWitnCount:_month];
    
    if (self.shiFouNianShuaXin == YES) {
        [self.nianSlideView nextWitnCount:11];
        self.shiFouNianShuaXin = NO;
    }
    
    NSString *ninJieQu = [self.yearLable.text substringToIndex:4];
    
    NPrintLog(@"_month%ld",_month);
    for (int i = 0; i<self.monthArray.count; i++) {
        UIView *jiaV = [yueView viewWithTag:200+i];
        UIButton *yueBt = [jiaV viewWithTag:500];
        yueBt.selected = NO;
        if (i == (_month-1)) {
            yueBt.selected = YES;
        }
    }
}

//获取当前时间
- (void)getCurrentDate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    _year = [components year];
    _month = [components month];
    _day = [components day];
    _hour = [components hour];
    _minute = [components minute];
}

//根据选中日期，获取相应NSDate
- (NSDate *)getSelectDate
{
    //初始化NSDateComponents，设置为选中日期
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = _year;
    dateComponents.month = _month;
    
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:dateComponents];
}

//获取目标月份的天数
- (NSInteger)numberOfDaysInMonth
{
    //获取选中日期月份的天数
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getSelectDate]].length;
}

//获取目标月份第一天星期几
- (NSInteger)firstDayOfWeekInMonth
{
    //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:[self getSelectDate]];
}

//根据颜色返回图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//选中日期时调用
- (void)dateBtnOnClick:(UIButton *)btn
{
    _day = btn.tag - KBtnTag - ([self firstDayOfWeekInMonth] - 2);
    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
    _dayLabel.text = [NSString stringWithFormat:@"%ld", _day];
    
    if (btn.selected) return;
    
    for (int i = 0; i < KMaxCount; i++) {
        UIButton *button = [self.calendarView viewWithTag:i + KBtnTag];
        button.selected = NO;
    }
    
    btn.selected = YES;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _timeArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [(NSArray *)_timeArray[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _timeArray[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *time = _timeArray[component][row];
    if (component == 0) {
        _hour = [time integerValue];
    } else if (component == 1) {
        _minute = [time integerValue];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor whiteColor];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:20.0f];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark - HWOptionButtonDelegate
- (void)didSelectOptionInHWOptionButton:(HWOptionButton *)optionButton
{
    if (optionButton.title.length > 2) {
        _year = [optionButton.title integerValue];
        _yearBtn.title = [NSString stringWithFormat:@"%ld年", _year];
    }else {
        _month = [optionButton.title integerValue];
        _monthBtn.title = [NSString stringWithFormat:@"%ld月", _month];
    }
    
    [self reloadData];
}

//确认按钮点击事件
- (void)sureBtnOnClick
{
    [self dismiss];
    
    NSString *date;
    if (_showTimePicker) {
        date = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld", _year, _month, _day, _hour, _minute];
    }else {
        date = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(calendar:didClickSureButtonWithDate:)]) {
        [_delegate calendar:self didClickSureButtonWithDate:date];
    }
}

//取消按钮点击事件
- (void)cancelBtnOnClick
{
    [self dismiss];
}

//弹入视图
- (void)show
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }];
}

//弹出视图
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    }];
}


-(void)YQSlideViewDidChangeIndex:(int)count withYQNumberSlideView:(YQNumberSlideView *)SlideView
{
    _month = count+1;
    [self reloadData];
}
@end
