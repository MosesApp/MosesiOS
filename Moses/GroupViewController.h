//
//  GroupViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITableView *tableViewMembers;

@end
