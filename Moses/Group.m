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
#import "User.h"
#import "Bill.h"

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
        if([WebService validateUrl:self.imageURL]){
            self.image = [WebService getImage: self.imageURL];
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
    
    sharedUserGroups = [[NSMutableArray alloc] init];
    
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

+ (NSDictionary*)setGroupWithName:(NSString *)name
                            image:(UIImage *)image
                          creator:(long long int)creator
                          members:(NSArray *)members
{
    
    NSString *encodedString = [UIImageJPEGRepresentation(image, 0) base64EncodedStringWithOptions:0];
    // Set JSON object
    NSArray *objects = [NSArray arrayWithObjects:name, encodedString, [NSNumber numberWithLongLong:creator], members, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"name", @"image", @"creator", @"members", nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *groupJSON = [WebService setDataWithJSONDict:dict serviceURL:[Settings getWebServiceGroup]];
    
    NSMutableDictionary *retMessage = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    if([groupJSON objectForKey:@"id"] != nil){
        
        double dbId = [[User sharedUser] dbId];
        // Get user related groups
        [self requestUserGroupRelationWithUserId:dbId];
        // Get user related bills
        [Bill requestUserBills:dbId];
        
        [retMessage setValue:@"Group created successfully" forKey:@"message"];
        [retMessage setValue:[NSNumber numberWithBool:true] forKey:@"success"];
        
        return retMessage;
    }
    [retMessage setObject:[[groupJSON objectForKey:@"non_field_errors"] objectAtIndex:0] forKey:@"message"];
    [retMessage setValue:[NSNumber numberWithBool:false] forKey:@"success"];
    return retMessage;
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
