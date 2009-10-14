//
//  Survey.h
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Survey : NSObject {
	NSInteger pk;
	NSString *name;
	NSString *description;
	
	NSMutableArray *questions;
}

@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSMutableArray *questions;

- (id)initWithPk:(NSInteger)p Name:(NSString *)n Description:(NSString *)d;

@end
