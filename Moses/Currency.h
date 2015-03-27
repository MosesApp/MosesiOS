//
//  Currency.h
//  Moses
//
//  Created by Daniel Marchena on 2015-03-25.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (nonatomic) long long int dbId;
@property (nonatomic, copy) NSString* prefix;
@property (nonatomic, copy) NSString* prefixDescription;

- (id)initWithdbId:(long long int)dbId
            prefix:(NSString*)prefix
 prefixDescription:(NSString*)prefixDescription;

+ (NSMutableArray*)sharedCurrencies;

+ (void)clearSharedCurrencies;

+ (void)requestCurrencies;

- (NSString *)description;

@end
