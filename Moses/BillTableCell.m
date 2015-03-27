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