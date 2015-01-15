//
//  ConfigurationViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-05.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "User.h"
#import "Group.h"
#import "Bill.h"
#import "AppDelegate.h"

@interface ConfigurationViewController ()

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show logo at the top of table view
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = YES;
    
    // Determine the size and location of the moses logo
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.60))/2, self.view.frame.size.height * 0.15, self.view.frame.size.width * 0.60, self.view.frame.size.height * 0.16)];
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    imageView.frame = logoView.bounds;
    [logoView addSubview:imageView];
    
    [self.view addSubview:logoView];
    
    // Details text area
    UITextView *detailsText = [[UITextView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.70))/2, self.view.frame.size.height * 0.40, self.view.frame.size.width * 0.70, self.view.frame.size.height * 0.50)];
    detailsText.textColor = [UIColor blackColor];
    detailsText.font = [UIFont fontWithName:@"Arial" size:15];
    detailsText.text=@"O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500.";
    detailsText.editable = NO;
    
    [self.view addSubview:detailsText];
    
    UIImage *linkButtonImage = [UIImage imageNamed:@"website_link.png"];
    
    // Create the button and assign the image
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    linkButton.frame = CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.50))/2, self.view.frame.size.height * 0.65, self.view.frame.size.width * 0.50, linkButtonImage.size.height * 0.70);
    
    [linkButton setImage:linkButtonImage forState:UIControlStateNormal];
    [linkButton addTarget:self action:@selector(openWebsiteLink) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:linkButton];
    
    // Add facebook button
    _loginFacebookButtonView = [[FBLoginView alloc] init];
    // Add delegate
    _loginFacebookButtonView.delegate = self;
    
    // Determine the size of the facebook button
    _loginFacebookButtonView.frame = CGRectMake((self.view.frame.size.width - (self.view.frame.size.width * 0.70))/2, self.view.frame.size.height * 0.80, self.view.frame.size.width * 0.70, self.view.frame.size.height * 0.50);
    
    [self.view addSubview:_loginFacebookButtonView];
}

-(void)openWebsiteLink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.mosesapp.me"]];
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    UIViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"FBLoginViewController"];
    
    self.view.window.rootViewController = loginController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _loginFacebookButtonView = nil;
    NSLog(@"dealloc - %@",[self class]);
}
@end
