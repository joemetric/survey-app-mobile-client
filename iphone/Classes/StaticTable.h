#import <UIKit/UIKit.h>

@class TableSection;

@interface StaticTable : NSObject<UITableViewDataSource> {
	NSMutableArray* sections;

}

+(id)staticTable;
-(void)addSection:(TableSection*)section;
@end
