#import "GTMSenTestCase.h"
#import "ValidCredentialsProfileDataSource.h"
#import "Account.h"
#import "LabelledTableViewReadOnlyCell.h"



@interface ValidCredentialsProfileDataSourceTest : GTMTestCase{
	Account *account;
	ValidCredentialsProfileDataSource *testee;
	NSDateFormatter *dateFormatter;
}
@end


@implementation ValidCredentialsProfileDataSourceTest


-(void)setUp{
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";

	account = [[Account alloc] init];
	account.email = @"hello@blah.com";
	account.username = @"Sue";
	account.income = 12345;
	account.gender = @"F";
	account.birthdate = [dateFormatter dateFromString:@"1953-05-17"];

	testee = [[ValidCredentialsProfileDataSource alloc] init];
	testee.account = account;
}

-(void) tearDown{
	[account release];
	[testee release];
	[dateFormatter release];
}


-(void)assertCorrectValue:(NSString*)value forSection:(NSInteger)section row:(NSInteger)row label:(NSString*) label{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	LabelledTableViewReadOnlyCell *cell = [testee tableView:nil cellForRowAtIndexPath:indexPath];
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
	[self assertCorrectValue:@"F" forSection:1 row:3 label:@"gender"];
}


-(void) testNumberFormatter{
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	// [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setFormat:@"0.00%;0.00%;-0.00%"];
	NSNumber *four = [NSNumber numberWithFloat:4.0];
	NSLog(@"%@", [numberFormatter stringFromNumber:four]);	
}



@end
