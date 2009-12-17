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
#import "RestRequest.h"
#import "UserRestRequest.h"


static NSPredicate *loginTemplate = nil;

@implementation User 

@dynamic pk;
@dynamic email;
@dynamic login;
@dynamic income_id;
@dynamic income;
@dynamic gender;
@dynamic name;
@dynamic password;
@dynamic birthday;
@dynamic zipcode;
@dynamic race_id;
@dynamic race;
@dynamic martial_id;
@dynamic martial;
@dynamic education_id;
@dynamic education;
@dynamic occupation_id;
@dynamic occupation;
@dynamic sort_id;
@dynamic sort;

+ (void)finalizeTemplates {
	if (loginTemplate) [loginTemplate release];
}

+ (id)saveUserWithPK:(NSNumber *)p Email:(NSString *)eml Login:(NSString *)log Income_id:(NSNumber *)ii Income:(NSString *)inc 
			  Gender:(NSString *)gen Name:(NSString *)nm Password:(NSString *)pwd  Birthday:(NSDate *)birth Zipcode:(NSString *)zc 
			 Race_id:(NSNumber *)ri Martial_id:(NSNumber *)mi Race:(NSString *)ra	Martial:(NSString *)ma 
		Education_id:(NSNumber *)ei Education:(NSString *)edu Occupation_id:(NSNumber *)oi Occupation:(NSString *)ocp
			 Sort_id:(NSNumber *)si Sort:(NSString *)so {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
	if (loginTemplate == nil) {
		loginTemplate = [[NSPredicate predicateWithFormat:@"login = $login"] retain];
	}
	NSPredicate *predicate = [loginTemplate predicateWithSubstitutionVariables:[NSDictionary dictionaryWithObject:log forKey:@"login"]];
	[request setPredicate:predicate];
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	User *user = nil;
	if (mutableFetchResults == nil) {
		// Handle the error.
	} else if ([mutableFetchResults count] == 0) {
		user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];	
	} else if ([mutableFetchResults count] > 0) {
		user = (User *)[mutableFetchResults objectAtIndex:0];
	}
	[user setPk:p];
	[user setEmail:eml];
	[user setLogin:log];
	[user setIncome_id:ii];
	[user setIncome:inc];
	[user setGender:gen];
	[user setName:nm];
	[user setPassword:pwd];
	[user setBirthday:birth];
	[user setZipcode:zc];
	[user setRace_id:ri];
	[user setRace:ra];
	[user setMartial_id:mi];
	[user setMartial:ma];
	[user setEducation_id:ei];
	[user setEducation:edu];
	[user setOccupation_id:oi];
	[user setOccupation:ocp];
	[user setSort_id:si];
	[user setSort:so];
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

- (BOOL)save:(NSError **)error {
	// TODO: save the local db or waiting for next sync with the server?
	return [RestRequest saveWithUser:self Error:error]; 
}

@end
