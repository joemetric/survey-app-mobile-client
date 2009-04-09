//
//  NSObject+CleanUpProperties.h
//  JoeMetric
//
//  Created by Paul Wilson on 09/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
// Based on http://vgable.com/blog/2008/12/20/automatically-freeing-every-property/
//

#import <Foundation/Foundation.h>


@interface NSObject(CleanUpProperties) 
- (void) setEveryObjCObjectPropertyToNil;
@end
