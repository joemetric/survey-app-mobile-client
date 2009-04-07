
#import "NoAccountDataProfileDataSource.h"
#import "TableSection.h"

@implementation NoAccountDataProfileDataSource

+(id)noAccountDataProfileDataSourceWithMessage:(NSString*)message{
	StaticTable* result =  [StaticTable staticTable];
	TableSection* tableSection = [TableSection tableSectionWithTitle:@"Account"];
	[result addSection:tableSection];
	[tableSection setFooterLines:[NSArray arrayWithObject:message]];
	return result;
}





@end
