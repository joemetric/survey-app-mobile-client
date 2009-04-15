#import "GTMSenTestCase.h"
#import "NoAccountDataProfileDataSource.h"

@interface NoAccountDataProfileDataSourceTest : GTMTestCase{
    StaticTable* testee;
	UITableView* tableView;
}
@property(nonatomic, retain)  StaticTable* testee;
@property(nonatomic, retain)  UITableView* tableView;
@end

@implementation NoAccountDataProfileDataSourceTest 
@synthesize testee, tableView;

-(void)setUp{
	self.tableView = 
    self.testee = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"this is the message" andTableView:tableView];
}

-(void)tearDown{
	self.testee = nil;
    self.tableView = nil;
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
