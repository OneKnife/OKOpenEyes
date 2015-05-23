//
//  OKTabBarController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKTabBarController.h"
#import "OKEveryDayViewController.h"
#import "OKPreviousClassifyViewController.h"
#import "OKTabbarView.h"

@interface OKTabBarController ()<OKTabbarViewDelegate>

@end

@implementation OKTabBarController
{
    OKTabbarView * _tabbar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customTabbar];
    [self addViewControllers];
//    [self customTabbar];
}



-(void)addViewControllers
{
    OKEveryDayViewController * everyController =[[OKEveryDayViewController alloc] init];
    UINavigationController * eveNav =[[UINavigationController alloc]initWithRootViewController:everyController];
    everyController.title=@"每日推荐";
    [_tabbar addTabbarButtonWithItem:eveNav.tabBarItem];
    
    OKPreviousClassifyViewController * previousController =[[OKPreviousClassifyViewController alloc] init];
    UINavigationController * preNav =[[UINavigationController alloc]initWithRootViewController:previousController] ;
    previousController.title=@"往期分类";
    [_tabbar addTabbarButtonWithItem:preNav.tabBarItem];
    
    self.viewControllers=@[eveNav,preNav];
    self.tabBar.frame=CGRectMake(0, SCREEN_HEIGHT-35, SCREEN_WIDTH, 35);
    
}

-(void)customTabbar
{
    _tabbar =[[OKTabbarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    _tabbar.delegate=self;
    
    [self.tabBar addSubview:_tabbar];
}

-(void)didSelectButtonWithIndex:(NSInteger)index
{
    self.selectedIndex=index;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    for (UIView * view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
