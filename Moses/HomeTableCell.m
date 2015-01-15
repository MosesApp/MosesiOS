//
//  CustomTableCell.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-14.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

- (id)initWithStyle:(UITableViewCellStyle)style
      reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initThumbnailProfileImageView];
        [self initNameLabel];
        [self initValueLabel];
        [self initThumbnailStatusImageView];
    }
    return self;
}

- (void)initThumbnailProfileImageView
{
    int x = self.frame.size.width * 0.05;
    int y = self.frame.size.height * 0.30;
    int width = self.frame.size.width * 0.10;
    int height = self.frame.size.height * 0.70;
    
    // configure control(s)
    self.thumbnailProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.thumbnailProfileImageView];

}

- (void)initNameLabel
{
    int x = self.frame.size.width * 0.18;
    int y = self.frame.size.height * 0.40;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.0f];
    [self addSubview:self.nameLabel];
}

- (void)initValueLabel
{
    int x = self.frame.size.width * 0.75;
    int y = self.frame.size.height * 0.40;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.valueLabel.textColor = [UIColor grayColor];
    self.valueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [self addSubview:self.valueLabel];
}

- (void)initThumbnailStatusImageView
{
    int x = self.frame.size.width * 0.90;
    int y = self.frame.size.height * 0.50;
    int width = self.frame.size.width * 0.04;
    int height = self.frame.size.height * 0.30;
    
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
    _thumbnailProfileImageView = nil;
    _thumbnailStatusImageView = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
