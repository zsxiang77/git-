//
//  JobBoardHeaderView.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardHeaderView.h"
#import "CommonControlOrView.h"

@interface JobBoardHeaderView()


@end

@implementation JobBoardHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNoRecieveTouch = YES;
        
        UIView *shangView = [UIView alloc]initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        
    }
    return self;
}

- (NSString*)getWeatherWithID:(NSInteger)weather
{
    switch (weather) {
        case 3:case 4:case 21:case 22:case 28:
            return @"阴";
        case 5:case 24:
            return @"小雨";
        case 6:case 7:case 8:case 10:
            return @"大雨";
        case 9:case 15:case 25:case 26:case 27:case 29:case 30:case 31:
            return @"雪";
        case 12:
            return @"多云";
        case 19:case 20:case 23:
            return @"晴转雨";
        default:
            return @"晴";
            break;
    }
}

- (void)refreshAllData:(NSDictionary*)dic
{
    [m_homeIcon sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(dic, @"hlogo")] placeholderImage:DJImageNamed(@"team_hold")];
    [m_guestIcon sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(dic, @"alogo")] placeholderImage:DJImageNamed(@"team_hold")];
    
    m_homeLabel.text = KISDictionaryHaveKey(dic, @"hteam");
    m_guestLabel.text = KISDictionaryHaveKey(dic, @"ateam");
    
    m_homeRankingLabel.text = [NSString stringWithFormat:@"%@%@", KISDictionaryHaveKey(dic, @"ln"), KISDictionaryHaveKey(dic, @"hpm")];
    m_guestRankingLabel.text = [NSString stringWithFormat:@"%@%@", KISDictionaryHaveKey(dic, @"ln"), KISDictionaryHaveKey(dic, @"apm")];
    
    NSString* times = KISDictionaryHaveKey(dic, @"matchTime");
    if ([times length] > 18) {
        m_matchTime.text = [NSString stringWithFormat:@"%@ %@", KISDictionaryHaveKey(dic, @"ln"), [times substringWithRange:NSMakeRange(5, 11)]];
        //        m_matchTime.text = [NSString stringWithFormat:@"%@ %lu-%lu %lu:%@", KISDictionaryHaveKey(dic, @"ln"), [[times substringWithRange:NSMakeRange(5, 2)] integerValue], [[times substringWithRange:NSMakeRange(8, 2)] integerValue], [[times substringWithRange:NSMakeRange(11, 2)] integerValue], [times substringWithRange:NSMakeRange(14, 2)]];
    }
    m_letPoint.text = [NSString stringWithFormat:@"让%@", KISDictionaryHaveKey(dic, @"rq")];
    
    NSInteger state = [KISDictionaryHaveKey(dic, @"state") integerValue];
    if (state != 4 && state != 10) {//4 10 完场
        m_weatherLabel.text = [NSString stringWithFormat:@"%@ %@", [self getWeatherWithID: [KISDictionaryHaveKey(dic, @"weather") integerValue]], KISDictionaryHaveKey(dic, @"tem")];
    }
    if (state == 1 || state == 2 || state == 3 || state == 5 || state == 7 || state == 8 || state == 9 || state == 11 || state == 12 || state == 16) {//进行中 5中断
        if ([[NSString stringWithFormat:@"%@", KISDictionaryHaveKey(dic, @"kmins")] length] > 0) {
            m_proTimeLabel.text = [NSString stringWithFormat:@"%@\n%@'",KISDictionaryHaveKey(dic, @"kstate"), KISDictionaryHaveKey(dic, @"kmins")];
        }
        else{
            m_proTimeLabel.text = KISDictionaryHaveKey(dic, @"kstate");
        }
        m_proTimeLabel.textColor = kRGBColor(3, 176, 60);
        m_proTimeLabel.font = DJSystemFont(14);
        
        m_homeScoreLabel.text = [NSString stringWithFormat:@"%@", KISDictionaryHaveKey(dic, @"hscore")];
        m_guestScoreLabel.text = [NSString stringWithFormat:@"%@", KISDictionaryHaveKey(dic, @"ascore")];
    }
    else if (state == 4 || state == 10){//完场
        m_proTimeLabel.textColor = kRGBColor(225, 225, 225);
        m_proTimeLabel.font = DJSystemFont(10);
        m_proTimeLabel.text = [NSString stringWithFormat:@"半场\n(%@)", KISDictionaryHaveKey(dic, @"bc")];
        
        m_homeScoreLabel.text = [NSString stringWithFormat:@"%@", KISDictionaryHaveKey(dic, @"hscore")];
        m_guestScoreLabel.text = [NSString stringWithFormat:@"%@", KISDictionaryHaveKey(dic, @"ascore")];
    }
    else{
        m_proTimeLabel.textColor = [UIColor whiteColor];
        m_proTimeLabel.font = DJSystemFont(14);
        if(state == 6)
            m_proTimeLabel.text = @"已取消";
        else if(state == 14)
            m_proTimeLabel.text = @"已腰斩";
        else
            m_proTimeLabel.text = @"未开赛";
    }
}


- (void)startAnimation:(float)offy
{
    //x:((kWindowW/2.0-100)-20)*(offy/32.0) 总变化距离(kWindowW/2.0-100)-20 20是起始x
    float iconWidth = 55-35*offy/32.0;
    float width = CGRectGetWidth(self.frame);
    m_homeIcon.frame = CGRectMake(20+((kWindowW/2.0-100)-20)*offy/32.0, 64, iconWidth, iconWidth);
    m_homeIcon.layer.cornerRadius = iconWidth/2.0;
    
    m_guestIcon.frame = CGRectMake((width-75)-((width-75)-(kWindowW/2.0+80))*offy/32.0, 64, iconWidth, iconWidth);
    m_guestIcon.layer.cornerRadius = iconWidth/2.0;
    
}

- (void)scrollViewDidScroll:(float)offy
{
    //    NPrintLog(@"移动 %f", offy);
    if (offy <= 32 && offy >= 0) {
        [self startAnimation:offy];
        
        m_matchTime.hidden = NO;
        m_letPoint.hidden = NO;
        m_homeLabel.hidden = NO;
        m_guestLabel.hidden = NO;
        m_homeRankingLabel.hidden = NO;
        m_guestRankingLabel.hidden = NO;
        m_weatherLabel.hidden = NO;
    }
    else if (offy > 0){
        if(CGRectGetWidth(m_homeIcon.frame) != 20)
            [self startAnimation:32];
        
        CGRect oldFrame = m_homeIcon.frame;
        CGRect oldFrame_guest = m_guestIcon.frame;
        if(offy > 32 && offy <= 95){
            m_homeIcon.frame = CGRectMake(CGRectGetMinX(oldFrame), 64+(offy-32), CGRectGetWidth(oldFrame), CGRectGetHeight(oldFrame));
            m_guestIcon.frame = CGRectMake(CGRectGetMinX(oldFrame_guest), 64+(offy-32), CGRectGetWidth(oldFrame_guest), CGRectGetHeight(oldFrame_guest));
        }
        else{
            m_homeIcon.frame = CGRectMake(CGRectGetMinX(oldFrame), 64+(95-32), CGRectGetWidth(oldFrame), CGRectGetHeight(oldFrame));
            m_guestIcon.frame = CGRectMake(CGRectGetMinX(oldFrame_guest), 64+(95-32), CGRectGetWidth(oldFrame_guest), CGRectGetHeight(oldFrame_guest));
        }
        if (offy > 64) {
            m_matchTime.hidden = YES;
            m_letPoint.hidden = YES;
            m_homeLabel.hidden = YES;
            m_guestLabel.hidden = YES;
            m_homeRankingLabel.hidden = YES;
            m_guestRankingLabel.hidden = YES;
            m_weatherLabel.hidden = YES;
        }
        else{
            m_matchTime.hidden = NO;
            m_letPoint.hidden = NO;
            m_homeLabel.hidden = NO;
            m_guestLabel.hidden = NO;
            m_homeRankingLabel.hidden = NO;
            m_guestRankingLabel.hidden = NO;
            m_weatherLabel.hidden = NO;
        }
    }
    else{
        if(CGRectGetWidth(m_homeIcon.frame) != 55)
            [self startAnimation:0];
    }
}


@end
