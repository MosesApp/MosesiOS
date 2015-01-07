//
//  WebService.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-04.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject

+ (NSDictionary*)getDataWithParam:(NSString *)param
                       serviceURL:(NSString*)serviceURL;

+ (NSDictionary*)setDataWithJSONDict:(NSDictionary*)dict
                          serviceURL:(NSString*)serviceURL;

@end

