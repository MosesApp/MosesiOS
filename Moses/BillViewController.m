//
//  BillViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-11.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "User.h"
#import "BillViewController.h"
#import "BillTableCell.h"
#import "ActionSheetStringPicker.h"
#import "Currency.h"
#import "Group.h"
#import "FBFriend.h"
#import "MBProgressHUD.h"

@interface BillViewController ()
{
    NSArray *members;
    BOOL imageUploaded;
    BOOL singlePayer;
}
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
    
    // Create bill thumbnail preview
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
    float nameFieldX = viewWidth * 0.05;
    float nameFieldY = viewY + mainHeaderHeight + (viewFullHeight * 0.02);
    float nameFieldWidth = viewWidth * 0.90;
    float nameFieldHeight = viewFullHeight * 0.06;
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldWidth, nameFieldHeight)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.nameField.font = [UIFont systemFontOfSize:15];
    self.nameField.placeholder = @"Enter a name for this bill";
    self.nameField.delegate = self;
    
    [self.view addSubview:self.nameField];
    
    // Bill description text field
    float descriptionFieldX = viewWidth * 0.05;
    float descriptionFieldY = nameFieldY + mainHeaderHeight + (viewFullHeight * 0.02);
    float descriptionFieldWidth = viewWidth * 0.90;
    float descriptionFieldHeight = viewFullHeight * 0.06;
    
    self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(descriptionFieldX, descriptionFieldY, descriptionFieldWidth, descriptionFieldHeight)];
    self.descriptionField.borderStyle = UITextBorderStyleRoundedRect;
    self.descriptionField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.descriptionField.font = [UIFont systemFontOfSize:15];
    self.descriptionField.placeholder = @"Enter a description for this bill";
    self.descriptionField.delegate = self;
    
    [self.view addSubview:self.descriptionField];

    // Bill group dropdowm field
    float groupFieldX = viewWidth * 0.05;
    float groupFieldY = descriptionFieldY + mainHeaderHeight + (viewFullHeight * 0.02);
    float groupFieldWidth = viewWidth * 0.25;
    float groupFieldHeight = viewFullHeight * 0.06;
    
    self.groupField = [[UITextField alloc] initWithFrame:CGRectMake(groupFieldX, groupFieldY, groupFieldWidth,groupFieldHeight)];
    self.groupField.borderStyle = UITextBorderStyleRoundedRect;
    self.groupField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.groupField.font = [UIFont systemFontOfSize:15];
    self.groupField.placeholder = @"Group";
    self.groupField.delegate = self;
    self.groupField.tag = 200;
    
    [self.view addSubview:self.groupField];
    
    // Upload bill button
    float uploadButtonY = groupFieldY;
    float uploadButtonX = viewWidth * 0.35;
    float uploadButtonWidth = viewWidth * 0.60;
    float uploadButtonHeight = viewFullHeight * 0.06;
    
    UIImage *uploadImage = [UIImage imageNamed:@"upload_bill_picture.png"];
    UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadButton setImage:uploadImage forState:UIControlStateNormal];
    [uploadButton addTarget:self
                     action:@selector(selectPicture)
           forControlEvents:UIControlEventTouchUpInside];
    uploadButton.frame = CGRectMake(uploadButtonX, uploadButtonY, uploadButtonWidth, uploadButtonHeight);
    // Check if user selected an image
    imageUploaded = FALSE;
    
    [self.view addSubview:uploadButton];
    
    // Bill currency dropdowm field
    float currencyFieldX = viewWidth * 0.05;
    float currencyFieldY = uploadButtonY + mainHeaderHeight + (viewFullHeight * 0.02);
    float currencyFieldWidth = viewWidth * 0.25;
    float currencyFieldHeight = viewFullHeight * 0.06;
    
    self.currencyField = [[UITextField alloc] initWithFrame:CGRectMake(currencyFieldX, currencyFieldY, currencyFieldWidth, currencyFieldHeight)];
    self.currencyField.delegate = self;
    self.currencyField.borderStyle = UITextBorderStyleRoundedRect;
    self.currencyField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.currencyField.font = [UIFont systemFontOfSize:15];
    self.currencyField.placeholder = @"Currency";
    self.currencyField.tag = 201;
    // Only the bill creator paid it
    singlePayer = FALSE;
    
    [self.view addSubview:self.currencyField];
    
    // Bill amount field
    float amountFieldX = viewWidth * 0.35;
    float amountFieldY = currencyFieldY;
    float amountFieldWidth = viewWidth * 0.60;
    float amountFieldHeight = viewFullHeight * 0.06;
    
    self.amountField = [[UITextField alloc] initWithFrame:CGRectMake(amountFieldX, amountFieldY, amountFieldWidth, amountFieldHeight)];
    self.amountField.delegate = self;
    self.amountField.borderStyle = UITextBorderStyleRoundedRect;
    self.amountField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.amountField.font = [UIFont systemFontOfSize:15];
    self.amountField.placeholder = @"Amount for this bill";
    self.amountField.tag = 202;
    self.amountField.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];
    [toolbar setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(releaseAmountField)];
    
    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    
    // Set the toolbar as accessory view of an UITextField object
    self.amountField.inputAccessoryView = toolbar;
    
    [self.view addSubview:self.amountField];
    
    // Bill members box
    float membersHeaderY = currencyFieldY + uploadButtonHeight + (viewFullHeight * 0.02);
    float membersHeaderX = 0;
    float membersHeaderWidth = viewWidth;
    float membersHeaderHeight = viewFullHeight * 0.05;
    
    UIView *membersHeader =[[UIView alloc] initWithFrame:CGRectMake(membersHeaderX, membersHeaderY, membersHeaderWidth, membersHeaderHeight)];
    membersHeader.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:146.0/255.0 blue:66.0/255.0 alpha:1.0f];
    
    [self.view addSubview:membersHeader];
    
    // Members box label
    UILabel *membersHeaderLabel =[[UILabel alloc] init];
    [membersHeaderLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    membersHeaderLabel.text = @"How much each member paid";
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
    float membersTableViewHeight = (viewHeight - (membersHeaderHeight + membersHeaderY + viewTabBarHeight)) * 1.50;
    float membersTableViewY = membersHeaderY + membersHeaderHeight;
    float membersTableViewX = membersHeaderX;
    
    self.tableViewMembers = [[UITableView alloc] init];
    self.tableViewMembers.frame = CGRectMake(membersTableViewX, membersTableViewY, membersTableViewWidth, membersTableViewHeight);
    self.tableViewMembers.separatorColor = [UIColor lightGrayColor];
    self.tableViewMembers.delegate = self;
    [self.tableViewMembers setDataSource:self];
    
    [self.view addSubview:self.tableViewMembers];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    // Group picker
    if(textField.tag == 200){
        NSArray *groups = [Group sharedUserGroups];
        NSMutableArray *groupsNames = [[NSMutableArray alloc] init];
        
        for (Group *group in groups) {
            [groupsNames addObject:group.name];
        }
        
        // Check if user is enrolled in a group
        if (groups == nil || [groups count] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Join, or create a group!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            alertView.tag = 301;
            [alertView show];
            return NO;
        }
        
        [ActionSheetStringPicker
         showPickerWithTitle:@"Select a Group"
         rows:groupsNames
         initialSelection:0
         doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
             textField.text = selectedValue;
             
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableViewMembers animated:YES];
             hud.labelText = @"Loading";
             hud.yOffset = (self.tableViewMembers.frame.size.height*0.20)*-1;

             // Clear table view
             members = nil;
             [self.tableViewMembers reloadData];
             self.tableViewMembers.separatorStyle = UITableViewCellSeparatorStyleNone;
             
             // Remove warning message from grid
             for (UIView *view in self.tableViewMembers.subviews) {
                 if ([view isKindOfClass:[UILabel class]]) {
                     [view removeFromSuperview];
                 }
             }
             
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 
                 Group *selectedGroup = nil;
                                                   
                 for(Group *group in groups){
                     if([group.name isEqual:textField.text]){
                        selectedGroup = group;
                        break;
                     }
                 }
                                                   
                 // Get users related to group
                 members = [Group requestUserGroupRelationWithGroupId:selectedGroup.dbId];
                                                   
                 dispatch_async(dispatch_get_main_queue(), ^{
                     // Destroy Loading animation
                     [hud hide:YES];
                     [hud removeFromSuperview];
                     
                     if (members == nil || [members count] == 0) {
                         UIViewController *errorController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConnectFailViewController"];
                         self.view.window.rootViewController = errorController;
                     }else{
                         self.tableViewMembers.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                         // Reload table data
                         [self.tableViewMembers reloadData];
                     }
                 });
            });
                                               
        }
        cancelBlock:^(ActionSheetStringPicker *picker) {
            NSLog(@"Block Picker Canceled");
        }
        origin:self.view];
        
        return NO;
    }
    // Currency picker
    else if(textField.tag == 201){
        
        NSMutableArray *currencies = [[NSMutableArray alloc] init];
        
        for (Currency *currency in [Currency sharedCurrencies]) {
            [currencies addObject:currency.prefix];
        }
        
        // Check if server returns a list of currencies
        if (currencies == nil || [currencies count] == 0) {
            [[[UIAlertView alloc] initWithTitle:nil message:@"No currencies, please try again later!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            return NO;
        }
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Currency"
                                                rows:currencies
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               textField.text = selectedValue;
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Check user with no group alert
    if(alertView.tag == 301)
    {
        // Goes back to Group View
        [self.tabBarController setSelectedIndex:1];
    }
    // Check choosen option after input bill amount
    else if(alertView.tag == 302){
        // No
        if(buttonIndex == 0){
            singlePayer = FALSE;
        // Yes
        }else if(buttonIndex == 1){
            singlePayer = TRUE;
        }
        [self.tableViewMembers reloadData];
    }
}

-(void)registerBill{

}

- (void)selectPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)addMemberToBill:sender
{
    [self performSegueWithIdentifier:@"Associate" sender:sender];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return NO;
}

- (void)releaseAmountField
{
    [self.amountField resignFirstResponder];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Question" message:@"You're the single one paying this bill?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertView.tag = 302;
    [alertView show];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.tag == 202){
        NSString *candidate = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    
        // Ensure that the local decimal seperator is used max 1 time
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSString *decimalSymbol = [formatter decimalSeparator];
        if ([candidate componentsSeparatedByString:decimalSymbol].count > 2) return NO;
    
        // Ensure that all the characters used are number characters or decimal seperator
        NSString *validChars = [NSString stringWithFormat:@"0123456789%@", decimalSymbol];
        if ([candidate stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:validChars]].length) return NO;
    
        return YES;
    }
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.thumbnailImageView.image = chosenImage;
    imageUploaded = TRUE;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger linesTotal = [members count];
    
    if(linesTotal == 0){

        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.text = @"Select a group!";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        messageLabel.frame = CGRectMake(0, (self.tableViewMembers.frame.size.height*0.20)*-1, self.tableViewMembers.frame.size.width, self.tableViewMembers.frame.size.height);
        
        [self.tableViewMembers addSubview:messageLabel];
        self.tableViewMembers.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return linesTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"BillTableCell";
    
    BillTableCell *cell = (BillTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BillTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                            cell.contentView.frame.origin.y,
                                            self.tableViewMembers.frame.size.width,
                                            self.tableViewMembers.frame.size.height * 0.25);
        
        [cell initFields];
    }
    FBFriend *member = [members objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", member.firstName, member.fullName];
    
    cell.thumbnailProfileImageView.image = member.image;
    cell.thumbnailProfileImageView.layer.cornerRadius = cell.thumbnailProfileImageView.frame.size.width / 2;
    cell.thumbnailProfileImageView.clipsToBounds = YES;
    
    if(singlePayer == TRUE && member.dbId == [[User sharedUser] dbId]){
        cell.amountField.text = self.amountField.text;
    }else{
        cell.amountField.text = @"0.00";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableViewMembers.frame.size.height * 0.25;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _thumbnailImageView = nil;
    _nameField = nil;
    _descriptionField = nil;
    _groupField = nil;
    _currencyField = nil;
    _amountField = nil;
    _tableViewMembers = nil;
    members = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
