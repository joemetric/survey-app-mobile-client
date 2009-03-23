#import "GTMSenTestCase.h"
#import "NoAccountDataProfileDataSource.h"

@interface NoAccountDataProfileDataSourceTest : GTMTestCase
    NoAccountDataProfileDataSource* testee;
@end

@implementation NoAccountDataProfileDataSourceTest 

-(void)setUp{
    testee = [[NoAccountDataProfileDataSource alloc] init];
}

-(void)tearDown{
    [testee release];
}

-(void)testOneSectionWithNoRows{
    STAssertEquals(1, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView");
    STAssertEquals(0, [testee tableView:nil numberOfRowsInSection:0], @"numberOfRowsInSection");
}

-(void)testFooterIsMessage{
    testee.message = @"this is the message";
    STAssertEqualStrings(@"this is the message", [testee tableView:nil  titleForFooterInSection:0], nil); 
}
@end
