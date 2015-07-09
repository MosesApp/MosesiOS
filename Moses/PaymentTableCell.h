//
//  PaymentTableCell.h
//  Moses
//
//  Created by Daniel Marchena on 2015-07-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "MGSwipeTableCell.h"

@interface PaymentTableCell : MGSwipeTableCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *thumbnailBillImageView;
@property (nonatomic, strong) UIImageView *thumbnailStatusImageView;

- (void)initFields;

@end
