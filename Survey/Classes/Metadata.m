// 
//  Metadata.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Metadata.h"
#import "User.h"
#import "SurveyAppDelegate.h"

@implementation Metadata 

@dynamic user;

+ (Metadata *)getMetadata {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Metadata" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
	NSError *error;
	NSArray *array = [delegate.managedObjectContext executeFetchRequest:request error:&error];
	[request release];
	if ([array count] > 0) {
		return (Metadata *)[array objectAtIndex:0];
	} else {
		return nil;
	}
	
}

@end
