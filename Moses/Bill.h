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
@property (nonatomic) long long int billId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* billDescription;
@property (nonatomic) long long int groupId;
@property (nonatomic, copy) NSString* receiptImageURL;
@property (nonatomic, copy) UIImage* receiptImage;
@property (nonatomic) long long int billAmount;
@property (nonatomic, copy) NSDate* deadline;
@property (nonatomic, copy) NSString* relation;
@property (nonatomic, copy) NSString* status;
@property (nonatomic) long long int amount;

- (id)initWithdbId:(long long int)dbId
            billId:(long long int)billId
              name:(NSString*)name
   billDescription:(NSString*)billDescription
           groupId:(long long int)groupId
   receiptImageURL:(NSString*)receiptImageURL
        billAmount:(long long int)billAmount
          deadline:(NSDate*)deadline
          relation:(NSString*)relation
            status:(NSString*)status
            amount:(long long int)amount;

+ (NSArray*)sharedBills;

+ (void)clearSharedBills;

+ (void)requestUserBills:(long long int)userId;

+ (NSMutableDictionary*)getFinancialSituation;

+ (float)getBalanceForGroupId:(long long int)groupId;

- (NSString *)description;

@end
