//
//  Settings.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

// Server data

+ (NSString *)getWebServiceDomain;

+ (NSString *)getWebServiceProtocol;

+ (NSString *)getWebServiceNginxPort;

+ (NSString *)getWebServiceMediaPath;

// User and password

+ (NSString *)getWebServiceAdmin;

+ (NSString *)getWebServicePassword;

// User services

+ (NSString *)getWebServiceListUsers;

+ (NSString *)getWebServiceCreateUser;

+ (NSString *)getWebServiceGetUser;

// Group services

+ (NSString *)getWebServiceCreateGroup;

+ (NSString *)getWebServiceListGroups;

// Group User services

+ (NSString *)getWebServiceCreateGroupUserRelation;

+ (NSString *)getWebServiceGetUserGroupRelation_GroupID;

+ (NSString *)getWebServiceGetUserGroupRelation_UserID;

// Bill

+ (NSString *)getWebServiceCreateBill;

// Bill User

+ (NSString *)getWebServiceListBillUsers;

+ (NSString *)getWebServiceCreateBillUser;

+ (NSString *)getWebServiceGetBillUser;

// Currency

+ (NSString *)getWebServiceListCurrencies;

+ (NSString *)getWebServiceCreateCurrency;


@end

