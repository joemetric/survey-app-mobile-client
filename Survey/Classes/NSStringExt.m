//
//  NSStringExt.m
//  funeral
//
//  Created by Allerin on 09-9-18.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "NSStringExt.h"


@implementation NSString (StringEncoder)

+ (NSString *)encodeString:(NSString *)string {
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("% '\"?=&+<>;:-@"), kCFStringEncodingUTF8);
	return [result autorelease];
}

@end
