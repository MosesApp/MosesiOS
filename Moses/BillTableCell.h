//
//  BillTableCell.h
//  Moses
//
//  Created by Daniel Marchena on 2015-03-22.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillTableCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *thumbnailProfileImageView;
@property (nonatomic, strong) UITextField *amountField;

- (void)initFields;

@end
