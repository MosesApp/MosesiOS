//
//  Settings.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "Settings.h"

@implementation Settings

// Server data

+ (NSString *)getWebServiceDomain
{
    return @"186.206.198.117:8000";
}

+ (NSString *)getWebServiceProtocol
{
    return @"http";
}

+ (NSString *)getWebServiceNginxPort
{
    return @"8000";
}

+ (NSString *)getWebServiceMediaPath
{
    return @"media";
}

// User and password

+ (NSString *)getWebServiceAdmin
{
    return @"admin";
}

+ (NSString *)getWebServicePassword
{
    return @"Moses765";
}

// User services

+ (NSString *)getWebServiceListUsers
{
    return @"listUsers";
}

+ (NSString *)getWebServiceCreateUser
{
    return @"createUser";
}

+ (NSString *)getWebServiceGetUser
{
    return @"getUser";
}

// Group services

+ (NSString *)getWebServiceCreateGroup
{
    return @"createGroup";
}

+ (NSString *)getWebServiceListGroups
{
    return @"listGroups";
}

// Group User services

+ (NSString *)getWebServiceCreateGroupUserRelation
{
    return @"createGroupUserRelation";
}

+ (NSString *)getWebServiceGetUserGroupRelation_GroupID
{
    return @"getUserGroupRelationGroupId";
}

+ (NSString *)getWebServiceGetUserGroupRelation_UserID
{
    return @"getUserGroupRelationUserId";
}

// Bill

+ (NSString *)getWebServiceCreateBill
{
    return @"createBill";
}

// Bill User

+ (NSString *)getWebServiceListBillUsers
{
    return @"listBillUsers";
}

+ (NSString *)getWebServiceCreateBillUser
{
    return @"createBillUser";
}

+ (NSString *)getWebServiceGetBillUser
{
    return @"getBillUser";
}

// Currency

+ (NSString *)getWebServiceListCurrencies
{
    return @"listCurrencies";
}

+ (NSString *)getWebServiceCreateCurrency
{
    return @"createCurrency";
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
