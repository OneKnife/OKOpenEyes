//
//  OKDownloadManager.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadManager.h"
#import "OKDownloadTask.h"

static OKDownloadManager * manager;

@implementation OKDownloadManager

+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[OKDownloadManager alloc] init];
        
        
    });
    
    return manager;
}

-(instancetype)init
{
    if (self=[super  init]) {
        _downLoadList=[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addDownloadTastWithModel:(OKEveryDayModel *)model
{
    OKDownloadTask * task =[[OKDownloadTask alloc] initWithModel:model];
    [_downLoadList addObject:task];
    
    [task start];
    for (NSInteger i =0; i<_downLoadList.count-1; i++) {
        
        OKDownloadTask * task = _downLoadList[i];
        if (task.isDownloading==YES) {
            [task pause];
            break;
        }
    }
    
}

-(BOOL)isFileExsits:(OKEveryDayModel *)model
{
    for (OKDownloadTask * task in _downLoadList) {
        if (task.model==model) {
            return YES;
        }
    }
    return NO;
}


@end
