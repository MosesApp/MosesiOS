//
//  User.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) long long int dbId;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* fullName;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* facebookId;
@property (nonatomic, copy) NSString *locale;
@property (nonatomic) int timezone;


+ (instancetype)sharedUserWithFacebookId:(NSString *)facebookId
                               firstName:(NSString *)firstName
                                fullName:(NSString *)fullName
                                   email:(NSString *)email
                                  locale:(NSString *)locale
                                timezone:(int)timezone;

+ (instancetype)sharedUser;

+ (void)clearSharedUser;

+ (instancetype)castJSONToTypeWith:(NSDictionary*)json;

- (instancetype)setUserWithWithFacebookId:(NSString *)facebookId
                          firstName:(NSString *)firstName
                           fullName:(NSString *)fullName
                              email:(NSString *)email
                             locale:(NSString *)locale
                           timezone:(int)timezone;


- (NSDictionary*)getUserWithFacebookId:(NSString *)facebookId;

- (NSString *)description;

@end
