//
//  OKDownloadTask.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKEveryDayModel.h"
#import <UIKit/UIKit.h>

@interface OKDownloadTask : NSObject

-(instancetype)initWithModel:(OKEveryDayModel*)model;

@property (nonatomic,strong,readonly) OKEveryDayModel * model;

@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,assign,getter=isDownloading) BOOL downloading;
@property (nonatomic,assign,getter=isComplete) BOOL complete;
@property (nonatomic,copy) NSString * downloadBytes;
@property (nonatomic,copy) NSString * totalBytes;
@property (nonatomic,copy) NSString * error;


-(void)start;
-(void)pause;
-(void)resume;
-(void)stop;

@end
