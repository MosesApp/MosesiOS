//
//  GroupViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupTableCell.h"
#import "ImageExpandViewController.h"
#import "FBFriend.h"
#import "Group.h"
#import "User.h"
#import "NSString+FormValidation.h"
#import "MBProgressHUD.h"

@interface GroupViewController ()
{
    NSMutableArray *fbFriends;
    NSDictionary* retMessage;
    CGRect membersTableViewFrame;
    CGRect addMemberButtonFrame;
    BOOL imageUploaded;
}
@end

@implementation GroupViewController

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
    float viewHeight = self.view.frame.size.height;
    float viewFullHeight = self.view.frame.size.height + statusBarHeight + navigationBarHeight;
    float viewTabBarHeight = self.tabBarController.tabBar.frame.size.height;
    
    // Blue header box
    UIView *mainHeader =[[UIView alloc] initWithFrame:CGRectMake(0, viewY, viewWidth, viewHeight * 0.08)];
    mainHeader.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:66.0/255.0 blue:119.0/255.0 alpha:1.0f];
    
    [self.view addSubview:mainHeader];
    
    float mainHeaderWidth = mainHeader.frame.size.width;
    float mainHeaderHeight = mainHeader.frame.size.height;
    
    // Create group thumbnail preview
    float thumbnailImageViewHeight = mainHeaderHeight * 0.60;
    float thumbnailImageViewWidth = mainHeaderWidth * 0.09;
    float thumbnailImageViewX = mainHeaderWidth * 0.03;
    float thumbnailImageViewY = (mainHeaderHeight/2) - (thumbnailImageViewHeight/2);
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"profile_standard.jpg"];
    self.thumbnailImageView = [[UIImageView alloc] init];
    self.thumbnailImageView.image = thumbnailImage;
    
    self.thumbnailImageView.frame = CGRectMake(thumbnailImageViewX, thumbnailImageViewY, thumbnailImageViewWidth, thumbnailImageViewHeight);
    self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.size.width / 2;
    self.thumbnailImageView.clipsToBounds = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullImageTapped:)];
    singleTap.numberOfTapsRequired = 1;
    [self.thumbnailImageView setUserInteractionEnabled:YES];
    [self.thumbnailImageView addGestureRecognizer:singleTap];
    
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
    
    // Done button
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(registerGroup)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
    // Group name text field
    float nameFieldX = viewWidth * 0.05;
    float nameFieldY = viewY + mainHeaderHeight + (viewFullHeight * 0.02);
    float nameFieldWidth = viewWidth * 0.90;
    float nameFieldHeight = viewFullHeight * 0.06;
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldWidth, nameFieldHeight)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.nameField.font = [UIFont systemFontOfSize:15];
    self.nameField.placeholder = @"Enter a name for this group";
    self.nameField.delegate = self;
    
    [self.view addSubview:self.nameField];
    
    // Upload profile button
    float uploadButtonY = nameFieldY + (viewFullHeight * 0.09);
    float uploadButtonX = viewWidth * 0.15;
    float uploadButtonWidth = viewWidth * 0.70;
    float uploadButtonHeight = viewFullHeight * 0.06;
    
    UIImage *uploadImage = [UIImage imageNamed:@"upload_group_picture.png"];
    UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadButton setImage:uploadImage forState:UIControlStateNormal];
    [uploadButton addTarget:self
                 action:@selector(selectPicture)
     forControlEvents:UIControlEventTouchUpInside];
    uploadButton.frame = CGRectMake(uploadButtonX, uploadButtonY, uploadButtonWidth, uploadButtonHeight);
    // Check if user selected an image
    imageUploaded = FALSE;
    
    [self.view addSubview:uploadButton];
    
    // Group members box
    float membersHeaderY = uploadButtonY + uploadButtonHeight + (viewFullHeight * 0.02);
    float membersHeaderX = 0;
    float membersHeaderWidth = viewWidth;
    float membersHeaderHeight = viewFullHeight * 0.05;
    
    UIView *membersHeader =[[UIView alloc] initWithFrame:CGRectMake(membersHeaderX, membersHeaderY, membersHeaderWidth, membersHeaderHeight)];
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
    float membersTableViewWidth = membersHeaderWidth;
    float membersTableViewHeight = (viewHeight - (membersHeaderHeight + membersHeaderY + viewTabBarHeight)) * 0.80;
    float membersTableViewY = membersHeaderY + membersHeaderHeight;
    float membersTableViewX = membersHeaderX;
    membersTableViewFrame = CGRectMake(membersTableViewX, membersTableViewY, membersTableViewWidth, membersTableViewHeight);
    
    self.tableViewMembers = [[UITableView alloc] init];
    self.tableViewMembers.frame = CGRectMake(0, 0, 0, 0);
    self.tableViewMembers.separatorColor = [UIColor lightGrayColor];
    self.tableViewMembers.delegate = self;
    [self.tableViewMembers setDataSource:self];
    
    [self.view addSubview:self.tableViewMembers];
    
    // Add person to group button
    float addMemberButtonY = membersTableViewY + (viewFullHeight * 0.02);
    float addMemberButtonX = viewWidth * 0.19;
    float addMemberButtonWidth = viewWidth * 0.62;
    float addMemberButtonHeight = viewFullHeight * 0.03;
    
    UIImage *addMemberImage = [UIImage imageNamed:@"add_member.png"];
    UIButton *addMemberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addMemberButton setImage:addMemberImage forState:UIControlStateNormal];
    [addMemberButton addTarget:self
                        action:@selector(addMemberToGroup:)
           forControlEvents:UIControlEventTouchUpInside];
    
    addMemberButtonFrame = CGRectMake(addMemberButtonX, addMemberButtonY, addMemberButtonWidth, addMemberButtonHeight);
    addMemberButton.frame = addMemberButtonFrame;
    addMemberButton.tag = 100;
    
    [self.view addSubview:addMemberButton];
}

- (void)registerGroup{

    NSString *errorMessage = [self validateForm];
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    
    User *user = [User sharedUser];
    NSMutableArray* members = [[NSMutableArray alloc] init];

    for(int i = 0; i < fbFriends.count; i++){
        if([fbFriends[i] selected]){
            BOOL administrator = FALSE;
        
            NSArray *keys = [NSArray arrayWithObjects:@"user_facebook", @"administrator", nil];
            NSArray *objects = [NSArray arrayWithObjects:[fbFriends[i] facebookId], [NSNumber numberWithBool:administrator], nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects
                                                               forKeys:keys];
            [members addObject: dictionary];
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Creating Group";
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        UIImage *thumbnailImage = [UIImage imageNamed:@"profile_standard.jpg"];
        
        if (imageUploaded == FALSE){
            thumbnailImage = nil;
        }else{
            thumbnailImage = self.thumbnailImageView.image;
        }
        
        retMessage = [Group setGroupWithName:self.nameField.text image:thumbnailImage creator:user.dbId members:members];
        
        // Show message
        [[[UIAlertView alloc] initWithTitle:nil message:[retMessage objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        
        // Destroy Loading animation
        [hud hide:YES];
        [hud removeFromSuperview];
    });
}

- (void)fullImageTapped:sender {
    
    [self performSegueWithIdentifier:@"ImageAssociate" sender:sender];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([[retMessage objectForKey:@"success"] boolValue] == YES){
        
        retMessage = nil;
        self.nameField.text = nil;
        self.thumbnailImageView.image = [UIImage imageNamed:@"profile_standard.jpg"];
        
        FBFriend *fbFriend = nil;
        for(int i = 0; i < [fbFriends count]; i++){
            fbFriend = [fbFriends objectAtIndex:i];
            fbFriend.selected = FALSE;
        }
        
        imageUploaded = FALSE;
        
        // Goes back to Home View
        [self.tabBarController setSelectedIndex:0];
    }
    retMessage = nil;
}

- (NSString *)validateForm {
   
    NSString *errorMessage;
    UITextField *viewWithError;
    
    if (![self.nameField.text isValidGroupName]){
        viewWithError = self.nameField;
        errorMessage = @"Please enter a group name";
    } else if ([self.tableViewMembers numberOfRowsInSection:0] < 1){
        errorMessage = @"Please add at least one member to the group";
    }
    
    self.nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    
    if (viewWithError) {
        [self changeViewToInvalid:viewWithError];
    }
    return errorMessage;
}

- (void)changeViewToInvalid:(UITextField *)view {
    if (view){
        view.layer.borderWidth = 1;
        view.layer.borderColor = [[UIColor redColor] CGColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];

    fbFriends = [FBFriend sharedFBFriends];
    [self.tableViewMembers reloadData];
}

- (void)selectPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)addMemberToGroup:sender
{
    [self performSegueWithIdentifier:@"FBAssociate" sender:sender];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.thumbnailImageView.image = chosenImage;
    imageUploaded = TRUE;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"selected == YES"];
    NSInteger linesTotal = [[fbFriends filteredArrayUsingPredicate:resultPredicate] count];
    
    UIButton *addMemberButton = (UIButton*)[self.view viewWithTag:100];
    if(linesTotal > 0){
        self.tableViewMembers.frame = membersTableViewFrame;
        float addMemberButtonY = membersTableViewFrame.origin.y + membersTableViewFrame.size.height + (self.view.frame.size.height * 0.02);
        addMemberButton.frame = CGRectMake(addMemberButton.frame.origin.x, addMemberButtonY, addMemberButton.frame.size.width, addMemberButton.frame.size.height);
    }else{
        self.tableViewMembers.frame = CGRectMake(0, 0, 0, 0);
        addMemberButton.frame = addMemberButtonFrame;
    }
    return linesTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"GroupTableCell";
    
    GroupTableCell *cell = (GroupTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                            cell.contentView.frame.origin.y,
                                            self.tableViewMembers.frame.size.width,
                                            self.tableViewMembers.frame.size.height * 0.25);
        
        [cell initFields];
    }
    
    FBFriend* fbFriend = nil;
    long int elementNum = indexPath.row;
    for(int i = 0; elementNum >= 0; i++){
        if([fbFriends[i] selected]){
            elementNum--;
        }
        if(elementNum < 0){
            fbFriend = fbFriends[i];
        }
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", fbFriend.firstName, fbFriend.fullName];
    
    cell.thumbnailProfileImageView.image = fbFriend.image;
    cell.thumbnailProfileImageView.layer.cornerRadius = cell.thumbnailProfileImageView.frame.size.width / 2;
    cell.thumbnailProfileImageView.clipsToBounds = YES;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableViewMembers.frame.size.height * 0.25;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        FBFriend* fbFriend = nil;
        long int elementNum = indexPath.row;
        for(int i = 0; elementNum >= 0; i++){
            if([fbFriends[i] selected]){
                elementNum--;
            }
            if(elementNum < 0){
                fbFriend = fbFriends[i];
                fbFriend.selected = FALSE;
                [fbFriends replaceObjectAtIndex:i withObject:fbFriend];
            }
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ImageAssociate"]) {
        
        ImageExpandViewController *vc = [segue destinationViewController];
        [vc setImage:self.thumbnailImageView.image];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    fbFriends = nil;
    retMessage = nil;
    _thumbnailImageView = nil;
    _nameField = nil;
    _tableViewMembers = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
