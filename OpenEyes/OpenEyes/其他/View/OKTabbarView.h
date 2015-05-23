//
//  OKTabbarView.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OKTabbarViewDelegate <NSObject>

-(void)didSelectButtonWithIndex:(NSInteger)index;

@end


@interface OKTabbarView : UIView

@property (nonatomic,weak) id<OKTabbarViewDelegate> delegate;


-(void)addTabbarButtonWithItem:(UITabBarItem *)item;

@end
