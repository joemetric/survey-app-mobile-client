//
//  NSDictionary+RemoveNulls.m
//  JoeMetric
//
//  Created by Paul Wilson on 03/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "NSDictionary+RemoveNulls.h"


@implementation NSDictionary(RemoveNulls)
-(NSDictionary*)withoutNulls{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    for (NSObject* key in self.allKeys){
        NSObject* v = [self objectForKey:key];
        if ([NSNull null] != v) [result setObject:v forKey:key];
    }
    return result;
}

@end
