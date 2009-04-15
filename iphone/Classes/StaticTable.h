#import <UIKit/UIKit.h>

@class TableSection;

@interface StaticTable : NSObject<UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray* sections;
	UITableView* tableView;
}

+(id)staticTableForTableView:(UITableView*)tableView;
-(void)addSection:(TableSection*)section;
-(void)handleErrors:(NSDictionary*)errors;
-(void)removeAllSections;
-(TableSection*) sectionAtIndex:(NSInteger)index;
-(void)activeSubsequentTextField:(UITextField*)textField;

-(void)beDelegateAndDataSourceForThisTableView:(UITableView*)tableView;

@end
