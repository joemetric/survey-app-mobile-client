//
//  MetadataTests.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "MetadataTests.h"

@implementation MetadataTests

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
 	id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
	STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");

}

#else                           // all code under test must be linked into the Unit Test bundle
- (void) testMath {    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
}

#endif

@end