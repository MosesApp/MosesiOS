//
//  PageContentViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-14.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (nonatomic, weak) UIImageView *backgroundImageView;

@property NSUInteger pageIndex;
@property NSString *imageFile;

@end
