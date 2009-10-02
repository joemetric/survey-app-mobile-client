//
//  Metadata.h
//  Survey
//
//  Created by Ye Dingding on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Metadata :  NSManagedObject  
{
}

@property (nonatomic, retain) User * user;

+ (Metadata *)getMetadata;

@end



