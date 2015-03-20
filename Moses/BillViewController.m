//
//  BillViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-11.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "BillViewController.h"
#import "ActionSheetStringPicker.h"

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
    
    float mainHeaderWidth = mainHeader.frame.size.width;
    float mainHeaderHeight = mainHeader.frame.size.height;
    
    // Create group thumbnail preview
    float thumbnailImageViewHeight = mainHeaderHeight * 0.60;
    float thumbnailImageViewWidth = mainHeaderWidth * 0.09;
    float thumbnailImageViewX = mainHeaderWidth * 0.03;
    float thumbnailImageViewY = (mainHeaderHeight/2) - (thumbnailImageViewHeight/2);
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"bill_standard.jpg"];
    self.thumbnailImageView = [[UIImageView alloc] init];
    self.thumbnailImageView.image = thumbnailImage;
    
    self.thumbnailImageView.frame = CGRectMake(thumbnailImageViewX, thumbnailImageViewY, thumbnailImageViewWidth, thumbnailImageViewHeight);
    self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.size.width / 2;
    self.thumbnailImageView.clipsToBounds = YES;
    
    [mainHeader addSubview:self.thumbnailImageView];
    
    // Create new bill label
    UILabel *titleLabel =[[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    titleLabel.text = @"Create new bill";
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeTitleLabel = [[titleLabel text] sizeWithAttributes:@{NSFontAttributeName:[titleLabel font]}];
    
    float titleLabelWidth = textSizeTitleLabel.width;
    float titleLabelHeight = textSizeTitleLabel.height;
    float titleLabelX = mainHeaderWidth * 0.03 + thumbnailImageViewX + self.thumbnailImageView.frame.size.width;
    float titleLabelY = (mainHeaderHeight/2) - (textSizeTitleLabel.height/2);

        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    [mainHeader addSubview:titleLabel];
    
    // Done button
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(registerBill)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // Bill name text field
    float nameFieldY = viewYBeginning + mainHeaderHeight + (viewHeight * 0.02);
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, nameFieldY, viewWidth * 0.90, 40)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.nameField.font = [UIFont systemFontOfSize:15];
    self.nameField.placeholder = @"Enter a name for this bill";
    
    [self.view addSubview:self.nameField];
    
    // Bill description text field
    float descriptionFieldY = nameFieldY + mainHeaderHeight + (viewHeight * 0.02);
    
    self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, descriptionFieldY, viewWidth * 0.90, 40)];
    self.descriptionField.borderStyle = UITextBorderStyleRoundedRect;
    self.descriptionField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.descriptionField.font = [UIFont systemFontOfSize:15];
    self.descriptionField.placeholder = @"Enter a description for this bill";
    
    [self.view addSubview:self.descriptionField];

    // Bill group dropdowm field
    float groupFieldY = descriptionFieldY + mainHeaderHeight + (viewHeight * 0.02);
    
    self.groupField = [[UITextField alloc] initWithFrame:CGRectMake(viewWidth * 0.05, groupFieldY, viewWidth * 0.90, 40)];
    self.groupField.delegate = self;
    self.groupField.borderStyle = UITextBorderStyleRoundedRect;
    self.groupField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.groupField.font = [UIFont systemFontOfSize:15];
    self.groupField.placeholder = @"Associate a group to the bill";
    
    [self.view addSubview:self.groupField];
    
    // Bill members box
    float membersHeaderY = groupFieldY + self.groupField.frame.size.height + (viewHeight * 0.05);
    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    // Create an array of strings you want to show in the picker:
    NSArray *groups = [NSArray arrayWithObjects:@"Group1", @"Group2", @"Group3", @"Group4", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Group"
                                            rows:groups
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %d", selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           textField.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                    origin:self.view];
    return NO;
}

-(void)registerBill{

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
