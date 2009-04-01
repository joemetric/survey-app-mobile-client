#import "GTMSenTestCase.h"
#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "SegmentedTableViewCell.h"

@interface NewAccountViewControllerTest: GTMTestCase{
	NewAccountViewController* testee;
}

@end


@implementation NewAccountViewControllerTest

-(void)setUp{
	testee = [[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil];
}

-(void)tearDown{
	[testee release];
}

-(void)assertLabel:(NSString*)label inLabelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	LabelledTableViewCell* cell = (LabelledTableViewCell*)[testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
	STAssertEqualStrings(label, cell.label.text, [NSString stringWithFormat:@"row: %d, section: %d", row, section]);
	
}

-(void)assertLabel:(NSString*)label inSegmentedCellForRow:(NSInteger)row inSection:(NSInteger)section{
	SegmentedTableViewCell* cell = (SegmentedTableViewCell*)[testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
	STAssertEqualStrings(label, cell.label.text, [NSString stringWithFormat:@"row: %d, section: %d", row, section]);
	
}


-(void)testMainSectionCellLabels{
	[self assertLabel:@"Login" inLabelledCellForRow:0 inSection:0];
	[self assertLabel:@"Password" inLabelledCellForRow:1 inSection:0];
	[self assertLabel:@"Confirm P/W " inLabelledCellForRow:2 inSection:0];
	[self assertLabel:@"Email" inLabelledCellForRow:3 inSection:0];   
    STAssertEquals(4, [testee tableView:nil numberOfRowsInSection:0], @"rows in section 0");
}

-(void)testDemographicsSectionCellLabels{
	[self assertLabel:@"Income" inLabelledCellForRow:0 inSection:1];
	[self assertLabel:@"Birthdate" inLabelledCellForRow:1 inSection:1];
	[self assertLabel:@"Gender" inSegmentedCellForRow:2 inSection:1];
    STAssertEquals(3, [testee tableView:nil numberOfRowsInSection:1], @"rows in section 1");
}


@end
