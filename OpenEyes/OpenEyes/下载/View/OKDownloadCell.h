//
//  OKDownloadCell.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKDownloadCell : UITableViewCell


@property (nonatomic,copy) NSString * bgImageUrl;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign) float progress;


@end
