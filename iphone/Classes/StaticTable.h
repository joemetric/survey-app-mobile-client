#import <UIKit/UIKit.h>

@class TableSection;

@interface StaticTable : NSObject<UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray* sections;
}

+(id)staticTableForTableView:(UITableView*)tableView;
-(void)addSection:(TableSection*)section;
-(void)handleErrors:(NSDictionary*)errors;
-(void)removeAllSections;
-(TableSection*) sectionAtIndex:(NSInteger)index;

@end
