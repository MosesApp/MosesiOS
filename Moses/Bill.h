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
@property (nonatomic, copy) NSString* receiptImageURL;
@property (nonatomic, copy) UIImage* receiptImage;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) User* user;
@property (nonatomic) long long int amount;
@property (nonatomic, copy) NSDate* deadline;
@property (nonatomic, copy) NSString* status;


- (id)initWithdbId:(long long int)dbId
           groupId:(long long int)groupId
   receiptImageURL:(NSString*)receiptImageURL
              type:(NSString*)type
              user:(User*)user
            amount:(long long int)amount
          deadline:(NSDate*)deadline
            status:(NSString*)status;

+ (NSArray*)sharedBills;

+ (void)clearSharedBills;

+ (void)getBillsToReceive:(long long int)userId;

+ (void)getBillsToPay:(long long int)userId;

+ (NSMutableDictionary*)getFinancialSituation;

+ (float)getBalanceForGroupId:(long long int)groupId;

- (NSString *)description;

@end
