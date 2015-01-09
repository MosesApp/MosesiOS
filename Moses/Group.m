//
//  Group.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-27.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "Group.h"
#import "Settings.h"
#import "WebService.h"

@implementation Group

static NSMutableArray *sharedUserGroups = nil;


- (id)initWithdbId:(long long int)dbId
           ownerId:(long long int)ownerId
              name:(NSString*)name
          imageURL:(NSString*)imageURL
            status:(NSString*)status{
    
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.ownerId = ownerId;
        self.name = name;
        self.imageURL = imageURL;
        if([Settings validateUrl:self.imageURL]){
            self.image = [UIImage imageWithData:
                           [NSData dataWithContentsOfURL:
                            [NSURL URLWithString: self.imageURL]]];
        }
        self.status = status;
    }
    return self;
}

+(NSArray*)sharedUserGroups
{
    return sharedUserGroups;
}

+ (void)clearSharedUserGroups
{
    sharedUserGroups = nil;
}

+ (void)getUserGroupRelationWithUserId:(long long int)userId
{
    
    sharedUserGroups = [[NSMutableArray alloc] init];
    
    NSDictionary *groupJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceUserGroup]];
    
    for (NSDictionary *serviceKey in groupJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *groupRelationKey in [groupJSON objectForKey:serviceKey]) {
                NSDictionary *groupDict =  [groupRelationKey objectForKey:@"group"];
                Group *group = [[Group alloc] initWithdbId:[groupDict[@"id"] intValue]
                                                   ownerId:[groupDict[@"owner"] intValue]
                                                      name:groupDict[@"name"]
                                                  imageURL:groupDict[@"image"]
                                                    status:groupDict[@"status"]];
                [sharedUserGroups addObject:group];
            }
        }
    }
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"\nGroup\n------\n%lld\n%lld\n%@\n%@\n%@\n------",
            self.dbId,
            self.ownerId,
            self.name,
            self.imageURL,
            self.status];
}

- (void)dealloc {
    
    _dbId = 0.0;
    _ownerId = 0.0;
    _name = nil;
    _imageURL = nil;
    _image = nil;
    _status = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
