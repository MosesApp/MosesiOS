//
//  BillViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-11.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *descriptionField;
@property (nonatomic, strong) UITextField *groupField;

@property (nonatomic, strong) UITableView *tableViewMembers;

@end
