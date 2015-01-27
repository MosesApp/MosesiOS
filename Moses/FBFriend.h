//
//  FBFriend.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-18.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FBFriend : NSObject

@property (nonatomic, copy) NSString* fullName;
@property (nonatomic, copy) NSString* facebookId;
@property (nonatomic, copy) UIImage* image;
@property (nonatomic) BOOL selected;

- (id)initWithFullName:(NSString*)fullName
            facebookId:(NSString*)facebookId;


+ (NSMutableArray*)sharedFBFriends;

+ (void)clearSharedFBFriends;

+ (void)requestFBFriends;

- (NSString *)description;

@end
