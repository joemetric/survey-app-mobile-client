#import <UIKit/UIKit.h>

@class TableSection;

@interface StaticTable : NSObject<UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray* sections;
}

+(id)staticTable;
-(void)addSection:(TableSection*)section;
-(void)handleErrors:(NSDictionary*)errors;
-(void)removeAllSections;
@end
