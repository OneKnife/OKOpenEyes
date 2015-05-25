//
//  OKDownloadManager.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-18.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKEveryDayModel.h"
#import "OKDownloadTask.h"

@interface OKDownloadManager : NSObject

/**下载中的任务*/
@property (nonatomic,strong,readonly) NSMutableArray * downLoadList;

/**已下载的任务*/
@property (nonatomic,strong,readonly) NSMutableArray * downloadedList;

/**第几个任务正在下载*/
@property (nonatomic,assign,readonly) NSInteger downloadNum;

+(instancetype)manager;

-(void)addDownloadTastWithModel:(OKEveryDayModel *)model;

-(BOOL)isFileExsits:(OKEveryDayModel *)model;


-(void)selectWithIndex:(NSInteger)index;

-(void)endDownloadWithTask:(OKDownloadTask *)task;

@end
