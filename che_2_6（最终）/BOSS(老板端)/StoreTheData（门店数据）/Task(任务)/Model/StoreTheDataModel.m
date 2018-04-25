//
//  StoreTheDataModel.m
//  cheDianZhang
//
//  Created by apple on 2018/4/21.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataModel.h"

@implementation StoreTheDataModel

-(void)setdataDict:(NSDictionary *)dict
{
    NSDictionary *work_infoC1 = KISDictionaryHaveKey(dict, @"work_info");
    self.work_info = [[Work_infoModel alloc]init];
    [self.work_info setdataDict:work_infoC1];
    
    NSMutableArray * Staff_listC =[[NSMutableArray alloc]init];
    NSArray * Staff_listC1 = KISDictionaryHaveKey(dict, @"staff_list");
    if(Staff_listC1.count>0){
        for (int i =0; i<Staff_listC1.count; i++) {
            Staff_listModel * model = [[Staff_listModel alloc]init];
            [model setdataDict:Staff_listC1[i]];
            [Staff_listC addObject:model];
        }
    }
    self.staff_list = Staff_listC;
    
    NSMutableArray *Task_listC = [[NSMutableArray alloc]init];
    NSArray * Task_listC1 = [[NSArray alloc]init];
    if(Task_listC1.count>0){
        for (int i=0; i<Task_listC1.count; i++) {
            Task_listModel * model = [[Task_listModel alloc]init];
            [model setdataDict:Task_listC1[i]];
            [Task_listC addObject:model];
        }
    }
    self.task_list = Task_listC;
}

@end


@implementation Work_infoModel
-(void)setdataDict:(NSDictionary *)dict
{
    self.total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"total")];
    self.undone = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"undone")];
    self.inval = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"inval")];
    self.done = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"done")];
    self.appoint = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appoint")];
    self.arrival = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"arrival")];
    self.other_consume = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"other_consume")];
    self.arrival_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"arrival_p")];
    self.appoint_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appoint_p")];
    self.other_consume_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"other_consume_p")];
    self.done_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"done_p")];
    self.inval_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"inval_p")];
    self.undone_p = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"undone_p")];
    self.appoint_p1 = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appoint_p1")];
}

@end


@implementation Staff_listModel
-(void)setdataDict:(NSDictionary *)dict
{
    self.appoint = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appoint")];
    self.arrival = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"arrival")];
    self.real_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"real_name")];
    self.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_id")];
}

@end

@implementation Task_listModel
-(void)setdataDict:(NSDictionary *)dict
{
    self.total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"total")];
    self.undone = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"undone")];
    self.done = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"done")];
    self.inval = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"inval")];
    self.appoint = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appoint")];
    self.task_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"task_name")];
}

@end
