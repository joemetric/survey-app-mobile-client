//
//  MiscRestRequest.h
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestRequest.h"


@interface RestRequest (MiscOperation)

+ (NSMutableArray *)getIncomeArray:(NSError **)error;

@end