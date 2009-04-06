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


-(void)testFooterViewIsInitiallyEmpty{
	STAssertNotNil(testee.footerView, nil);
	STAssertEquals(0, (NSInteger) testee.footerView.subviews.count, @"subview count");
}

-(void)testSettingOneFooter{
	[testee setFooterLines:[NSArray arrayWithObject:@"a line of footer"]];
	STAssertEquals(1, (NSInteger) testee.footerView.subviews.count, @"subview count");
	STAssertEqualStrings(@"a line of footer",  [[testee.footerView.subviews objectAtIndex:0] text], @"label text");
	
}


-(void)testSettingTwoFooters{
	[testee setFooterLines:[NSArray arrayWithObjects:@"a line of footer", @"a second line of footer", nil]];
	STAssertEquals(2, (NSInteger) testee.footerView.subviews.count, @"subview count");
	STAssertEqualStrings(@"a line of footer",  [[testee.footerView.subviews objectAtIndex:0] text], @"label text");
	STAssertEqualStrings(@"a second line of footer",  [[testee.footerView.subviews objectAtIndex:1] text], @"label text");
	
}

-(void)testSettingFooterLinesOverwritesPreviousFooters{
	[testee setFooterLines:[NSArray arrayWithObjects:@"original 1", @"original 2", nil]];
	[testee setFooterLines:[NSArray arrayWithObject:@"replacement"]];
	STAssertEquals(1, (NSInteger) testee.footerView.subviews.count, @"subview count");
	STAssertEqualStrings(@"replacement",  [[testee.footerView.subviews objectAtIndex:0] text], @"label text");
	
}


-(void)assertFooterHeight:(NSInteger)height{
	STAssertEquals(height, testee.footerHeight, @"footer height");
	STAssertEquals(height, (NSInteger) testee.footerView.frame.size.height, @"view height");
	
}

-(void)testFooterViewHeightAndPlacementIncreasesWithTheNumberofLines{
	[self assertFooterHeight:0];
	[testee setFooterLines:[NSArray arrayWithObject:@"1"]];
	[self assertFooterHeight:40];
	[testee setFooterLines:[NSArray arrayWithObjects:@"original 1", @"original 2", nil]];
	[self assertFooterHeight:80];
}

-(void)assertLabel:(UILabel*)label yPlacement:(CGFloat)yPlacement{
	STAssertEquals(yPlacement, label.frame.origin.y, [NSString stringWithFormat:@"%f == %f", yPlacement, label.frame.origin.y]);
}


-(void)testFooterLabelsSpacedBelowThePrevious{
	[testee setFooterLines:[NSArray arrayWithObjects:@"1", @"2", @"3", nil]];
	NSArray* labels = testee.footerView.subviews;
	[self assertLabel:[labels objectAtIndex:0] yPlacement:0];
	[self assertLabel:[labels objectAtIndex:1] yPlacement:40];
	[self assertLabel:[labels objectAtIndex:2] yPlacement:80];
	
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

-(void)testErrorsThatAffectSectionsCellsAreAddedAsFooterLines{
	[testee addCell:[StubCellWithError stubCellWithText:@"cell 1" errorField:@"cell1"]];
	[testee addCell:[StubCellWithError stubCellWithText:@"cell 3" errorField:@"cell2"]];
	
	NSMutableDictionary *errors = [NSMutableDictionary dictionary];
	[errors setObject:[NSArray arrayWithObject:@"cell1err1"] forKey:@"cell1"];
	[errors setObject:[NSArray arrayWithObject:@"not relevant"] forKey:@"not relevant"];
	[errors setObject:[NSArray arrayWithObjects:@"cell2err1", @"cell2err2", nil] forKey:@"cell2"];
	[testee handleErrors:errors];
	
	STAssertEquals(3, (NSInteger) testee.footerView.subviews.count, @"footer line count");
	STAssertEqualStrings(@"cell1 cell1err1", [[testee.footerView.subviews objectAtIndex:0] text], nil);
	STAssertEqualStrings(@"cell2 cell2err1", [[testee.footerView.subviews objectAtIndex:1] text], nil);
	STAssertEqualStrings(@"cell2 cell2err2", [[testee.footerView.subviews objectAtIndex:2] text], nil);
	
}

@end
