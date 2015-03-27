//
//  Settings.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+ (NSString *)getWebServiceDomain
{
    return @"mosesapp.me";
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

+ (NSString *)getWebServiceCurrencies
{
    return @"currencies";
}

+ (NSString *)getWebServiceUsers
{
    return @"users";
}

+ (NSString *)getWebServiceUser
{
    return @"user";
}

+ (NSString *)getWebServiceGroup
{
    return @"group";
}

+ (NSString *)getWebServiceUserGroupUser
{
    return @"group_user_user";
}

+ (NSString *)getWebServiceUserGroupGroup
{
    return @"group_user_group";
}

+ (NSString *)getWebServiceBill
{
    return @"bill_user";
}

+ (NSString *)getWebServiceAdmin
{
    return @"admin";
}

+ (NSString *)getWebServicePassword
{
    return @"Moses765";
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
