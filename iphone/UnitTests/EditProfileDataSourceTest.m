#import "GTMSenTestCase.h"
#import "EditProfileDataSource.h"
#import "AccountStubbing.h"
#import "MaleFemaleTableViewCell.h"
#import "LabelledTableViewCell.h"
#import "DateHelper.h"

@interface EditProfileDataSourceTest : GTMTestCase {
    EditProfileDataSource* testee;
    UIViewController* parentController;
}
@end

@implementation EditProfileDataSourceTest

-(void)setUp{
    gAccount = [[[Account alloc] init] autorelease];
    gAccount.username = @"Marvin";
    gAccount.email = @"marvin@marvin.nyet";
    gAccount.income = 56789;
    gAccount.birthdate = [NSDate dateWithNaturalLanguageString:@"23 August 1967"];
    gAccount.gender = @"F";
    parentController = [[[UIViewController alloc] init] autorelease];
    testee = [EditProfileDataSource editProfileDataSourceWithParentViewController:parentController];
}


-(void)testParentControllerSetOnDobCell{
    STAssertEqualObjects(parentController, [testee.dobCell parentController], nil);
}


-(void)assertCellAtRow:(NSInteger)row inSection:(NSInteger)section hasLabel:(NSString*)label andValue:(NSString*)value{
    LabelledTableViewCell* cell = [testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    STAssertEqualStrings(label, cell.label.text, @"label");
    STAssertEqualStrings(value, cell.textField.text, [NSString stringWithFormat:@"value for %@", label]);
}

-(void)testCorrectFieldsPopulatedInCorrectPlace{
    [self assertCellAtRow:0 inSection:0 hasLabel:@"username" andValue:@"Marvin"];
    [self assertCellAtRow:0 inSection:1 hasLabel:@"email" andValue:@"marvin@marvin.nyet"];
    [self assertCellAtRow:1 inSection:1 hasLabel:@"date of birth" andValue:@"23 Aug 1967"];
    [self assertCellAtRow:2 inSection:1 hasLabel:@"income" andValue:@"56789"];
    MaleFemaleTableViewCell* gender = [testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    STAssertEqualStrings(@"gender", gender.label.text, @"label");
    STAssertEqualStrings(@"F", gender.gender, @"gender");
}

-(void)testAccountDetailsChangedOnFinishedEditing{
	testee.emailCell.textField.text = @"marvinatyahoodotcom@hotmail.com";
    testee.dobCell.date = [DateHelper dateFromString:@"15 Sep 1993"];
    testee.incomeCell.textField.text = @"81000";
    testee.genderCell.gender = @"M";
    
    [testee finishedEditing];
    
    STAssertEqualStrings(@"marvinatyahoodotcom@hotmail.com", gAccount.email, @"email");
    STAssertEqualObjects(@"15 Sep 1993", [DateHelper stringFromDate:gAccount.birthdate], @"birthdate");
    STAssertEquals(81000, gAccount.income, @"income");
    STAssertEqualStrings(@"M", gAccount.gender, @"gender");
}



@end
