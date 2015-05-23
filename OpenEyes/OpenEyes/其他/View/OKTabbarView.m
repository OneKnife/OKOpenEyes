//
//  OKTabbarView.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKTabbarView.h"

@implementation OKTabbarView
{
    NSMutableArray * _buttonArray;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:frame])
    {
        _buttonArray=[[NSMutableArray alloc] init];
    }
    return self;

}


-(void)addTabbarButtonWithItem:(UITabBarItem *)item
{
    UIButton * button =[[UIButton alloc] init];

    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:button];
    [_buttonArray addObject:button];
}

-(void)layoutSubviews
{
    for (NSInteger i =0; i<_buttonArray.count; i++) {
        UIButton * button =_buttonArray[i];
        button.frame=CGRectMake(SCREEN_WIDTH/_buttonArray.count * i, 0, SCREEN_WIDTH/_buttonArray.count, self.frame.size.height);
        button.tag=i;
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)buttonOnClick:(UIButton *)button
{
    [self.delegate didSelectButtonWithIndex:button.tag];
}


@end
