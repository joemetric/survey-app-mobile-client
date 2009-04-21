#import "GTMSenTestCase.h"
#import "NoAccountDataProfileDataSource.h"

@interface NoAccountDataProfileDataSourceTest : GTMTestCase{
	StaticTable* testee;
	UITableView* tableView;
}
@property(nonatomic, retain)  StaticTable* testee;
@end

@implementation NoAccountDataProfileDataSourceTest 
@synthesize testee;


-(void)tearDown{
	self.testee = nil;
}

-(void)testOneSectionWithOneRowForSingleLineMessage{
	self.testee = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessages:[NSArray arrayWithObject:@"this is the message"] andTableView:tableView];
	STAssertEquals(1, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView");
	STAssertEquals(1, [testee tableView:nil numberOfRowsInSection:0], @"numberOfRowsInSection");
}

-(NSString*)messageTextAtRow:(NSInteger)row{
	return [testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]].text;
}

-(void)testMessageIsInCell{
	self.testee = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessages:[NSArray arrayWithObject:@"hello"] andTableView:tableView];
	UITableViewCell *cell = [testee tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	STAssertEqualStrings(@"hello", [self messageTextAtRow:0] ,nil);
}

-(void)testOneCellForMessage{
	self.testee = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessages:[NSArray arrayWithObjects:@"hello", @"matey", nil] andTableView:tableView];
	STAssertEquals(2, [testee tableView:nil numberOfRowsInSection:0], @"numberOfRowsInSection");
	STAssertEqualStrings(@"hello", [self messageTextAtRow:0] ,nil);
	STAssertEqualStrings(@"matey", [self messageTextAtRow:1] ,nil);

}

@end
