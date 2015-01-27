//
//  NSString+FormValidation.m
//  SimpleForm
//
//  Created by Blake on 2/15/14.
//  Copyright (c) 2014 BlakeAnderson. All rights reserved.
//

#import "NSString+FormValidation.h"

@implementation NSString (FormValidation)

- (BOOL)isValidGroupName {
	return (self.length >= 1);
}

@end
