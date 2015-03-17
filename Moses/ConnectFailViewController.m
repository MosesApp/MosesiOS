//
//  ConnectFailViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-27.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "ConnectFailViewController.h"
#import "User.h"

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
    UILabel *warningLabel = [[UILabel alloc] init];
    warningLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    warningLabel.text= @"Failed connecting to server.";
    CGSize warningLabelSize = [[warningLabel text] sizeWithAttributes:@{NSFontAttributeName:[warningLabel font]}];
    CGFloat warningLabelWidth = warningLabelSize.width;
    [warningLabel setFrame:CGRectMake((self.view.frame.size.width - warningLabelWidth)/2, self.view.frame.size.height * 0.30, self.view.frame.size.width * 0.80, self.view.frame.size.height * 0.16)];
    warningLabel.backgroundColor=[UIColor clearColor];
    warningLabel.textColor=[UIColor blackColor];
    warningLabel.userInteractionEnabled=YES;
    
    [self.view addSubview:warningLabel];
    
    
    // Create the button and assign the image
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *retryButtonImage = [UIImage imageNamed:@"tryagain_button.jpg"];
    
    [retryButton setFrame:CGRectMake((self.view.frame.size.width - retryButtonImage.size.width)/2, self.view.frame.size.height * 0.45, retryButtonImage.size.width, retryButtonImage.size.height)];
    
    [retryButton setImage:retryButtonImage forState:UIControlStateNormal];
    [retryButton addTarget:self action:@selector(retryEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:retryButton];
    
}

- (void)retryEvent
{
    UIViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"FBLoginViewController"];
    
    self.view.window.rootViewController = loginController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
