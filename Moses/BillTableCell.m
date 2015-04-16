//
//  BillTableCell.m
//  Moses
//
//  Created by Daniel Marchena on 2015-03-22.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "BillTableCell.h"

@implementation BillTableCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)initFields{
    [self initNameLabel];
    [self initThumbnailProfileImageView];
    [self initAmountField];
}

- (void)initThumbnailProfileImageView
{
    int x = self.contentView.frame.size.width * 0.05;
    int y = self.contentView.frame.size.height * 0.15;
    int width = self.contentView.frame.size.width * 0.10;
    int height = self.contentView.frame.size.height * 0.70;
    
    // configure control(s)
    self.thumbnailProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.thumbnailProfileImageView];
}

- (void)initNameLabel
{
    int x = self.contentView.frame.size.width * 0.18;
    int y = self.contentView.frame.size.height * 0.20;
    int width = self.contentView.frame.size.width * 0.50;
    int height = self.contentView.frame.size.height * 0.60;
    
    // configure control(s)
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.0f];
    [self addSubview:self.nameLabel];
}

- (void)initAmountField
{
    int x = self.contentView.frame.size.width * 0.70;
    int y = self.contentView.frame.size.height * 0.20;
    int width = self.contentView.frame.size.width * 0.25;
    int height = self.contentView.frame.size.height * 0.60;
    
    // configure control(s)
    self.amountField= [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.amountField.borderStyle = UITextBorderStyleRoundedRect;
    self.amountField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.amountField.font = [UIFont systemFontOfSize:15];
    self.amountField.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.amountField];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void)dealloc {
    _nameLabel = nil;
    _thumbnailProfileImageView = nil;
    _amountField = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end