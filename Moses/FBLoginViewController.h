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
@property (nonatomic, strong) FBLoginView *loginFacebookButtonView;
@property (nonatomic, strong) NSArray *pageImages;

@property (nonatomic, strong) id<FBGraphUser> cachedUser;

@end
