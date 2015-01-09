//
//  WebService.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-04.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "WebService.h"
#import "Settings.h"

@implementation WebService

+ (NSDictionary*)getDataWithParam:(NSString *)param
                       serviceURL:(NSString*)serviceURL
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", [Settings getWebServiceAdmin], [Settings getWebServicePassword]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [Settings AFBase64EncodedStringFromString:basicAuthCredentials]];
    
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
    
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", [Settings getWebServiceAdmin], [Settings getWebServicePassword]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [Settings AFBase64EncodedStringFromString:basicAuthCredentials]];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@/", [Settings getWebServiceProtocol], [Settings getWebServiceDomain], serviceURL]]];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
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

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
