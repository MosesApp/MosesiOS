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
@property (nonatomic) double billAmount;
@property (nonatomic, copy) NSDate* date;
@property (nonatomic, copy) NSString* relation;
@property (nonatomic, copy) NSString* status;
@property (nonatomic) double amount;

- (id)initWithdbId:(long long int)dbId
            billId:(long long int)billId
              name:(NSString*)name
   billDescription:(NSString*)billDescription
           groupId:(long long int)groupId
   receiptImageURL:(NSString*)receiptImageURL
        billAmount:(double)billAmount
              date:(NSDate*)date
          relation:(NSString*)relation
            status:(NSString*)status
            amount:(double)amount;

+ (NSArray*)sharedBills;

+ (NSDictionary*)setBillWithName:(NSString *)name
                     description:(NSString *)description
                           group:(NSString *)group
                           image:(UIImage *)image
                          amount:(NSString *)amount
                        currency:(NSString *)currency
                         members:(NSArray *)members;

+ (void)clearSharedBills;

+ (void)requestUserBills:(long long int)userId;

+ (NSDictionary*)getFinancialSituation;

+ (double)getBalanceForGroupId:(long long int)groupId;

+ (NSArray*)getBillsForGroupId:(long long int)groupId;

- (NSString *)description;

@end
