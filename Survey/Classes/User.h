//
//  User.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface User :  NSManagedObject  
{
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) NSNumber * pk;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSNumber * income_id;
@property (nonatomic, retain) NSString * income;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * zipcode;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * race;
@property (nonatomic, retain) NSNumber * race_id;
@property (nonatomic, retain) NSString * martial;
@property (nonatomic, retain) NSNumber * martial_id;

+ (void)finalizeTemplates;
+ (id)saveUserWithPK:(NSNumber *)p Email:(NSString *)eml Login:(NSString *)log Income_id:(NSNumber *)ii Income:(NSString *)inc 
			  Gender:(NSString *)gen Name:(NSString *)nm Password:(NSString *)pwd Birthday:(NSDate *)birth Zipcode:(NSString *)zc
			 Race_id:(NSNumber *)ri Martial_id:(NSNumber *)mi Race:(NSString *)ra	Martial:(NSString *)ma;

- (NSString *)birthdate;
- (BOOL)save:(NSError **)error;
   
@end



