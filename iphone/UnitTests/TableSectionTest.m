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

-(void)testAddingCells{
	[testee addCell:[self cellWithText:@"cell 1"]];
	[testee addCell:[self cellWithText:@"cell 2"]];
	STAssertEquals(2, (NSInteger) testee.rowCount, @"row count");
    STAssertEqualStrings(@"cell 1", [[testee cellAtIndex:0] text], nil);
    STAssertEqualStrings(@"cell 2", [[testee cellAtIndex:1] text], nil);
}

-(void)testCellsAreRetained{
	UITableViewCell* cell =  [self cellWithText:@""];
    [testee addCell:cell];
    STAssertEquals(2, (NSInteger)[cell retainCount], nil);
}

-(void)testReleasesCells{
    testee = [[TableSection alloc] init];
	UITableViewCell* cell =  [self cellWithText:@""];
    [testee addCell:cell];
    [testee release];
    STAssertEquals(1, (NSInteger)[cell retainCount], nil);
    
}

@end
