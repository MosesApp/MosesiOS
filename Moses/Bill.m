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
#import "Group.h"
#import "Currency.h"

@implementation Bill

static NSMutableArray *sharedBills = nil;

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
            amount:(double)amount{
    
    self = [super init];
    if (self) {
        self.dbId = dbId;
        self.billId = billId;
        self.name = [NSString stringWithCString:[name cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        self.billDescription = [NSString stringWithCString:[billDescription cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        self.groupId = groupId;
        self.receiptImageURL = receiptImageURL;
        if([WebService validateUrl:self.receiptImageURL]){
            self.receiptImage = [WebService getImage: self.receiptImageURL];
        }
        self.billAmount = billAmount;
        self.date = date;
        self.relation = relation;
        self.status = [NSString stringWithCString:[status cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
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

+ (NSDictionary*)setBillWithName:(NSString *)name
                     description:(NSString *)description
                           group:(NSString *)group
                           image:(UIImage *)image
                          amount:(NSString *)amount
                        currency:(NSString *)currency
                         members:(NSArray *)members
{
    
    NSArray *objects = nil;
    
    // Get groupId based on selected one
    NSArray *groups = [Group sharedUserGroups];
    NSString *groupId = [[NSString alloc] init];
    for (Group *groupObj in groups) {
        if ([groupObj.name isEqualToString:group]) {
            groupId = [NSString stringWithFormat:@"%lld", groupObj.dbId];
        }
    }
    
    // Get currencyId based on selected one
    NSArray *currecies = [Currency sharedCurrencies];
    NSString *currencyId = [[NSString alloc] init];
    for (Currency *currencyObj in currecies) {
        if ([currencyObj.prefix isEqualToString:currency]) {
            currencyId = [NSString stringWithFormat:@"%lld", currencyObj.dbId];
        }
    }
    
    if(image != nil){
        NSString *encodedString = [UIImageJPEGRepresentation(image, 0) base64EncodedStringWithOptions:0];
        objects = [NSArray arrayWithObjects: name, description, groupId, encodedString, amount, currencyId, members, nil];
    }else{
        objects = [NSArray arrayWithObjects: name, description, groupId, [NSNull null], amount, currencyId, members, nil];
    }
    
    NSArray *keys = [NSArray arrayWithObjects:@"name", @"description", @"group", @"receipt_image", @"amount", @"currency", @"members", nil];

    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *billJSON = [WebService setDataWithJSONDict:dict serviceURL:[Settings getWebServiceCreateBill]];
    
    NSMutableDictionary *retMessage = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    if([billJSON objectForKey:@"id"] != nil){
        
        [retMessage setValue:@"Bill created successfully!" forKey:@"message"];
        [retMessage setValue:[NSNumber numberWithBool:true] forKey:@"success"];
        
        return retMessage;
    }
    [retMessage setObject:@"Failed to create Bill!" forKey:@"message"];
    [retMessage setValue:[NSNumber numberWithBool:false] forKey:@"success"];
    return retMessage;
}

+ (void)requestUserBills:(long long int)userId
{
    
    sharedBills = [[NSMutableArray alloc] init];
    
    NSDictionary *billJSON = [WebService getDataWithParam:[NSString stringWithFormat:@"%lld", userId] serviceURL:[Settings getWebServiceGetBillUser]];
    
    for (NSDictionary *serviceKey in billJSON) {
        if([serviceKey isEqual:@"results"]){
            for (NSDictionary *billDict in [billJSON objectForKey:serviceKey]) {
                
                NSDictionary* billDetail = billDict[@"bill"];
                // Format date string
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"];
                NSDate *date = [df dateFromString: billDetail[@"date"]];
                
                Bill *bill = [[Bill alloc] initWithdbId:[billDict[@"id"] intValue]
                                                 billId:[billDetail[@"id"] intValue]
                                                   name:billDetail[@"name"]
                                        billDescription:billDetail[@"description"]
                                                groupId:[billDetail[@"group"] intValue]
                                        receiptImageURL:billDetail[@"receipt_image"]
                                             billAmount:[billDetail[@"amount"] doubleValue]
                                                   date:date
                                               relation:billDict[@"relation"]
                                                 status:billDict[@"status"]
                                                 amount:[billDict[@"amount"] doubleValue]];

                [sharedBills addObject:bill];
            
            }
        }
    }
}

+ (NSDictionary*)getFinancialSituation
{
    NSMutableDictionary* financialSituation = [[NSMutableDictionary alloc] init];
    double owe = 0.0;
    double owed = 0.0;
    double balance = 0.0;
    
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
    
    financialSituation[@"owe"] = [NSNumber numberWithDouble:owe];
    financialSituation[@"owed"] = [NSNumber numberWithDouble:owed];
    financialSituation[@"balance"] = [NSNumber numberWithDouble:balance];
    
    return financialSituation;
    
}

+ (double)getBalanceForGroupId:(long long int)groupId
{
    double balance = 0.0;
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

+ (NSArray*)getBillsForGroupId:(long long int)groupId
{
    NSMutableArray* groupBills = [[NSMutableArray alloc] init];

    for (Bill* bill in sharedBills) {
        if(bill.groupId == groupId){
            [groupBills addObject:bill];
        }
    }
    
    return groupBills;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%lld\n%lld\n%@\n%@\n%lld\n%@\n%f\n%@\n%@\n%@",
            self.dbId,
            self.billId,
            self.name,
            self.billDescription,
            self.groupId,
            self.receiptImageURL,
            self.amount,
            self.date,
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
    _date = nil;
    _relation = nil;
    _status = nil;
    _amount = 0.0;
    NSLog(@"dealloc - %@",[self class]);
}

@end
