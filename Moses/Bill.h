//
//  Bill.h
//  Moses
//
//  Created by Daniel Marchena on 2015-01-04.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface Bill : NSObject

@property (nonatomic) long long int dbId;
@property (nonatomic) long long int groupId;
@property (nonatomic, weak) NSString* receiptImageURL;
@property (nonatomic, weak) UIImage* receiptImage;
@property (nonatomic, weak) NSString* type;
@property (nonatomic, weak) User* user;
@property (nonatomic) long long int amount;
@property (nonatomic, weak) NSDate* deadline;
@property (nonatomic, weak) NSString* status;


- (id)initWithdbId:(long long int)dbId
           groupId:(long long int)groupId
   receiptImageURL:(NSString*)receiptImageURL
              type:(NSString*)type
              user:(User*)user
            amount:(long long int)amount
          deadline:(NSDate*)deadline
            status:(NSString*)status;

+ (NSArray*) sharedBills;

+ (void) clearSharedBills;

+ (NSArray*) getBillsToReceive:(long long int)userId;

+ (NSArray*) getBillsToPay:(long long int)userId;

+ (NSMutableDictionary*)getFinancialSituation;

+ (float)getBalanceForGroupId:(long long int)groupId;

- (NSString *)description;

@end
