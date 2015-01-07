//
//  ConnectFailViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-27.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "ConnectFailViewController.h"

@interface ConnectFailViewController ()

@end

@implementation ConnectFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Determine the size and location of the moses logo
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.60))/2, self.view.frame.size.height * 0.10, self.view.frame.size.width * 0.60, self.view.frame.size.height * 0.16)];
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    imageView.frame = logoView.bounds;
    [logoView addSubview:imageView];
    
    [self.view addSubview:logoView];
    
    // Determine the size/position of the label elements
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    label_1.text= @"Failed to connect to server.";
    CGSize textSize_1 = [[label_1 text] sizeWithAttributes:@{NSFontAttributeName:[label_1 font]}];
    CGFloat strikeWidth_1 = textSize_1.width;
    [label_1 setFrame:CGRectMake((self.view.frame.size.width - strikeWidth_1)/2, self.view.frame.size.height * 0.30, self.view.frame.size.width * 0.80, self.view.frame.size.height * 0.16)];
    label_1.backgroundColor=[UIColor clearColor];
    label_1.textColor=[UIColor blackColor];
    label_1.userInteractionEnabled=YES;
    
    [self.view addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    label_2.text= @"Try again later!";
    CGSize textSize_2 = [[label_2 text] sizeWithAttributes:@{NSFontAttributeName:[label_2 font]}];
    CGFloat strikeWidth_2 = textSize_2.width;
    [label_2 setFrame:CGRectMake((self.view.frame.size.width - strikeWidth_2)/2, self.view.frame.size.height * 0.40, self.view.frame.size.width * 0.80, self.view.frame.size.height * 0.16)];
    label_2.backgroundColor=[UIColor clearColor];
    label_2.textColor=[UIColor blackColor];
    label_2.userInteractionEnabled=YES;
    
    [self.view addSubview:label_2];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)dealloc { NSLog(@"dealloc - %@",[self class]); } 

@end
