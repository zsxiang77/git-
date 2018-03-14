//
//  LCMessageListView.m
//  测试
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//
#define kLMEChatCellStretchImage(image, edgeInsets) [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch]



#import "LCMessageListView.h"
#import "LCMessageViewModel.h"
//#import "UITableView+FDTemplateLayoutCell.h"

@interface LCMessageListViewCell();
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UILabel *messageLB;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIView *msgView;
@end

@implementation LCMessageListViewCell
- (void)setUpViews{
    self.timeLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.backgroundColor = UIColorHex(#EFEFEF);
        lb.layer.cornerRadius = 15;
        lb.layer.masksToBounds = YES;
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:11];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentCenter;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(13);
            make.size.mas_equalTo(CGSizeMake(77.5, 30));
        }];
        lb.text = @"10-12 12:00";
        lb;
    });
    
    self.msgView = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLB.mas_right).mas_offset(5);
            make.top.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(kScreenWidth - 100 - 15).priorityHigh();
            make.bottom.mas_equalTo(0).priorityLow();
        }];
        vi;
    });
    
     self.imageViewBack = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.msgView addSubview:im];
         [im mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
         }];
         im.contentMode = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage imageNamed:@"meassge_background"];
        im.image = kLMEChatCellStretchImage(image, UIEdgeInsetsMake(23, 10, 10, 7));
        im;
    });
    
    
    self.messageLB = ({
        UILabel *lb = [[UILabel alloc]init];
        lb.numberOfLines = 0;
        [self.msgView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(9, 18.5, 9, 13.5));
        }];
        lb.lineBreakMode = NSLineBreakByWordWrapping;
        lb;
    });
}

- (void)bingViewModel:(id)viewModel{
    LCMessageViewModel *model = viewModel;
    self.timeLB.text    = model.time;
    self.messageLB.text = model.message;
    
//    self.imageViewBack.width = model.imageView_W;
//    self.imageViewBack.height = model.imageView_H;
}
@end


@interface LCMessageListView() <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *tableViewHeaderViewLB;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UILabel *tishiLB;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *wuGuZhangLB;
@end

@implementation LCMessageListView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews1];
        self.backgroundColor = [UIColor whiteColor];
        self.dataArr = [CreatOrderFlowChartManager defaultOrderFlowChartManager].messageVModelArr;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)setUpViews1
{
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[LCMessageListViewCell class] forCellReuseIdentifier:@"LCMessageListViewCell"];
        [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.hidden = NO;
        tableView.tableFooterView = [UIView new];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView;
    });
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
    
     self.header = ({
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
         v.backgroundColor = [UIColor whiteColor];
        UIImageView * leftView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        leftView.image = [UIImage imageNamed:@"故障描述"];
        [v addSubview:leftView];
        UILabel *lb = ({
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(38, 15, 64, 20)];
            [v addSubview:lb];
            lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
            lb.textColor = UIColorHex(#333333);
            lb.textAlignment = NSTextAlignmentLeft;
            lb.text = @"故障描述";
            lb;
        });
        self.tableViewHeaderViewLB = ({
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(112, 15, 64, 20)];
            [v addSubview:lb];
            lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
            lb.textColor = UIColorHex(#333333);
            lb.textAlignment = NSTextAlignmentLeft;
//            lb.text = @"(2)";
            lb;
        });
        v;
    });
//    self.tableView.tableHeaderView = header;
    
    
    self.imageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self addSubview:im];
        im.image = [UIImage imageNamed:@"暂无故障描述"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.top.mas_equalTo(100);
        }];
        im;
    });
    
    self.wuGuZhangLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self addSubview:lb];
        lb.font =  [UIFont systemFontOfSize:12];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_equalTo(15);
            make.centerX.mas_equalTo(0);
        }];
        lb.text = @"暂无故障描述";
        lb;
    });

    
    self.tishiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self addSubview:lb];
        lb.font = [UIFont systemFontOfSize:13];
        lb.textColor = UIColorHex(#666666);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-25);
        }];
        lb.text = @"请输入故障描述  ↓";
        lb;
    });

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCMessageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMessageListViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bingViewModel:self.dataArr[indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.header;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    <#SectionFooterViewClass#> *footerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:<#Identifier#>];
//    return footerView;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCMessageViewModel *vm = self.dataArr[indexPath.row];
    return vm.cell_H;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        self.tableViewHeaderViewLB.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)self.dataArr.count];
        [self.tableView reloadData];
        if (self.dataArr.count == 0) {
            [self showPromptViews];
            self.tableViewHeaderViewLB.text = nil;
        }
    }
}


- (void)addMessageViewModel:(LCMessageViewModel *)vmodel{
    [self.dataArr addObject:vmodel];
    self.tableViewHeaderViewLB.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)self.dataArr.count];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0]; //刷新第0段第2行
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)addMessageViewModels:(NSArray<LCMessageViewModel *> *)dataArr{
    [self.dataArr addObjectsFromArray:dataArr];
    if (self.dataArr.count> 0) {
        [self hidenPromptViews];
    }
    [self.tableView reloadData];
    self.tableViewHeaderViewLB.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)self.dataArr.count];
    
}

- (void)hidenPromptViews{
    self.wuGuZhangLB.hidden = YES;
    self.imageView.hidden = YES;
    self.tishiLB.hidden = YES;
}

- (void)showPromptViews{
    self.wuGuZhangLB.hidden = NO;
    self.imageView.hidden = NO;
    self.tishiLB.hidden = NO;
}

- (void)KeyboardWillShowNotification:(NSNotification *)notification{
    [self hidenPromptViews];
}

- (void)KeyboardWillHideNotification:(NSNotification *)notification{
    if (self.dataArr.count == 0) {
        [self showPromptViews];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
