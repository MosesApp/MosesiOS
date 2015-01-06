//
//  PageContentViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-14.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
}

- (void)dealloc { NSLog(@"dealloc - %@",[self class]); } 

@end
