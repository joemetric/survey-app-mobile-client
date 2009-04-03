#import "GTMSenTestCase.h"
#import "TableSection.h"

@interface TableSectionTest : GTMTestCase {
	TableSection* testee;
}

@end


@implementation TableSectionTest


-(void)setUp{
	testee = [TableSection tableSection];
}

-(void)testInitiallyEmpty{
	STAssertEquals(0, (NSInteger) testee.rowCount, nil);
}

-(UITableViewCell*)cellWithText:(NSString*) text{
	UITableViewCell* result = [[[UITableViewCell alloc] init] autorelease];
	result.text = text;
	return result;
}

-(void)testAddingACell{
	[testee addCell:[self cellWithText:@"cell 1"]];
	STAssertEquals(1, (NSInteger) testee.rowCount, @"row count");
	STAssertNotNil([testee cellAtIndex:0], nil);
}

@end
