//
//  Metadata.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Metadata :  NSManagedObject  
{
	User * user;
}

@property (nonatomic, retain) User * user;

+ (void)saveWithUser:(User *)u;
+ (Metadata *)getMetadata;

@end



