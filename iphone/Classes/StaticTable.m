//
//  StaticTable.m
//  JoeMetric
//
//  Created by Paul Wilson on 03/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "StaticTable.h"
#import "TableSection.h"
#import "Editable.h"

@interface StaticTable()
@property(nonatomic, retain) NSMutableArray* sections;
@property(nonatomic, retain) UITableView* tableView;
@end

@implementation StaticTable
@synthesize sections, tableView;

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

+(id)staticTableForTableView:(UITableView*)tableView{
    StaticTable* result =  [[[self alloc] init] autorelease];
	result.tableView = tableView;
	return result;
}

-(void)addSection:(TableSection*)section{
	section.tableView = tableView;
	section.section = [sections count];
	section.staticTable = self;
	[sections addObject:section];
}

-(void)removeAllSections{
	[sections removeAllObjects];
}

-(void)activeSubsequentTextField:(UITextField*)textField{
	BOOL activateNext = NO;
	BOOL subsequentFound = NO;
	for (TableSection* section in sections){
		for (int i = 0; i < [section rowCount] && !subsequentFound; i++){
			UITableViewCell* cell = [section cellAtIndex:i];
			if (activateNext) {
				[cell ifEditableActivateEditing];
				subsequentFound = YES;
			}
			if ([cell isMyEditableTextField:textField]) activateNext = YES;
		}
		if (subsequentFound) break;
	}
}


- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell = [self tableView:tv cellForRowAtIndexPath:indexPath];
	[cell ifEditableActivateEditing];
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

-(TableSection*) sectionAtIndex:(NSInteger)index{
	return [sections objectAtIndex:index];
}


@end
