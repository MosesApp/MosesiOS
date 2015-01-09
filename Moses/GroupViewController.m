//
//  GroupViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Blue header box
    UIView *header =[[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height,self.view.frame.size.width, self.view.frame.size.height * 0.12)];
    header.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:66.0/255.0 blue:119.0/255.0 alpha:1.0f];
    
    // Create new group label
    UILabel *titleLabel =[[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    titleLabel.text = @"Create new group";
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeTitleLabel = [[titleLabel text] sizeWithAttributes:@{NSFontAttributeName:[titleLabel font]}];
    
    titleLabel.frame = CGRectMake(header.frame.size.width * 0.05, header.frame.size.height/2, textSizeTitleLabel.width, textSizeTitleLabel.height);

    // Done button
    UILabel *doneButton =[[UILabel alloc] init];
    [doneButton setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
    doneButton.text = @"DONE";
    doneButton.textColor = [UIColor whiteColor];
    
    CGSize textSizeDoneButton = [[doneButton text] sizeWithAttributes:@{NSFontAttributeName:[doneButton font]}];
    
    doneButton.frame = CGRectMake(header.frame.size.width * 0.85, header.frame.size.height/2, textSizeDoneButton.width, textSizeDoneButton.height);
    
    [header addSubview:titleLabel];
    [header addSubview:doneButton];
    [self.view addSubview:header];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
