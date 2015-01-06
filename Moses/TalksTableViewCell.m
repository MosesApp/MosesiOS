//
//  TalksTableViewCell.m
//  Tindor
//
//  Created by Daniel Marchena on 2014-12-11.
//  Copyright (c) 2014 Tindor. All rights reserved.
//

#import "TalksTableViewCell.h"

@implementation TalksTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize messageLabel = _messageLabel;
@synthesize timeLabel = _timeLabel;
@synthesize userStatusImageView = _userStatusImageView;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize messageViewedImageView = _messageViewedImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNameLabel];
        [self initMessageLabel];
        [self initTimeLabel];
        [self initThumbnailImageView];
        [self initUserStatusImageView];
        [self initMessageViewedImageView];
    }
    return self;
}


- (void)initNameLabel
{
    int x = self.frame.size.width * 0.25;
    int y = self.frame.size.height * 0.30;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
    
    [self addSubview:self.nameLabel];
}

- (void)initMessageLabel
{
    int x = self.frame.size.width * 0.25;
    int y = self.frame.size.height * 0.85;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.messageLabel.textColor = [UIColor grayColor];
    self.messageLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
    
    [self addSubview:self.messageLabel];
}


- (void)initTimeLabel
{
    int x = self.frame.size.width * 0.85;
    int y = self.frame.size.height * 0.30;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    
    [self addSubview:self.timeLabel];
}

- (void)initUserStatusImageView
{
    int x = self.frame.size.width * 0.20;
    int y = self.frame.size.height * 0.35;
    int width = self.frame.size.width * 0.05;
    int height = self.frame.size.height * 0.40;
    
    // configure control(s)
    self.userStatusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    [self addSubview:self.userStatusImageView];
}

- (void)initThumbnailImageView
{
    int x = self.frame.size.width * 0.03;
    int y = self.frame.size.height * 0.15;
    int width = self.frame.size.width * 0.20;
    int height = self.frame.size.height * 1.5;
    
    // configure control(s)
    self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    [self addSubview:self.thumbnailImageView];
}

- (void)initMessageViewedImageView
{
    int x = self.frame.size.width * 0.90;
    int y = self.frame.size.height * 0.90;
    int width = self.frame.size.width * 0.05;
    int height = self.frame.size.height * 0.30;
    
    // configure control(s)
    self.messageViewedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    [self addSubview:self.messageViewedImageView];
}

@end
