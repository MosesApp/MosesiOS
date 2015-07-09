//
//  PaymentTableCell.m
//  Moses
//
//  Created by Daniel Marchena on 2015-07-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "PaymentTableCell.h"

@implementation PaymentTableCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)initFields
{
    [self initThumbnailProfileImageView];
    [self initNameLabel];
    [self initDateLabel];
    [self initValueLabel];
    [self initThumbnailStatusImageView];
}

- (void)initThumbnailProfileImageView
{
    int x = self.contentView.frame.size.width * 0.05;
    int y = self.contentView.frame.size.height * 0.15;
    int width = self.contentView.frame.size.width * 0.10;
    int height = self.contentView.frame.size.height * 0.70;
    
    // configure control(s)
    self.thumbnailBillImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.thumbnailBillImageView];
    
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

- (void)initDateLabel
{
    int x = self.contentView.frame.size.width * 0.18;
    int y = self.contentView.frame.size.height * 0.45;
    int width = self.contentView.frame.size.width * 0.50;
    int height = self.contentView.frame.size.height * 0.60;
    
    // configure control(s)
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.dateLabel.textColor = [UIColor grayColor];
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [self addSubview:self.dateLabel];
}

- (void)initValueLabel
{
    int x = self.contentView.frame.size.width * 0.75;
    int y = self.contentView.frame.size.height * 0.20;
    int width = self.contentView.frame.size.width * 0.50;
    int height = self.contentView.frame.size.height * 0.60;
    
    // configure control(s)
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.valueLabel.textColor = [UIColor grayColor];
    self.valueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [self addSubview:self.valueLabel];
}

- (void)initThumbnailStatusImageView
{
    int x = self.contentView.frame.size.width * 0.90;
    int y = self.contentView.frame.size.height * 0.40;
    int width = self.contentView.frame.size.width * 0.04;
    int height = self.contentView.frame.size.height * 0.20;
    
    // configure control(s)
    self.thumbnailStatusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.thumbnailStatusImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    _nameLabel = nil;
    _valueLabel = nil;
    _dateLabel = nil;
    _thumbnailBillImageView = nil;
    _thumbnailStatusImageView = nil;
    NSLog(@"dealloc - %@",[self class]);
}


@end
