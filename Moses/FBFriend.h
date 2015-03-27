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

@property (nonatomic) long long int dbId;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* fullName;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* facebookId;
@property (nonatomic, copy) UIImage* image;
@property (nonatomic, copy) NSString *locale;
@property (nonatomic) int timezone;
@property (nonatomic) BOOL selected;

- (id)initWithDbId:(long long int) dbId
        facebookId:(NSString *)facebookId
         firstName:(NSString *)firstName
          fullName:(NSString *)fullName
             email:(NSString *)email
            locale:(NSString *)locale
          timezone:(int)timezone;


+ (NSMutableArray*)sharedFBFriends;

+ (void)clearSharedFBFriends;

+ (void)requestFBFriends;

+ (instancetype)castJSONToTypeWith:(NSDictionary*)json;

- (NSString *)description;

@end
