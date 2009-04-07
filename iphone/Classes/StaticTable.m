//
//  StaticTable.m
//  JoeMetric
//
//  Created by Paul Wilson on 03/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "StaticTable.h"
#import "TableSection.h"

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
	[self removeAllSections];
	self.sections = nil;
	[super dealloc];	
}

+(id)staticTable{
    return [[self alloc] init];
}

-(void)addSection:(TableSection*)section{
	[sections addObject:section];
}

-(void)removeAllSections{
	[sections removeAllObjects];
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

-(void)handleErrors:(NSDictionary*)errors{
	for (TableSection* section in sections){
		[section handleErrors:errors];
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return [[sections objectAtIndex:section] footerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	TableSection* tableSection = [sections objectAtIndex:section];
	return tableSection.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	return [[sections objectAtIndex:section] footerView];
}



@end
