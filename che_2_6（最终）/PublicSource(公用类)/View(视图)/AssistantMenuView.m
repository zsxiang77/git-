//
//  AssistantMenuView.m
//  DaJiang365
//
//  Created by 黄鑫 on 16/10/28.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import "AssistantMenuView.h"
#import "CheDianZhangCommon.h"

static float kMenuHeight = 40;
static float kMenuWidth = 90;

@interface AssistantMenuView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *sanjiaoImageView;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation AssistantMenuView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dataSources = [[NSMutableArray alloc] initWithCapacity:1];
        
        _sanjiaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWindowW-25, 58, 10, 6)];
        _sanjiaoImageView.image = [UIImage imageNamed:@"assistant_sanjiao"];
        [self addSubview:_sanjiaoImageView];
        _sanjiaoImageView.hidden = YES;
        
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWindowW-8-kMenuWidth, 64, kMenuWidth, 0)];
        _menuTableView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.95];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuTableView.separatorStyle = 0;
        _menuTableView.scrollEnabled = NO;
        [self addSubview:_menuTableView];
        _menuTableView.hidden = YES;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMenuView)];
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
    }
    
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

- (void) setItems:(NSArray *)items
{
    _items = items;
    [self.dataSources removeAllObjects];
    [self.dataSources addObjectsFromArray:items];
    
    [self.menuTableView reloadData];
}

- (void) showMenuView
{
    self.menuTableView.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:.08];
        self.menuTableView.frame = CGRectMake(kWindowW-8-kMenuWidth, 64, kMenuWidth, kMenuHeight*self.dataSources.count);
        self.sanjiaoImageView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) hiddenMenuView
{
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:.0];
        self.menuTableView.frame = CGRectMake(kWindowW-8-kMenuWidth, 64, kMenuWidth, 0);
        self.sanjiaoImageView.hidden = YES;
    } completion:^(BOOL finished) {
        self.menuTableView.hidden = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark- tableView delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMenuHeight;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"AssistantTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row != self.dataSources.count-1) {
            UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, kMenuHeight-1, kMenuWidth-20, 1.0)];
            bottomLine.backgroundColor = UIColorFromRGBA(0xe5e5e5, 0.6);
            [cell.contentView addSubview:bottomLine];
        }
    }
    
    cell.textLabel.text = self.dataSources[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = UIColorFromRGBA(0x333333, 1.0);
    cell.textLabel.textAlignment = 1;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didClickedMenuCallBack) {
        self.didClickedMenuCallBack(indexPath.row);
    }
    
    [self hiddenMenuView];
}

@end
