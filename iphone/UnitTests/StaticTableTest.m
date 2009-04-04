#import "GTMSenTestCase.h"
#import "StaticTable.h"
#import "TableSection.h"
#import "StubCellWithError.h"

@interface StaticTableTest : GTMTestCase{
	StaticTable* testee;
	TableSection* section1;
	TableSection* section2;
}

@end

@implementation StaticTableTest 

-(UITableViewCell*)cellWithText:(NSString*) text{
	UITableViewCell* result = [[[UITableViewCell alloc] init] autorelease];
	result.text = text;
	return result;
}


-(void)setUp{
	testee = [StaticTable staticTable]; 
	section1 = [TableSection tableSectionWithTitle:@"section 1"];
	[testee addSection:section1];
	[section1 addCell:[self cellWithText:@"s0r0"]];
	[section1 addCell:[self cellWithText:@"s0r1"]];
	[section1 addCell:[self cellWithText:@"s0r2"]];

	section2 = [TableSection tableSectionWithTitle:@"section 2"];
	[testee addSection:section2];
	[section2 addCell:[self cellWithText:@"s1r0"]];
	[section2 addCell:[self cellWithText:@"s1r1"]];

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

-(void)testA{
	UIView* parent = [[UIView alloc] init];
	UIView* child = [[UIView alloc] init];
	[parent addSubview:child];
	STAssertEquals(2, (NSInteger)[child retainCount], nil);
	[parent release];
	STAssertEquals(1, (NSInteger)[child retainCount], nil);
	
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
	StubCellWithError* errorCell = [StubCellWithError stubCellWithText:@"" errorField:@"err"];
	[section1 addCell:errorCell];

	NSMutableDictionary *errors = [NSMutableDictionary dictionary];
	[errors setObject:[NSArray arrayWithObject:@"an error"] forKey:@"err"];
	
	[testee handleErrors:errors];
	
	STAssertEquals(YES, errorCell.errorHighlighted, nil);
}

@end
