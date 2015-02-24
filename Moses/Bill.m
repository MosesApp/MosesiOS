//
//  Bill.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-04.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "Bill.h"
#import "Settings.h"
#import "WebService.h"

@implementation Bill

static NSMutableArray *sharedBills = nil;

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
            amount:(long long int)amount{
    
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.billId = billId;
        self.name = name;
        self.billDescription = billDescription;
        self.groupId = groupId;
        self.receiptImageURL = receiptImageURL;
        if([WebService validateUrl:self.receiptImageURL]){
            self.receiptImage = [UIImage imageWithData:
                          [NSData dataWithContentsOfURL:
                           [NSURL URLWithString: self.receiptImageURL]]];
        }
        self.billAmount = billAmount;
        self.deadline = deadline;
        self.relation = relation;
        self.status = status;
        self.amount = amount;
    }
    return self;
}

+ (NSArray*)sharedBills
{
    return sharedBills;
}

+ (void)clearSharedBills
{
    sharedBills = nil;
}

+ (void)requestUserBills:(long long int)userId
{
    if(sharedBills == nil){
        sharedBills = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *billJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceBill]];
    
    for (NSDictionary *serviceKey in billJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *billDict in [billJSON objectForKey:serviceKey]) {
                
                NSDictionary* billDetail = billDict[@"bill"];
                // Format date string
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                NSDate *deadline = [df dateFromString: billDetail[@"deadline"]];
                
                
                Bill *bill = [[Bill alloc] initWithdbId:[billDict[@"id"] intValue]
                                                 billId:[billDetail[@"id"] intValue]
                                                   name:billDetail[@"name"]
                                        billDescription:billDetail[@"description"]
                                                groupId:[billDetail[@"group"] intValue]
                                        receiptImageURL:billDetail[@"receipt_image"]
                                             billAmount:[billDetail[@"amount"] intValue]
                                               deadline:deadline
                                               relation:billDict[@"relation"]
                                                 status:billDict[@"status"]
                                                 amount:[billDict[@"amount"] intValue]];

                [sharedBills addObject:bill];
            
            }
        }
    }
}

+ (NSMutableDictionary*)getFinancialSituation
{
    NSMutableDictionary* financialSituation = [[NSMutableDictionary alloc] init];
    float owe = 0.0;
    float owed = 0.0;
    float balance = 0.0;
    
    for (Bill* bill in sharedBills) {
        if(![bill.status isEqual: @"paid"]){
            if([bill.relation isEqual:@"debtor"]){
                owe += bill.amount;
            }else if([bill.relation isEqual:@"taker"]){
                owed += bill.amount;
            }
        }
    }
    balance = owed - owe;
    
    financialSituation[@"owe"] = [NSNumber numberWithInt:owe];
    financialSituation[@"owed"] = [NSNumber numberWithInt:owed];
    financialSituation[@"balance"] = [NSNumber numberWithInt:balance];
    
    return financialSituation;
    
}

+ (float)getBalanceForGroupId:(long long int)groupId
{
    float balance = 0.0;
    for (Bill* bill in sharedBills) {
        if(bill.groupId == groupId){
            if(![bill.status isEqual: @"paid"]){
                if([bill.relation isEqual:@"debtor"]){
                    balance -= bill.amount;
                }else if([bill.relation isEqual:@"taker"]){
                    balance += bill.amount;
                }
            }
        }
    }
    
    return balance;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%lld\n%lld\n%@\n%@\n%lld\n%@\n%lld\n%@\n%@\n%@",
            self.dbId,
            self.billId,
            self.name,
            self.billDescription,
            self.groupId,
            self.receiptImageURL,
            self.amount,
            self.deadline,
            self.relation,
            self.status];
}

- (void)dealloc {
    _dbId = 0.0;
    _billId = 0.0;
    _name = nil;
    _billDescription = nil;
    _groupId = 0.0;
    _receiptImageURL = nil;
    _receiptImage = nil;
    _billAmount = 0.0;
    _deadline = nil;
    _relation = nil;
    _status = nil;
    _amount = 0.0;
    NSLog(@"dealloc - %@",[self class]);
}

@end
