//
//  FBFriend.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-18.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "FBFriend.h"
#import "User.h"

@implementation FBFriend

static NSMutableArray *sharedFBFriends = nil;


- (id)initWithDbId:      (long long int) dbId
              facebookId:(NSString *)facebookId
               firstName:(NSString *)firstName
                fullName:(NSString *)fullName
                   email:(NSString *)email
                  locale:(NSString *)locale
                timezone:(int)timezone{

    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.facebookId = facebookId;
        self.firstName = firstName;
        self.fullName = fullName;
        self.email = email;
        self.locale = locale;
        self.timezone = timezone;
        self.image = [UIImage imageWithData:
              [NSData dataWithContentsOfURL:
                       [NSURL URLWithString: [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", facebookId]]]];;
        self.selected = FALSE;
    }
    return self;
}

+ (NSMutableArray*)sharedFBFriends
{
    return sharedFBFriends;
}

+ (void)clearSharedFBFriends
{
    sharedFBFriends = nil;
}

+ (void)requestFBFriends
{
    if(sharedFBFriends == nil){
        sharedFBFriends = [[NSMutableArray alloc] init];
    }
    
    [FBRequestConnection startForMyFriendsWithCompletionHandler:
     ^(FBRequestConnection *connection, id<FBGraphUser> friends, NSError *error)
     {
         // Validate facebook friends on the database
         NSString *facebook_ids = @"";
         NSArray *data = [friends objectForKey:@"data"];
         for (int i = 0; i < data.count; i++){
             id object = [data objectAtIndex:i];
             
             facebook_ids = [NSString stringWithFormat:@"%@%@", facebook_ids, [object objectForKey:@"id"]];
             
             if((i+1) < data.count){
                facebook_ids = [NSString stringWithFormat:@"%@&", facebook_ids];
             }
         }
         
         NSDictionary *facebook_friends = [User getUserWithFacebookId:facebook_ids];
         for (int i = 0; i < [facebook_friends[@"count"] intValue]; i++){
             
             FBFriend* fbFriendObj = [[FBFriend alloc]
                                      initWithDbId:[facebook_friends[@"results"][i][@"id"]intValue]
                                      facebookId:facebook_friends[@"results"][i][@"facebook_id"]
                                      firstName:facebook_friends[@"results"][i][@"first_name"]
                                      fullName:facebook_friends[@"results"][i][@"full_name"]
                                      email:facebook_friends[@"results"][i][@"email"]
                                      locale:facebook_friends[@"results"][i][@"locale"]
                                      timezone:[facebook_friends[@"results"][i][@"timezone"] intValue]];
              [sharedFBFriends addObject:fbFriendObj];
              
         }
     }
     ];
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"FBFriend\n------\n%@\n%@\n%@\n------",
            self.fullName,
            self.facebookId,
            (self.selected ? @"Yes" : @"No")];
}

- (void)dealloc {
    _fullName = nil;
    _facebookId = nil;
    _image = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
