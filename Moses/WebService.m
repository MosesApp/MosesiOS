//
//  WebService.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-04.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "WebService.h"
#import "Settings.h"
#import <UIKit/UIKit.h>

@implementation WebService

+ (NSDictionary*)getDataWithParam:(NSString *)param
                       serviceURL:(NSString*)serviceURL
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", [Settings getWebServiceAdmin], [Settings getWebServicePassword]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@",[self AFBase64EncodedStringFromString:basicAuthCredentials]];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@/%@/", [Settings getWebServiceProtocol], [Settings getWebServiceDomain], serviceURL, param]]];
    [request setHTTPMethod:@"GET"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:60.0];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
    
    NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
}

+ (NSDictionary*)setDataWithJSONDict:(NSDictionary*)dict
                          serviceURL:(NSString*)serviceURL
{
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    // Open the connection
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", [Settings getWebServiceAdmin], [Settings getWebServicePassword]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [self AFBase64EncodedStringFromString:basicAuthCredentials]];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@/", [Settings getWebServiceProtocol], [Settings getWebServiceDomain], serviceURL]]];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
    
    NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
    
}

+ (UIImage*) getImage:(NSString *)imageURL {
    
    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *domainURL = [NSString stringWithFormat: @"%@://%@:%@/%@/", [Settings getWebServiceProtocol], [Settings getWebServiceDomain], [Settings getWebServiceNginxPort], [Settings getWebServiceMediaPath]];
    NSString *imageName = [imageURL stringByReplacingOccurrencesOfString:domainURL withString:@""];
    NSString *filePath = [NSString stringWithFormat: @"%@/%@", directoryPath, imageName];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    UIImage *image;

    
    if ([filemgr fileExistsAtPath: filePath] == YES){
        NSFileManager *filemgr = [NSFileManager defaultManager];
        NSData *databuffer = [filemgr contentsAtPath: filePath ];
        image = [UIImage imageWithData:databuffer];
        
    }else{
        image = [UIImage imageWithData:
                 [NSData dataWithContentsOfURL:
                  [NSURL URLWithString: imageURL]]];
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", imageName]] options:NSAtomicWrite error:nil];
    }

    return image;
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

+ (BOOL)validateUrl: (NSString *) candidate {
    if(![candidate isEqual:[NSNull null]]){
        NSURL *candidateURL = [NSURL URLWithString:candidate];
        if (candidateURL && candidateURL.scheme && candidateURL.host) {
            return TRUE;
        }
    }
    return FALSE;
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
