#import "GTMSenTestCase.h"
#import "NoAccountDataProfileDataSource.h"

@interface NoAccountDataProfileDataSourceTest : GTMTestCase{
    StaticTable* testee;
}
@property(nonatomic, retain)  StaticTable* testee;
@end

@implementation NoAccountDataProfileDataSourceTest 
@synthesize testee;

-(void)setUp{
    self.testee = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"this is the message"];
}

-(void)tearDown{
	self.testee = nil;
}

-(void)testOneSectionWithNoRows{
    STAssertEquals(1, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView");
    STAssertEquals(0, [testee tableView:nil numberOfRowsInSection:0], @"numberOfRowsInSection");
}

-(void)testFooterIsMessage{
	UIView* footerView =  [testee tableView:nil  viewForFooterInSection:0];
	STAssertEquals((NSUInteger)1, footerView.subviews.count, nil);
	STAssertEqualStrings(@"this is the message", [[footerView.subviews objectAtIndex:0] text], nil);
}
@end
