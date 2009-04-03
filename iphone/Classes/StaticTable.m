//
//  StaticTable.m
//  JoeMetric
//
//  Created by Paul Wilson on 03/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "StaticTable.h"

@interface StaticTable()
@property(nonatomic, retain) NSMutableArray* sections;
@end

@implementation StaticTable
@synthesize sections;

-(id)init{
	[super init];
	self.sections = [NSMutableArray array];
	return self;
}

-(void) dealloc{
	[self.sections removeAllObjects];
	self.sections = nil;
	[super dealloc];	
}

+(id)staticTable{
    return [[self alloc] init];
}

-(void)addSection:(TableSection*)section{
	[sections addObject:section];
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [[sections objectAtIndex:section] rowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TableSection* tableSection = [sections objectAtIndex:indexPath.section];
	return [tableSection cellAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return sections.count;
}

@end
