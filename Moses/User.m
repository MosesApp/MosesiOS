//
//  User.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "User.h"
#import "Settings.h"
#import "WebService.h"

@implementation User

static User *sharedUser = nil;

#pragma mark Singleton Methods
+ (instancetype)sharedUserWithFacebookId:(NSString *)facebookId
                               firstName:(NSString *)firstName
                                fullName:(NSString *)fullName
                                   email:(NSString *)email
                                  locale:(NSString *)locale
                                timezone:(int)timezone
{
    @synchronized(self) {
        if (sharedUser == nil)
            sharedUser = [[self alloc] setUserWithWithFacebookId:facebookId
                                                       firstName:firstName
                                                        fullName:fullName
                                                           email:email
                                                          locale:locale
                                                        timezone:timezone];
    }
    
    NSLog(@"%@", sharedUser);
    return sharedUser;
}

+ (instancetype)sharedUser
{
    return sharedUser;
}

+ (void)clearSharedUser
{
    sharedUser = nil;
}

- (instancetype)setUserWithWithFacebookId:(NSString *)facebookId
                                firstName:(NSString *)firstName
                                 fullName:(NSString *)fullName
                                    email:(NSString *)email
                                   locale:(NSString *)locale
                                 timezone:(int)timezone
{
    
    // Search user using facebook id
    NSDictionary *userJSON = [self getUserWithFacebookId:facebookId];
    
    // Just create the user if not found
    if([userJSON[@"detail"] isEqual:@"Not found"]){
        
        // Set JSON object
        NSArray *objects = [NSArray arrayWithObjects:facebookId, firstName, fullName, email, locale, [NSString stringWithFormat:@"%d", timezone], nil];
        NSArray *keys = [NSArray arrayWithObjects:@"facebook_id", @"first_name", @"full_name", @"email", @"locale", @"timezone", nil];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        userJSON = [WebService setDataWithJSONDict:dict serviceURL:[Settings getWebServiceUsers]];
    }
    
    return [[self class] castJSONToTypeWith:userJSON];
    
}

+ (instancetype)castJSONToTypeWith:(NSDictionary*)json
{
    User *user = [[User alloc] init];
    user.dbId = [json[@"id"] integerValue];
    user.firstName = json[@"first_name"];
    user.fullName = json[@"full_name"];
    user.email = json[@"email"];
    user.facebookId = json[@"facebook_id"];
    user.locale = json[@"locale"];
    user.timezone = (int) json[@"timezone"];
    return user;
}

- (NSDictionary*)getUserWithFacebookId:(NSString *)facebookId
{
    return [WebService getDataWithParam:facebookId serviceURL:[Settings getWebServiceUser]];
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"\nUser\n------\n%lld\n%@\n%@\n%@\n%@\n%@\n%d\n------",
            self.dbId,
            self.firstName,
            self.fullName,
            self.email,
            self.facebookId,
            self.locale,
            self.timezone];
}

- (void)dealloc { NSLog(@"dealloc - %@",[self class]); } 

@end