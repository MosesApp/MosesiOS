//
//  GroupViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupTableCell.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    float viewY = statusBarHeight + navigationBarHeight;
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    float viewFullHeight = self.view.frame.size.height + statusBarHeight + navigationBarHeight;
    
    // Blue header box
    UIView *mainHeader =[[UIView alloc] initWithFrame:CGRectMake(0, viewY, viewWidth, viewHeight * 0.08)];
    mainHeader.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:66.0/255.0 blue:119.0/255.0 alpha:1.0f];
    
    [self.view addSubview:mainHeader];
    
    float mainHeaderWidth = mainHeader.frame.size.width;
    float mainHeaderHeight = mainHeader.frame.size.height;
    
    // Create group thumbnail preview
    float thumbnailImageViewHeight = mainHeaderHeight * 0.60;
    float thumbnailImageViewWidth = mainHeaderWidth * 0.08;
    float thumbnailImageViewX = mainHeaderWidth * 0.03;
    float thumbnailImageViewY = (mainHeaderHeight/2) - (thumbnailImageViewHeight/2);
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"profile_standard.jpg"];
    self.thumbnailImageView = [[UIImageView alloc] init];
    self.thumbnailImageView.image = thumbnailImage;
    
    self.thumbnailImageView.frame = CGRectMake(thumbnailImageViewX, thumbnailImageViewY, thumbnailImageViewWidth, thumbnailImageViewHeight);
    self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.size.width / 2;
    self.thumbnailImageView.clipsToBounds = YES;
    
    [mainHeader addSubview:self.thumbnailImageView];
    
    // Create "new group" label
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    titleLabel.text = @"Create new group";
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeTitleLabel = [[titleLabel text] sizeWithAttributes:@{NSFontAttributeName:[titleLabel font]}];
    
    float titleLabelWidth = textSizeTitleLabel.width;
    float titleLabelHeight = textSizeTitleLabel.height;
    float titleLabelX = mainHeaderWidth * 0.03 + thumbnailImageViewX + self.thumbnailImageView.frame.size.width;
    float titleLabelY = (mainHeaderHeight/2) - (textSizeTitleLabel.height/2);
    
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);

    [mainHeader addSubview:titleLabel];
    
    // "Done" button
    UILabel *doneButton =[[UILabel alloc] init];
    [doneButton setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
    doneButton.text = @"DONE";
    doneButton.textColor = [UIColor whiteColor];
    
    CGSize textSizeDoneButton = [[doneButton text] sizeWithAttributes:@{NSFontAttributeName:[doneButton font]}];
    
    float doneButtonX = mainHeaderWidth * 0.85;
    float doneButtonY = (mainHeaderHeight/2) - (textSizeDoneButton.height/2);
    float doneButtonWidth = textSizeDoneButton.width;
    float doneButtonHeight = textSizeDoneButton.height;
    
    doneButton.frame = CGRectMake(doneButtonX, doneButtonY, doneButtonWidth, doneButtonHeight);
    [mainHeader addSubview:doneButton];
    
    // Group name text field
    float nameFieldX = viewWidth * 0.05;
    float nameFieldY = viewY + mainHeaderHeight + (viewFullHeight * 0.02);
    float nameFieldWidth = viewWidth * 0.90;
    float nameFieldHeight = 40;
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldWidth, nameFieldHeight)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.nameField.font = [UIFont systemFontOfSize:15];
    self.nameField.placeholder = @"Enter a name for this group";
    self.nameField.delegate = self;
    
    [self.view addSubview:self.nameField];
    
    // Group image upload text field
    float uploadButtonY = nameFieldY + (viewFullHeight * 0.09);
    float uploadButtonX = viewWidth * 0.05;
    float uploadButtonWidth = viewWidth * 0.90;
    float uploadButtonHeight = 40;
    
    UIImage *uploadImage = [UIImage imageNamed:@"upload_group_picture.jpg"];
    UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadButton setImage:uploadImage forState:UIControlStateNormal];
    [uploadButton addTarget:self
                 action:@selector(selectPicture)
     forControlEvents:UIControlEventTouchUpInside];
    uploadButton.frame = CGRectMake(uploadButtonX, uploadButtonY, uploadButtonWidth, uploadButtonHeight);
    
    [self.view addSubview:uploadButton];
    
    // Green members box
    float membersHeaderY = uploadButtonY + uploadButtonHeight + (viewFullHeight * 0.02);
    float membersHeaderX = 0;
    float membersWidth = viewWidth;
    float membersHeight = viewFullHeight * 0.05;
    
    UIView *membersHeader =[[UIView alloc] initWithFrame:CGRectMake(membersHeaderX, membersHeaderY, membersWidth, membersHeight)];
    membersHeader.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:146.0/255.0 blue:66.0/255.0 alpha:1.0f];
    
    [self.view addSubview:membersHeader];
    
    // Members box label
    UILabel *membersHeaderLabel =[[UILabel alloc] init];
    [membersHeaderLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    membersHeaderLabel.text = @"Members";
    membersHeaderLabel.textColor = [UIColor whiteColor];
    
    CGSize textSizeMembersHeaderLabel = [[membersHeaderLabel text] sizeWithAttributes:@{NSFontAttributeName:[membersHeaderLabel font]}];
    
    float membersHeaderLabelWidth = textSizeMembersHeaderLabel.width;
    float membersHeaderLabelHeight = textSizeMembersHeaderLabel.height;
    float membersHeaderLabelY = (membersHeader.frame.size.height/2) - (textSizeMembersHeaderLabel.height/2);
    float membersHeaderLabelX = membersHeader.frame.size.width * 0.05;
    
    membersHeaderLabel.frame = CGRectMake(membersHeaderLabelX, membersHeaderLabelY, membersHeaderLabelWidth, membersHeaderLabelHeight);
    
    [membersHeader addSubview:membersHeaderLabel];
    
    // Members table view controller
    float membersTableViewWidth = membersWidth;
    float membersTableViewHeight = viewFullHeight - (membersHeaderY + membersHeight);
    float membersTableViewY = membersHeaderY + membersHeight;
    float membersTableViewX = membersHeaderX;
    
    self.tableViewMembers = [[UITableView alloc] init];
    self.tableViewMembers.frame = CGRectMake(membersTableViewX, membersTableViewY, membersTableViewWidth, membersTableViewHeight);
    self.tableViewMembers.separatorColor = [UIColor lightGrayColor];
    self.tableViewMembers.delegate = self;
    [self.tableViewMembers setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self.view addSubview:self.tableViewMembers];
    
}

- (void)selectPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.thumbnailImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//[groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"GroupTableCell";
    
    GroupTableCell *cell = (GroupTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableViewMembers.frame.size.height * 0.11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableViewMembers.frame.size.height * 0.15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
