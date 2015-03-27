//
//  Group.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-27.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Group : NSObject

@property (nonatomic) long long int dbId;
@property (nonatomic) long long int creatorId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* imageURL;
@property (nonatomic, copy) UIImage* image;
@property (nonatomic, copy) NSString* status;

- (id)initWithdbId:(long long int)dbId
         creatorId:(long long int)creatorId
              name:(NSString*)name
          imageURL:(NSString*)imageURL
            status:(NSString*)status;

+ (NSArray*)sharedUserGroups;

+ (void)clearSharedUserGroups;

+ (void)requestUserGroupRelationWithUserId:(long long int)userId;

+ (NSArray*)requestUserGroupRelationWithGroupId:(long long int)groupId;

+ (NSDictionary*)setGroupWithName:(NSString *)name
                        image:(UIImage *)image
                      creator:(long long int)creator
                      members:(NSArray *)members;

- (NSString *)description;

@end
