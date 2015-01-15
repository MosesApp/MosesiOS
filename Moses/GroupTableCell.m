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
        [self initAdministratorLabel];
        [self initCustomValueLabel];
        [self initThumbnailProfileImageView];
    }
    return self;
}

- (void)initNameLabel
{

}

- (void)initAdministratorLabel
{

}

- (void)initCustomValueLabel
{

}

- (void)initThumbnailProfileImageView
{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    _nameLabel = nil;
    _administratorLabel = nil;
    _customValueLabel = nil;
    _thumbnailProfileImageView = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
