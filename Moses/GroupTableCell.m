//
//  GroupTableViewCell.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-15.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "GroupTableCell.h"

@implementation GroupTableCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNameLabel];
        [self initThumbnailProfileImageView];
    }
    return self;
}

- (void)initThumbnailProfileImageView
{
    int x = self.frame.size.width * 0.05;
    int y = self.frame.size.height * 0.20;
    int width = self.frame.size.width * 0.10;
    int height = self.frame.size.height * 0.70;
    
    // configure control(s)
    self.thumbnailProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.thumbnailProfileImageView];
}

- (void)initNameLabel
{
    int x = self.frame.size.width * 0.18;
    int y = self.frame.size.height * 0.30;
    int width = self.frame.size.width * 0.50;
    int height = self.frame.size.height * 0.50;
    
    // configure control(s)
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.0f];
    [self addSubview:self.nameLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    _nameLabel = nil;
    _thumbnailProfileImageView = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
