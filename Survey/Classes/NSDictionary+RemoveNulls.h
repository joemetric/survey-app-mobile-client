//
//  NSDictionary+RemoveNulls.h
//  JoeMetric
//
//  Created by Paul Wilson on 03/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary(RemoveNulls)
-(NSDictionary*)withoutNulls;
@end
