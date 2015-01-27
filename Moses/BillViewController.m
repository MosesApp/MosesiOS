//
//  BillViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-11.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "BillViewController.h"

@interface BillViewController ()

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show logo at the top of table view
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = YES;
    
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float viewYBeginning = statusBarHeight + navigationBarHeight;
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    
    // Blue header box
    UIView *mainHeader =[[UIView alloc] initWithFrame:CGRectMake(0, viewYBeginning, viewWidth, viewHeight * 0.08)];
    mainHeader.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:66.0/255.0 blue:119.0/255.0 alpha:1.0f];
    
    [self.view addSubview:mainHeader];
    
    // Create new group label
    UILabel *titleLabel =[[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    titleLabel.text = @"Create new bill";
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeTitleLabel = [[titleLabel text] sizeWithAttributes:@{NSFontAttributeName:[titleLabel font]}];
    
    float mainHeaderWidth = mainHeader.frame.size.width;
    float mainHeaderHeight = mainHeader.frame.size.height;
    float titleLabelYPosition = (mainHeaderHeight/2) - (textSizeTitleLabel.height/2);
    
    
    titleLabel.frame = CGRectMake(mainHeaderWidth * 0.05, titleLabelYPosition, textSizeTitleLabel.width, textSizeTitleLabel.height);
    
    [mainHeader addSubview:titleLabel];
    
    // Done button
    UILabel *doneButton =[[UILabel alloc] init];
    [doneButton setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
    doneButton.text = @"DONE";
    doneButton.textColor = [UIColor whiteColor];
    
    CGSize textSizeDoneButton = [[doneButton text] sizeWithAttributes:@{NSFontAttributeName:[doneButton font]}];
    
    float doneButtonYPosition = (mainHeaderHeight/2) - (textSizeDoneButton.height/2);
    
    doneButton.frame = CGRectMake(mainHeaderWidth * 0.85, doneButtonYPosition, textSizeDoneButton.width, textSizeDoneButton.height);
    
    [mainHeader addSubview:doneButton];
    
    // Bill name text field
    float nameFieldY = viewYBeginning + mainHeaderHeight + (viewHeight * 0.02);
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, nameFieldY, viewWidth * 0.90, 40)];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    nameField.font = [UIFont systemFontOfSize:15];
    nameField.placeholder = @"Enter a name for this bill";
    
    [self.view addSubview:nameField];
    
    // Bill description text field
    float descriptionFieldY = nameFieldY + mainHeaderHeight + (viewHeight * 0.02);
    
    UITextField *descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, descriptionFieldY, viewWidth * 0.90, 40)];
    descriptionField.borderStyle = UITextBorderStyleRoundedRect;
    descriptionField.layer.borderColor = [[UIColor clearColor]CGColor];
    descriptionField.font = [UIFont systemFontOfSize:15];
    descriptionField.placeholder = @"Enter a description for this bill";
    
    [self.view addSubview:descriptionField];
    
    
    // Bill amout text field
    float amountFieldY = descriptionFieldY + mainHeaderHeight + (viewHeight * 0.02);
    
    UITextField *amountField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, amountFieldY, viewWidth * 0.90, 40)];
    amountField.borderStyle = UITextBorderStyleRoundedRect;
    amountField.layer.borderColor = [[UIColor clearColor]CGColor];
    amountField.font = [UIFont systemFontOfSize:15];
    amountField.placeholder = @"Enter an amount";
    
    [self.view addSubview:amountField];
    
    // Bill members box
    float membersHeaderY = amountFieldY + descriptionField.frame.size.height + (viewHeight * 0.05);
    
    UIView *membersHeader =[[UIView alloc] initWithFrame:CGRectMake(0, membersHeaderY, viewWidth, viewHeight * 0.05)];
    membersHeader.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:146.0/255.0 blue:66.0/255.0 alpha:1.0f];
    
    [self.view addSubview:membersHeader];
    
    
    // Members box label
    UILabel *membersHeaderLabel =[[UILabel alloc] init];
    [membersHeaderLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    membersHeaderLabel.text = @"Members";
    membersHeaderLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeMembersHeaderLabel = [[membersHeaderLabel text] sizeWithAttributes:@{NSFontAttributeName:[membersHeaderLabel font]}];
    
    float membersHeaderWidth = membersHeader.frame.size.width;
    float membersHeaderHeight = membersHeader.frame.size.height;
    float membersHeaderLabelYPosition = (membersHeaderHeight/2) - (textSizeMembersHeaderLabel.height/2);
    
    
    membersHeaderLabel.frame = CGRectMake(membersHeaderWidth * 0.05, membersHeaderLabelYPosition, textSizeMembersHeaderLabel.width, textSizeMembersHeaderLabel.height);
    
    [membersHeader addSubview:membersHeaderLabel];
    
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
