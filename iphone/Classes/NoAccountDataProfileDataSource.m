
#import "NoAccountDataProfileDataSource.h"
#import "TableSection.h"

@implementation NoAccountDataProfileDataSource




+(id)noAccountDataProfileDataSourceWithMessages:(NSArray*)messages andTableView:(UITableView*)tableView{
	NoAccountDataProfileDataSource* result =  [self staticTableForTableView:tableView];
	TableSection* tableSection = [TableSection tableSectionWithTitle:@"Account"];
	for (NSString* message in messages){
		UITableViewCell* cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
			reuseIdentifier:@"TextAndImage"] autorelease];
		cell.text = message;
		[tableSection addCell:cell];
	}

	[result addSection:tableSection];
	return result;
}





@end
