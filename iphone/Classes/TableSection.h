#import <UIKit/UIKit.h>


@interface TableSection : NSObject {
	NSMutableArray* cells;
    UIView* headerView;
	UIView* footerView;
}

+(id)tableSectionWithTitle:(NSString*)title;
-(void)addCell:(UITableViewCell*)cell;
-(UITableViewCell*)cellAtIndex:(NSUInteger)index;
-(void)handleErrors:(NSDictionary*)errors;
-(void)setFooterLines:(NSString*)lines;

@property(readonly) NSUInteger rowCount;
@property(nonatomic, retain) UIView* headerView;
@property(nonatomic, retain) UIView* footerView;

@end
