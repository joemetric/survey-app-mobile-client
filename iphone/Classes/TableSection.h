#import <UIKit/UIKit.h>


@interface TableSection : NSObject<UITextFieldDelegate> {
	NSMutableArray* cells;
    UIView* headerView;
	UIView* footerView;
	UITableView* tableView;
	NSInteger section;
}

+(id)tableSectionWithTitle:(NSString*)title;
-(void)addCell:(UITableViewCell*)cell;
-(UITableViewCell*)cellAtIndex:(NSUInteger)index;
-(void)handleErrors:(NSDictionary*)errors;
-(void)setFooterLines:(NSArray*)lines;
-(void)setFooterLine:(NSString*)line;


@property(readonly) NSInteger rowCount;
@property(readonly) NSInteger footerHeight;
@property(nonatomic, retain) UIView* headerView;
@property(nonatomic, retain) UIView* footerView;
@property(nonatomic, retain) UITableView* tableView;
@property(nonatomic, assign) NSInteger section;

@end
