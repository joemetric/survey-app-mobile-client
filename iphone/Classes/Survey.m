//
//  Survey.m
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "Survey.h"

@implementation Survey

@synthesize name;
@synthesize amount;

+ (NSString *)resourceName
{
    return @"campaigns"; // TODO change to surveys after the rails app changes
}

+ (NSString *)resourceKey
{
    return @"campaign"; // TODO change to survey after the rails app changes
}

+ (id)newFromDictionary:(NSDictionary *) dict
{
    Survey *survey = [[Survey alloc] init];
    survey.itemId  = [[[dict objectForKey:[self resourceKey]] objectForKey:@"id"] integerValue];
    survey.name    = [[dict objectForKey:[self resourceKey]] objectForKey:@"name"];
    survey.amount  = [[dict objectForKey:[self resourceKey]] objectForKey:@"amount"];
    return survey;
}
    
- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:self.name forKey:@"name"];
    [parameters setObject:self.name forKey:@"amount"];

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[[self class] resourceKey]];

    [parameters release];
    return [container autorelease];
}

- (NSString *)amountAsDollarString
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setFormat:@"$#,##0.00"];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)nameAndAmountAsString
{
    return [NSString stringWithFormat:@"%@ : %@", [self amountAsDollarString], self.name];
}

- (NSArray *)questions
{
    return [[[NSArray alloc] init] autorelease];
}

- (void)dealloc {
    [self.name release];
    [self.amount release];
    [super dealloc];
}

@end

