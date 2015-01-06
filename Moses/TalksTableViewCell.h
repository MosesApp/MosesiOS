//
//  TalksTableViewCell.h
//  Tindor
//
//  Created by Daniel Marchena on 2014-12-11.
//  Copyright (c) 2014 Tindor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalksTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *userStatusImageView;
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIImageView *messageViewedImageView;

@end
