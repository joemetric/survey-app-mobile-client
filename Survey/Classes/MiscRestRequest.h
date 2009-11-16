//
//  MiscRestRequest.h
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestRequest.h"


@interface RestRequest (MiscOperation)

+ (NSMutableArray *)getIncomeArray:(NSError **)error;

@end
