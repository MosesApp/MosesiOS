//
//  Settings.h
//  Moses
//
//  Created by Daniel Marchena on 2014-12-23.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (NSString *)getWebServiceDomain;

+ (NSString *)getWebServiceProtocol;

+ (NSString *)getWebServiceUsers;

+ (NSString *)getWebServiceUser;

+ (NSString *)getWebServiceUserGroup;

+ (NSString *)getWebServiceBill;

+ (NSString *)getWebServiceAdmin;

+ (NSString *)getWebServicePassword;

+ (NSString *)AFBase64EncodedStringFromString:(NSString *)string;

+ (BOOL)validateUrl: (NSString *)candidate;

@end

