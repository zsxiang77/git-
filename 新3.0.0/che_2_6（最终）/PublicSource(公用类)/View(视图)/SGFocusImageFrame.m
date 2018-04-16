
//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by chen yueqing on 14-10-21.
//  Copyright (c) 2014年 Chinasofti. All rights reserved.
//

#import <objc/runtime.h>
#import "SGFocusImageFrame.h"
#import "UIButton+WebCache.h"          //网络图片加载缓存类的导入
#import "CheDianZhangCommon.h"

#define ITEM_WIDTH self.frame.size.width

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    
    NSMutableArray *_pageControlArray;//页码
    float         _pageSize;//page小原点大小
    
    BOOL _isAutoPlay;
    UIImage* _placeHolderImage;
}

- (void)setupViews;
- (void)switchFocusImageItems;
@end

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"loopScrollview";//图片url

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 3.0; //switch interval time(滚动时间间隔)

@implementation SGFocusImageFrame
@synthesize delegate = _delegate;

@synthesize timer;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(NSString *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];
        NSString *eachItem;
        va_list argumentList;
        if (firstItem)
        {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);
            while((eachItem = va_arg(argumentList, NSString *)))
            {
                [imageItems addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = YES;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto placeHolderImage:(UIImage*)holdImg pageSize:(float)pageSize withTiTle:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        titleArrays = titles;
        _pageControlArray = [[NSMutableArray alloc] init];
        
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = isAuto;
        _placeHolderImage = holdImg;
        _pageSize = pageSize;
        
        [self setupViews];
        [self setDelegate:delegate];
    }
    return self;
}

- (void)dealloc
{
    objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    _scrollView.delegate = nil;
    _scrollView = nil;
    _pageControlArray = nil;
    _placeHolderImage = nil;
}


#pragma mark - private methods
- (void)setupViews
{
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    [self addSubview:_scrollView];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    NSInteger count = imageItems.count;
    for (int i = 0; i < count; i++) {
        NSString *item = [imageItems objectAtIndex:i];
        UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item] forState:UIControlStateNormal placeholderImage:_placeHolderImage];
        imageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView addTarget:self action:@selector(imageViewAction) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:imageView];
    }
    if (count > 3)
    {
        float startX = (CGRectGetWidth(self.frame) - ((count - 2) * _pageSize) - (count - 3) * _pageSize)/2.0;
        UIView *xiaView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) -25, kWindowW, 25)];
        xiaView.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        [self addSubview:xiaView];
        youLabel = [[UILabel alloc]init];
        youLabel.textColor = [UIColor whiteColor];
        youLabel.font = [UIFont systemFontOfSize:15];
        [xiaView addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        for (int i = 0; i < count - 2; i++) {//page控制
            UIButton *page = [[UIButton alloc]initWithFrame:CGRectMake(10 + i * (_pageSize + _pageSize), ((25-_pageSize)/2), _pageSize, _pageSize)];
            [page setBackgroundImage:DJImageNamed(@"dian_n") forState:UIControlStateNormal];
            [page setBackgroundImage:DJImageNamed(@"dian_c") forState:UIControlStateSelected];
            page.layer.cornerRadius = ceilf(_pageSize/2.0);
            page.layer.masksToBounds = YES;
            [xiaView addSubview:page];
            if (i == 0) {
                page.selected = YES;
            }
            [_pageControlArray addObject:page];
        }
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        if (_isAutoPlay)
        {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
        
    }
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];           //---***
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
    [self moveToTargetPosition:targetX];
    
    if ([imageItems count] > 1 && _isAutoPlay)
    {
         [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
}

- (void)imageViewAction{
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:page];
        }
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;

}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count] >= 3)
    {
        if (targetX >= ITEM_WIDTH * ([imageItems count] - 1)) {
            targetX = ITEM_WIDTH;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = ITEM_WIDTH * ([imageItems count] - 2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x + ITEM_WIDTH / 2.0) / ITEM_WIDTH;
    if ([imageItems count] > 1)
    {
        NSInteger pageCount = [_pageControlArray count];
        page --;
        youLabel.text = titleArrays[page+1];
        
        if (page >= pageCount)//最后一页
        {
            page = 0;
            UIButton* lastSelect = [_pageControlArray lastObject];
            lastSelect.selected = NO;
        }else if(page < 0)//第一页
        {
            page = pageCount;
            UIButton* lastSelect = [_pageControlArray firstObject];
            lastSelect.selected = NO;
        }
        for (int j = 0; j < pageCount; j++) {
            UIButton* pageBtn = [_pageControlArray objectAtIndex:j];
            if (j != page) {
                pageBtn.selected = NO;
            }
            else
                pageBtn.selected = YES;//指示点位置调整
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPosition:targetX];
    }
    if (_isAutoPlay && [_pageControlArray count] > 1) {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
}

@end
