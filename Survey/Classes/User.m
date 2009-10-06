// 
//  User.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "User.h"
#import "SurveyAppDelegate.h"
#import "Metadata.h"


static NSPredicate *loginTemplate = nil;

@implementation User 

@dynamic email;
@dynamic login;
@dynamic income;
@dynamic gender;
@dynamic name;
@dynamic password;
@dynamic birthday;

+ (void)finalizeTemplates {
	if (loginTemplate) [loginTemplate release];
}

+ (id)saveUserWithEmail:(NSString *)eml Login:(NSString *)log Income:(NSString *)inc 
				 Gender:(NSString *)gen Name:(NSString *)nm Password:(NSString *)pwd  Birthday:(NSDate *)birth {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
	if (loginTemplate == nil) {
		 [[NSPredicate predicateWithFormat:@"login = $login"] retain];
	}
	NSPredicate *predicate = [loginTemplate predicateWithSubstitutionVariables:[NSDictionary dictionaryWithObject:log forKey:@"login"]];
	[request setPredicate:predicate];
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	User *user;
	if (mutableFetchResults == nil) {
		// Handle the error.
	} else if ([mutableFetchResults count] == 0) {
		user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];	
	} else if ([mutableFetchResults count] > 0) {
		user = (User *)[mutableFetchResults objectAtIndex:0];
	}
	[user setEmail:eml];
	[user setLogin:log];
	[user setIncome:inc];
	[user setGender:gen];
	[user setName:nm];
	[user setPassword:pwd];
	[user setBirthday:birth];
	int success = [delegate.managedObjectContext save:&error];
	if (!success) {
		// Handle the error.
	} else {
		[Metadata saveWithUser:user];
	}
	[request release];
		
	return user;	
}

- (NSString *)birthdate {
	if (self.birthday == nil)
		return nil;
	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	}
	return [dateFormatter stringFromDate:self.birthday];
}

- (void)didTurnIntoFault {
	[dateFormatter release];
}

@end
