#import "GTMSenTestCase.h"
#import "StaticTable.h"
#import "TableSection.h"

@interface StaticTableTest : GTMTestCase{
	StaticTable* testee;
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
	TableSection* section1 = [TableSection tableSection];
	[testee addSection:section1];
	[section1 addCell:[self cellWithText:@"s0r0"]];
	[section1 addCell:[self cellWithText:@"s0r1"]];
	[section1 addCell:[self cellWithText:@"s0r2"]];

	TableSection* section2 = [TableSection tableSection];
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


-(void)testSectionRetainedAndReleased{
	TableSection* section = [TableSection tableSection];
	testee = [[StaticTable alloc] init];
	[testee addSection:section];
	STAssertEquals(2, (NSInteger)[section retainCount] ,nil);
	[testee release];
	STAssertEquals(1, (NSInteger)[section retainCount] ,nil);

}

@end
