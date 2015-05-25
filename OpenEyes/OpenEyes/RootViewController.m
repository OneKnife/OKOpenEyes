//
//  RootViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "RootViewController.h"
#import "UPStackMenu.h"

@interface RootViewController ()<UPStackMenuDelegate>

@end

@implementation RootViewController
{
        UPStackMenu * _stack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationBar];
}

-(void)customNavigationBar
{
    
    UIButton * leftButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setBackgroundColor:[UIColor blackColor]];
    [leftButton setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    
    UIBarButtonItem * leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
    
    //定制菜单
    _stack = [[UPStackMenu alloc] initWithContentView:leftBarButton];
    [_stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [_stack setDelegate:self];
    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"square"] highlightedImage:nil title:@"Square"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"circle"] highlightedImage:nil title:@"Circle"];
    UPStackMenuItem *triangleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"triangle"] highlightedImage:nil title:@"Triangle"];
    UPStackMenuItem *crossItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@"Cross"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, triangleItem, crossItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor whiteColor]];
    }];

    [_stack setAnimationType:UPStackMenuAnimationType_progressive];
    [_stack setStackPosition:UPStackMenuStackPosition_down];
    [_stack setOpenAnimationDuration:.4];
    [_stack setCloseAnimationDuration:.4];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setLabelPosition:UPStackMenuItemLabelPosition_right];
        [item setLabelPosition:UPStackMenuItemLabelPosition_left];
    }];

    [_stack addItems:items];
    [self.view addSubview:_stack];
    
    
    
    
    
}


#pragma mark - UPStackMenuDelegate

- (void)stackMenuWillOpen:(UPStackMenu *)menu
{
   
}

- (void)stackMenuWillClose:(UPStackMenu *)menu
{

}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index
{
    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
