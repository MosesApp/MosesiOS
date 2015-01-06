//
//  FBViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-13.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FBLoginViewController : UIViewController <UIPageViewControllerDataSource, FBLoginViewDelegate>

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (strong, nonatomic) FBLoginView *loginFacebookButtonView;
@property (strong, nonatomic) NSArray *pageImages;

@property (nonatomic, weak) id<FBGraphUser> cachedUser;

@end
