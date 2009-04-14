#import "GTMSenTestCase.h"
#import "StaticTable.h"
#import "TableSection.h"
#import "StubEditable.h"



@interface StaticTableTest : GTMTestCase{
	StaticTable* testee;
	TableSection* section1;
	TableSection* section2;
	UITableView* tableView;
}

@end



@implementation StaticTableTest 

-(UITableViewCell*)cellWithText:(NSString*) text{
	UITableViewCell* result = [[[UITableViewCell alloc] init] autorelease];
	result.text = text;
	return result;
}



-(void)setUp{
	tableView = [[UITableView alloc] init];
	testee = [StaticTable staticTableForTableView:tableView]; 
	section1 = [TableSection tableSectionWithTitle:@"section 1"];
	[testee addSection:section1];
	[section1 addCell:[self cellWithText:@"s0r0"]];
	[section1 addCell:[self cellWithText:@"s0r1"]];
	[section1 addCell:[self cellWithText:@"s0r2"]];
	[section1 setFooterLines:[NSArray arrayWithObject:@"section 1 footer"]];

	section2 = [TableSection tableSectionWithTitle:@"section 2"];
	[testee addSection:section2];
	[section2 addCell:[self cellWithText:@"s1r0"]];
	[section2 addCell:[self cellWithText:@"s1r1"]];

}


-(void)tearDown{
	[tableView release];
}

-(void)testRowAndSectionCount{
	STAssertEquals(2, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView:");	
	STAssertEquals(3, [testee tableView:nil numberOfRowsInSection:0], @"tableView:numberOfRowsInSection:");	
	STAssertEquals(2, [testee tableView:nil numberOfRowsInSection:1], @"tableView:numberOfRowsInSection:");	
}

-(void)testCellForRowAtIndexPath{
	STAssertEqualStrings(@"s0r0", [[testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] text], nil);
	STAssertEqualStrings(@"s1r1", [[testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]] text], nil);
}

-(void)assertHeaderViewWithIndex:(NSInteger)index text:(NSString*)text{
	UIView* headerView = [testee tableView:nil viewForHeaderInSection:index];
	UILabel* label = [headerView.subviews objectAtIndex:0];
	STAssertEqualStrings(text, label.text, nil);
}

-(void) testSectionHeaders{
	[self assertHeaderViewWithIndex:0 text:@"section 1"];
	[self assertHeaderViewWithIndex:1 text:@"section 2"];	
}


-(void) testFooter{
	UIView* footerView = [testee tableView:nil  viewForFooterInSection:0];
	STAssertNotNil(footerView, nil);
	STAssertEqualStrings(@"section 1 footer", [[footerView.subviews objectAtIndex:0] text], nil);
	STAssertEquals((float)30, [testee tableView:nil heightForFooterInSection:0], nil);
}



-(void)testSectionRetainedAndReleased{
	TableSection* section = [TableSection tableSectionWithTitle:@""];
	testee = [[StaticTable alloc] init];
	[testee addSection:section];
	STAssertEquals(2, (NSInteger)[section retainCount] ,nil);
	[testee release];
	STAssertEquals(1, (NSInteger)[section retainCount] ,nil);
}

-(void)testHandlesErrors{
	StubEditable* errorCell = [StubEditable stubCellWithText:@"" errorField:@"err"];
	[section1 addCell:errorCell];

	NSMutableDictionary *errors = [NSMutableDictionary dictionary];
	[errors setObject:[NSArray arrayWithObject:@"an error"] forKey:@"err"];
	
	[testee handleErrors:errors];
	
	STAssertEquals(YES, errorCell.errorHighlighted, nil);
}

-(void)testRemovingAllSections{
	[testee removeAllSections];
	STAssertEquals(0, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView:");	
	
}

-(void)testWhenReturnAndNoSubsequentResponsiveCellNothingBadHappens{
	[section1 textFieldShouldReturn:[[[UITextField alloc] init] autorelease]];
	
}

-(void)testWhenTextFieldReturnsNextCellIsSelectedInSameSection{
	StubEditableWithTextField* finished = [StubEditableWithTextField stubEditableWithTextField];
	StubEditableWithTextField* next = [StubEditableWithTextField stubEditableWithTextField];
	
	[section1 addCell:finished];
	[section1 addCell:next];
	
	[section1 textFieldShouldReturn:finished.textField];	
	STAssertTrue(next.activated, nil);	
}

-(void)testIfNextCellIsNotEditableThenNoCellIsSelected{
	StubEditableWithTextField* finished = [StubEditableWithTextField stubEditableWithTextField];
	UITableViewCell* next = [[[UITableViewCell alloc] init] autorelease];
	StubEditableWithTextField* subsequent = [StubEditableWithTextField stubEditableWithTextField];
	
	[section1 addCell:finished];
	[section1 addCell:next];
	[section1 addCell:subsequent];
	
	[section1 textFieldShouldReturn:finished.textField];	
	STAssertFalse(subsequent.activated, nil);		
}

-(void)testNextCellInNextSectionIsActivatedIfLastInSection{
	StubEditableWithTextField* finished = [StubEditableWithTextField stubEditableWithTextField];
	StubEditableWithTextField* next = [StubEditableWithTextField stubEditableWithTextField];
	
	[section2 addCell:finished];
	TableSection* section3 = [TableSection tableSectionWithTitle:@""];
	[testee addSection:section3];
	[section3 addCell:next];
	
	[section2 textFieldShouldReturn:finished.textField];	
	STAssertTrue(next.activated, nil);	
	
}

-(void)testIfLastInSectionAndNextCellIsNotEditableThenSubsequentIsNotEdited{
	StubEditableWithTextField* finished = [StubEditableWithTextField stubEditableWithTextField];
	UITableViewCell* next = [[[UITableViewCell alloc] init] autorelease];
	StubEditableWithTextField* subsequent = [StubEditableWithTextField stubEditableWithTextField];
	
	[section2 addCell:finished];
	TableSection* section3 = [TableSection tableSectionWithTitle:@""];
	[testee addSection:section3];
	[section3 addCell:next];
	[section3 addCell:subsequent];
	
	[section2 textFieldShouldReturn:finished.textField];	
	STAssertFalse(subsequent.activated, nil);	
	
}


-(void)testSelectingRowAtIndexPathActivatesEditableCell{
	StubEditableWithTextField* editable = [StubEditableWithTextField stubEditableWithTextField];
	[section1 addCell:editable];
	[testee tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
	STAssertTrue(editable.activated, nil);
}
-(void)testSelectingRowAtIndexPathIgnoresUneditableCell{
	[testee tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
}


@end
