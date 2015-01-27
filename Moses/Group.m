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
         creatorId:(long long int)creatorId
              name:(NSString*)name
          imageURL:(NSString*)imageURL
            status:(NSString*)status{
    
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.creatorId = creatorId;
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

+ (void)requestUserGroupRelationWithUserId:(long long int)userId
{
    
    if(sharedUserGroups == nil){
        sharedUserGroups = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *groupJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceUserGroup]];
    
    for (NSDictionary *serviceKey in groupJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *groupRelationKey in [groupJSON objectForKey:serviceKey]) {
                NSDictionary *groupDict =  [groupRelationKey objectForKey:@"group"];
                Group *group = [[Group alloc] initWithdbId:[groupDict[@"id"] intValue]
                                                 creatorId:[groupDict[@"creator"] intValue]
                                                      name:groupDict[@"name"]
                                                  imageURL:groupDict[@"image"]
                                                    status:groupDict[@"status"]];
                [sharedUserGroups addObject:group];
            }
        }
    }
}

+ (NSString*)setGroupWithName:(NSString *)name
                        image:(UIImage *)image
                      creator:(long long int)creator
                      members:(NSMutableArray *)members
{
    
    // Set JSON object
    NSArray *objects = [NSArray arrayWithObjects:name, image, creator, members, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"name", @"image", @"creator", @"members", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
    NSDictionary *groupJSON = [WebService setDataWithJSONDict:dict serviceURL:[Settings getWebServiceGroup]];
    
    NSLog(@"%@", groupJSON);
    
    return nil;
    
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"\nGroup\n------\n%lld\n%lld\n%@\n%@\n%@\n------",
            self.dbId,
            self.creatorId,
            self.name,
            self.imageURL,
            self.status];
}

- (void)dealloc {
    _dbId = 0.0;
    _creatorId = 0.0;
    _name = nil;
    _imageURL = nil;
    _image = nil;
    _status = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
