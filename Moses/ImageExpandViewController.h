//
//  ImageExpandViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2015-03-28.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageExpandViewController : UIViewController

@property (strong, nonatomic) UIImageView *imageView;

- (void)setImage:(UIImage *)image;

@end
