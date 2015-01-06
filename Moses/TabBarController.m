//
//  TabBarController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-26.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    [tabBarItem1 setImage:[[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"home_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    tabBarItem1.title = nil;
    
    
    [tabBarItem2 setImage:[[UIImage imageNamed:@"newgroup.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"newgroup_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    tabBarItem2.title = nil;

    [tabBarItem3 setImage:[[UIImage imageNamed:@"newbill.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"newbill_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem3 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    tabBarItem3.title = nil;
    
    [tabBarItem4 setImage:[[UIImage imageNamed:@"configuration.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem4 setSelectedImage:[[UIImage imageNamed:@"configuration_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem4 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    tabBarItem4.title = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)dealloc { NSLog(@"dealloc - %@",[self class]); } 

@end
