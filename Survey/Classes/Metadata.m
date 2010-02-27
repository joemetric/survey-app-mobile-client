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

+ (void)saveWithUser:(User *)u {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Metadata" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	Metadata *metadata = nil;
	if (mutableFetchResults == nil) {
		// Handle the error.
	} else if ([mutableFetchResults count] == 0) {
		metadata = (Metadata *)[NSEntityDescription insertNewObjectForEntityForName:@"Metadata" inManagedObjectContext:delegate.managedObjectContext];	
	} else if ([mutableFetchResults count] > 0) {
		metadata = (Metadata *)[mutableFetchResults objectAtIndex:0];
	}
	[metadata setUser:u];
	int success = [delegate.managedObjectContext save:&error];
	if (!success) {
		// Handle the error.
	}
	[request release];
	[mutableFetchResults release];
	[delegate setMetadata:metadata];
}

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
