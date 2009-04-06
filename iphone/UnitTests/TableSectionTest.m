#import "GTMSenTestCase.h"
#import "TableSection.h"
#import "HasError.h"
#import "StubCellWithError.h"

@interface TableSectionTest : GTMTestCase {
	TableSection* testee;
}

@end




@implementation TableSectionTest


-(void)setUp{
	testee = [TableSection tableSectionWithTitle:@"section title"];
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


-(void)testHeader{
	STAssertNotNil(testee.headerView, @"header");
	STAssertNotNil([testee.headerView.subviews objectAtIndex:0], @"subview");
	STAssertEqualStrings(@"section title", [[testee.headerView.subviews objectAtIndex:0] text], nil);
}

-(void)assertCellAtIndex:(NSUInteger)index error:(BOOL)error{
	StubCellWithError* cell = (StubCellWithError*)[testee cellAtIndex:index];
	STAssertEquals(error, cell.errorHighlighted, cell.text);
	
}
-(void)testErrorsAddedToAppropriateCells{
	[testee addCell:[StubCellWithError stubCellWithText:@"cell 1" errorField:@"cell1"]];
	[testee addCell:[self cellWithText:@"cell 2"]];
	[testee addCell:[StubCellWithError stubCellWithText:@"cell 3" errorField:@"cell3"]];
	
	NSMutableDictionary *errors = [NSMutableDictionary dictionary];
	[errors setObject:[NSArray arrayWithObject:@"cell1err1"] forKey:@"cell1"];
	
	[testee handleErrors:errors];
	
	[self assertCellAtIndex:0 error:YES];
	[self assertCellAtIndex:2 error:NO];
}

@end
