//
//  Income.h
//  Survey
//
//  Created by Ye Dingding on 09-10-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Income : NSObject {
	NSNumber *pk;
	NSString *desc;
}

@property (retain) NSNumber *pk;
@property (retain) NSString *desc;

- (id)initWithPk:(NSNumber *)p Desc:(NSString *)d;

@end
