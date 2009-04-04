#import <UIKit/UIKit.h>


@interface TableSection : NSObject {
	NSMutableArray* cells;
    UIView* headerView;
}

+(id)tableSectionWithTitle:(NSString*)title;
-(void)addCell:(UITableViewCell*)cell;
-(UITableViewCell*)cellAtIndex:(NSUInteger)index;
-(void)handleErrors:(NSDictionary*)errors;

@property(readonly) NSUInteger rowCount;
@property(nonatomic, retain) UIView* headerView;
@end
