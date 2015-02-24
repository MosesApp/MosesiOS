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

+ (instancetype)sharedUserWithFacebookId:(NSString *)facebookId
                               firstName:(NSString *)firstName
                                fullName:(NSString *)fullName
                                   email:(NSString *)email
                                  locale:(NSString *)locale
                                timezone:(int)timezone
{
    @synchronized(self) {
        if (sharedUser == nil)
            sharedUser = [[self alloc] setUserWithFacebookId:facebookId
                                                   firstName:firstName
                                                    fullName:fullName
                                                       email:email
                                                      locale:locale
                                                    timezone:timezone];
    }
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

- (instancetype)setUserWithFacebookId:(NSString *)facebookId
                            firstName:(NSString *)firstName
                             fullName:(NSString *)fullName
                                email:(NSString *)email
                               locale:(NSString *)locale
                             timezone:(int)timezone
{
    
    // Search user using facebook id
    NSDictionary *userJSON = [[self class] getUserWithFacebookId:facebookId];
    
    // Just create the user if not found
    if([userJSON[@"count"] integerValue] == 0){
        
        // Set JSON object
        NSArray *objects = [NSArray arrayWithObjects:facebookId, firstName, fullName, email, locale, [NSString stringWithFormat:@"%d", timezone], nil];
        NSArray *keys = [NSArray arrayWithObjects:@"facebook_id", @"first_name", @"full_name", @"email", @"locale", @"timezone", nil];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        userJSON = [WebService setDataWithJSONDict:dict serviceURL:[Settings getWebServiceUsers]];
        
        return [[self class] castJSONToTypeWith:userJSON];
    }
    
    return [[self class] castJSONToTypeWith:userJSON[@"results"][0]];

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
    user.timezone = (int) [json[@"timezone"] integerValue];
    return user;
}

+ (NSDictionary*)getUserWithFacebookId:(NSString *)facebookId
{
    return [WebService getDataWithParam:facebookId serviceURL:[Settings getWebServiceUser]];
}

- (id)copyWithZone:(NSZone *)zone {
    User *user = [[[self class] allocWithZone:zone] init];
    if(user) {
        [user setDbId:[self dbId]];
        [user setFirstName:[self firstName]];
        [user setFullName:[self fullName]];
        [user setEmail:[self email]];
        [user setFacebookId:[self facebookId]];
        [user setLocale:[self locale]];
        [user setTimezone:[self timezone]];
    }
    return user;
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

- (void)dealloc {
    _firstName = nil;
    _fullName = nil;
    _email = nil;
    _facebookId = nil;
    _locale = nil;
    _timezone = 0;

    NSLog(@"dealloc - %@",[self class]);
}

@end
