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

+ (NSString *)getWebServiceUsers
{
    return @"users";
}

+ (NSString *)getWebServiceUser
{
    return @"user";
}

+ (NSString *)getWebServiceUserGroup
{
    return @"group_user";
}

+ (NSString *)getWebServiceBillReceiver
{
    return @"bill_receiver";
}

+ (NSString *)getWebServiceBillDebtor
{
    return @"bill_debtor";
}

+ (NSString *)getWebServiceAdmin
{
    return @"admin";
}

+ (NSString *)getWebServicePassword
{
    return @"Moses765";
}

+ (NSString *)AFBase64EncodedStringFromString:(NSString *)string {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

+ (BOOL) validateUrl: (NSString *) candidate {
    if(![candidate isEqual:[NSNull null]]){
        NSURL *candidateURL = [NSURL URLWithString:candidate];
        if (candidateURL && candidateURL.scheme && candidateURL.host) {
            return TRUE;
        }
    }
    return FALSE;
}

@end
