//
//  OKDownloadManager.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-18.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKEveryDayModel.h"


@interface OKDownloadManager : NSObject

@property (nonatomic,strong,readonly) NSMutableArray * downLoadList;

/**第几个任务正在下载*/
@property (nonatomic,assign,readonly) NSInteger downloadNum;

+(instancetype)manager;

-(void)addDownloadTastWithModel:(OKEveryDayModel *)model;

-(BOOL)isFileExsits:(OKEveryDayModel *)model;



@end
