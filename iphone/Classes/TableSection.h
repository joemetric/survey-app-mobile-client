#import <UIKit/UIKit.h>


@interface TableSection : NSObject {
	NSMutableArray* cells;

}

+(id)tableSection;
-(void)addCell:(UITableViewCell*)cell;
-(UITableViewCell*)cellAtIndex:(NSUInteger)index;

@property(readonly) NSUInteger rowCount;
@end
