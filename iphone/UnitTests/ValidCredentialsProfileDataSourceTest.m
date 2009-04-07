#import "GTMSenTestCase.h"
#import "ValidCredentialsProfileDataSource.h"
#import "Account.h"
#import "LabelledTableViewReadOnlyCell.h"
#import "AccountStubbing.h"



@interface ValidCredentialsProfileDataSourceTest : GTMTestCase{
	ValidCredentialsProfileDataSource *testee;
	NSDateFormatter *dateFormatter;
}
@end


@implementation ValidCredentialsProfileDataSourceTest


-(void)setUp{
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";

	gAccount = [[Account alloc] init];
	gAccount.email = @"hello@blah.com";
	gAccount.username = @"Sue";
	gAccount.income = 12345;
	gAccount.gender = @"F";
	gAccount.birthdate = [dateFormatter dateFromString:@"1953-05-17"];

	testee = [[ValidCredentialsProfileDataSource alloc] init];
	
}

-(void) tearDown{
	[gAccount release];
	[testee release];
	[dateFormatter release];
}

-(void)assertCorrectValue:(NSString*)value forSection:(NSInteger)section row:(NSInteger)row label:(NSString*) label{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	LabelledTableViewReadOnlyCell *cell = (LabelledTableViewReadOnlyCell*)[testee tableView:nil cellForRowAtIndexPath:indexPath];
    STAssertNotNil(cell, [NSString stringWithFormat:@"cell for %@", label]);
    STAssertNotNil(cell.valueField, [NSString stringWithFormat:@"value field for %@", label]);
    STAssertNotNil(cell.label, [NSString stringWithFormat:@"label for %@", label]);
	STAssertEqualStrings( value, cell.valueField.text, [NSString stringWithFormat:@"value text for %@", label]);	
	STAssertEqualStrings( label, cell.label.text, [NSString stringWithFormat:@"label text for %@", label]);	
}

-(void) testReturnsCorrectCellForIndexPath{
	[self assertCorrectValue:@"Sue" forSection:0 row:0 label:@"username"];

	[self assertCorrectValue:@"hello@blah.com" forSection:1 row:0 label:@"email"];	
	[self assertCorrectValue:@"17 May 1953" forSection:1 row:1 label:@"date of birth"];	
	[self assertCorrectValue:@"$12,345" forSection:1 row:2 label:@"income"];
	[self assertCorrectValue:@"Female" forSection:1 row:3 label:@"gender"];
}

-(void)testDefaultBlankValues{
	gAccount.birthdate = nil;
	gAccount.income = 0;
	[testee changeInAccount:gAccount];
	[self assertCorrectValue:@"$0" forSection:1 row:2 label:@"income"];
	[self assertCorrectValue:@"" forSection:1 row:1 label:@"date of birth"];
}

-(void)testValueChangesIfAccountChanges{
	gAccount.username = @"Norman";
	gAccount.gender = @"M";
	[testee changeInAccount:gAccount];
	[self assertCorrectValue:@"Norman" forSection:0 row:0 label:@"username"];
	[self assertCorrectValue:@"Male" forSection:1 row:3 label:@"gender"];
	STAssertEquals(2, [testee numberOfSectionsInTableView:nil], @"still only 2 sections");
}





@end
