//
//  ConfigurationViewController.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-05.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ConfigurationViewController : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) FBLoginView *loginFacebookButtonView;

@end
