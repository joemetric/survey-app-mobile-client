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
-(void)setFooterLines:(NSArray*)lines;

@property(readonly) NSInteger rowCount;
@property(readonly) NSInteger footerHeight;
@property(nonatomic, retain) UIView* headerView;
@property(nonatomic, retain) UIView* footerView;

@end
