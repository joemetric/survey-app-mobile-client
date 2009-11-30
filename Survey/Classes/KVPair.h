//
//  Income.h
//  Survey
//
//  Created by Allerin on 09-10-29.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KVPair : NSObject {
	NSNumber *pk;
	NSString *desc;
}

@property (retain) NSNumber *pk;
@property (retain) NSString *desc;

- (id)initWithPk:(NSNumber *)p Desc:(NSString *)d;

@end
