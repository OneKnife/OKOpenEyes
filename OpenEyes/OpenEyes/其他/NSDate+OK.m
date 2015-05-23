//
//  NSDate+OK.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "NSDate+OK.h"

@implementation NSDate (OK)

+(NSDate *)dayDateWithDate:(NSDate *)date
{
    NSDateFormatter * df =[[NSDateFormatter alloc]init];
    df.dateFormat=@"yyyyMMdd";
    
    NSDate * dayDate =[df dateFromString:[df stringFromDate:date]];
    return dayDate;
}

+(NSString *)dayStringWithDate:(NSDate *)date
{
    
    NSDateFormatter * df =[[NSDateFormatter alloc] init];
    df.dateFormat=@"yyyyMMdd";
    NSString * dayStr =[df stringFromDate:date];
    return dayStr;
}

@end
