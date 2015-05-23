//
//  OKEveryDayDataModel.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKEveryDayDataModel : NSObject


@property (nonatomic,strong) NSMutableArray * dailyList;//
@property (nonatomic,copy) NSString * nextPageUrl;// : "http://baobab.wandoujia.com/api/v1/feed?date=20150501&num=10"
@property (nonatomic,strong) NSNumber * nextPublishTime;// : 1431392400000

@end
