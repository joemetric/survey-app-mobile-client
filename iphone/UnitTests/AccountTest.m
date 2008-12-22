//
//  AccountTest.m
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "AccountTest.h"


@implementation AccountTest

- (void) testIsNotCreatedIfCredentailsAreMissing
{
    assert(![Account isCreated]);
}

@end
