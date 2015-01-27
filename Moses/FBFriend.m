//
//  FBFriend.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-18.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "FBFriend.h"

@implementation FBFriend

static NSMutableArray *sharedFBFriends = nil;


- (id)initWithFullName:(NSString*)fullName
            facebookId:(NSString*)facebookId{
    
    self = [super init];
    if (self) {
        self.fullName = fullName;
        self.facebookId = facebookId;
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
         NSArray *data = [friends objectForKey:@"data"];
         for (int i = 0; i < data.count; i++){
             id object = [data objectAtIndex:i];
             FBFriend* fbFriendObj = [[FBFriend alloc] initWithFullName:[object objectForKey:@"name"] facebookId:[object objectForKey:@"id"]];
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
