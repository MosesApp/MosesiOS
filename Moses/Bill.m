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
           groupId:(long long int)groupId
   receiptImageURL:(NSString*)receiptImageURL
              type:(NSString*)type
              user:(User*)user
            amount:(long long int)amount
          deadline:(NSDate*)deadline
            status:(NSString*)status{
    
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.groupId = groupId;
        self.receiptImageURL = receiptImageURL;
        if([Settings validateUrl:self.receiptImageURL]){
            self.receiptImage = [UIImage imageWithData:
                          [NSData dataWithContentsOfURL:
                           [NSURL URLWithString: self.receiptImageURL]]];
        }
        self.type = type;
        self.user = user;
        self.amount = amount;
        self.deadline = deadline;
        self.status = status;
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

+ (void)getBillsToReceive:(long long int)userId
{
    if(sharedBills == nil){
        sharedBills = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *billJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceBillReceiver]];
    
    for (NSDictionary *serviceKey in billJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *billDict in [billJSON objectForKey:serviceKey]) {
                // Format date string
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                NSDate *deadline = [df dateFromString: billDict[@"deadline"]];
                
                Bill *bill = [[Bill alloc] initWithdbId:[billDict[@"id"] intValue]
                                                groupId:[billDict[@"group"] intValue]
                                        receiptImageURL:billDict[@"receipt_image"]
                                                   type:@"receiver"
                                                   user:[User castJSONToTypeWith:billDict[@"debtor"]]
                                                amount:[billDict[@"amount"] intValue]
                                              deadline:deadline
                                                status:billDict[@"status"]];
                
                [sharedBills addObject:bill];
            
            }
        }
    }
}

+ (void)getBillsToPay:(long long int)userId
{
    if(sharedBills == nil){
        sharedBills = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *billJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceBillDebtor]];
    
    for (NSDictionary *serviceKey in billJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *billDict in [billJSON objectForKey:serviceKey]) {
                // Format date string
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                NSDate *deadline = [df dateFromString: billDict[@"deadline"]];
                
                
                Bill *bill = [[Bill alloc] initWithdbId:[billDict[@"id"] intValue]
                                                groupId:[billDict[@"group"] intValue]
                                        receiptImageURL:billDict[@"receipt_image"]
                                                   type:@"debtor"
                                                   user:[User castJSONToTypeWith:billDict[@"receiver"]]
                                                 amount:[billDict[@"amount"] intValue]
                                               deadline:deadline
                                                 status:billDict[@"status"]];
                
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
        if([bill.type isEqual:@"debtor"]){
            owe += bill.amount;
        }else if([bill.type isEqual:@"receiver"]){
            owed += bill.amount;
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
            if([bill.type isEqual:@"debtor"]){
                balance -= bill.amount;
            }else if([bill.type isEqual:@"receiver"]){
                balance += bill.amount;
            }
        }
    }
    
    return balance;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%lld\n%lld\n%@\n%@\n%@\n%lld\n%@\n%@",
            self.dbId,
            self.groupId,
            self.receiptImageURL,
            self.type,
            self.user,
            self.amount,
            self.deadline,
            self.status];
}

- (void)dealloc { NSLog(@"dealloc - %@",[self class]); } 

@end
