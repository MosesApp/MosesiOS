//
//  Currency.m
//  Moses
//
//  Created by Daniel Marchena on 2015-03-25.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "Currency.h"
#import "WebService.h"
#import "Settings.h"

@implementation Currency

static NSMutableArray *sharedCurrencies = nil;

- (id)initWithdbId:(long long int)dbId
            prefix:(NSString*)prefix
 prefixDescription:(NSString*)prefixDescription{
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.prefix = prefix;
        self.prefixDescription = prefixDescription;
    }
    return self;
}

+(NSArray*)sharedCurrencies
{
    return sharedCurrencies;
}

+ (void)clearSharedCurrencies
{
    sharedCurrencies = nil;
}

+ (void)requestCurrencies
{
    sharedCurrencies = [[NSMutableArray alloc] init];
    
    NSDictionary *currenciesJSON = [WebService getDataWithParam:nil  serviceURL:[Settings getWebServiceCurrencies]];
    
    for (NSDictionary *serviceKey in currenciesJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *currencyDict in [currenciesJSON objectForKey:serviceKey]) {
                
                Currency *currency = [[Currency alloc] initWithdbId:[currencyDict[@"id"] intValue] prefix:currencyDict[@"prefix"] prefixDescription:currencyDict[@"description"]];
                [sharedCurrencies addObject:currency];
            }
        }
    }
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"\nCurrency\n------\n%lld\n%@\n%@\n------",
            self.dbId,
            self.prefix,
            self.prefixDescription];
}

- (void)dealloc {
    _dbId = 0.0;
    _prefix = nil;
    _prefixDescription = nil;

    NSLog(@"dealloc - %@",[self class]);
}

@end
