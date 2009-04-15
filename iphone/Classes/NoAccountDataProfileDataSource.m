
#import "NoAccountDataProfileDataSource.h"
#import "TableSection.h"

@implementation NoAccountDataProfileDataSource

+(id)noAccountDataProfileDataSourceWithMessage:(NSString*)message andTableView:(UITableView*)tableView{
	NoAccountDataProfileDataSource* result =  [self staticTableForTableView:tableView];
	TableSection* tableSection = [TableSection tableSectionWithTitle:@"Account"];
	[result addSection:tableSection];
	[tableSection setFooterLines:[NSArray arrayWithObject:message]];
	return result;
}





@end
