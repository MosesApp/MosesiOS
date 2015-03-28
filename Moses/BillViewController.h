//
//  BillViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-11.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *descriptionField;
@property (nonatomic, strong) UITextField *groupField;
@property (nonatomic, strong) UITextField *currencyField;
@property (nonatomic, strong) UITextField *amountField;

@property (nonatomic, strong) UITableView *tableViewMembers;

@end
