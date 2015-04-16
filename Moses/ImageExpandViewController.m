//
//  ImageExpandViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-03-28.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "ImageExpandViewController.h"

@implementation ImageExpandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show logo at the top of table view
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = YES;

    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float viewY = statusBarHeight + navigationBarHeight;
    float viewWidth = self.view.frame.size.width;
    float viewTabBarHeight = self.tabBarController.tabBar.frame.size.height;
    float viewFullHeight = self.view.frame.size.height - (statusBarHeight + navigationBarHeight + viewTabBarHeight);
    
    self.imageView.frame = CGRectMake(0, viewY, viewWidth, viewFullHeight);
    [self.view addSubview:self.imageView];
    
}

- (void)setImage:(UIImage *)image{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = image;
}

- (void)dealloc {
    _imageView = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
