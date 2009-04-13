#import "TableSection.h"
#import "Editable.h"

@interface TableSection()
@property(nonatomic, retain) NSMutableArray* cells;
@end

@implementation TableSection
@synthesize cells, headerView, footerView, tableView, section, staticTable;



-(id)initFooter{
   	self.footerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
	return self;
}


-(UILabel*) createHeaderOrFooterLabelWithFrame:(CGRect)frame font:(UIFont*)font text:(NSString*)text{
    UILabel* label = [[[UILabel alloc] initWithFrame:frame] autorelease]; 
	label.textAlignment = UITextAlignmentLeft;
	label.font = font;
	label.opaque = NO ;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.text = text;
	return label;
}
-(id)withTitle:(NSString*)title{
   	self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)] autorelease];
  	[headerView addSubview:[self createHeaderOrFooterLabelWithFrame:CGRectMake(20, 0, 280, 30)
		font:[UIFont systemFontOfSize:22.0] text:title]];
    return self;
}

+(id)tableSectionWithTitle:(NSString*)title{
	return [[[[[self alloc] init] initFooter] withTitle:title] autorelease];
}

-(id)init{
	[super init];
	self.cells = [NSMutableArray array];
	return self;
}

-(void) dealloc{
    [self.cells removeAllObjects];
	[self setEveryObjCObjectPropertyToNil];
    [super dealloc];
}

-(void)addCell:(UITableViewCell*)cell{
	[cells addObject:cell];
	if ([cell isEditableWithTextField]){
		[[(id<Editable>)cell textField] setDelegate:self];
	}
}

-(UITableViewCell*)cellAtIndex:(NSUInteger)index{
	return [cells objectAtIndex:index];
}



-(NSInteger)rowCount{
	return cells.count;
}

-(NSInteger)footerHeight{
	return footerView.subviews.count * 30;
}

-(void)setFooterLines:(NSArray*)lines{
	for(UIView* subview in  footerView.subviews) [subview removeFromSuperview];
    footerView.backgroundColor = [UIColor clearColor];
    int lineIx = 0;
	for (NSString* footerline in lines){
		UILabel* label = [self createHeaderOrFooterLabelWithFrame:CGRectMake(20, lineIx++ * 30, 280, 25)
			font:[UIFont systemFontOfSize:16.0] text:footerline];
		label.adjustsFontSizeToFitWidth = YES;
		[self.footerView addSubview: label];
	}
	footerView.frame = CGRectMake(0, 0, 280, self.footerHeight);
}

-(void)setFooterLine:(NSString*)line{
	[self setFooterLines:[NSArray arrayWithObject:line]];
}


-(void)handleErrors:(NSDictionary*)errors{
	NSMutableArray* errorLines = [NSMutableArray arrayWithCapacity:errors.count];
	for (id cell in cells){
		if ([cell conformsToProtocol:@protocol(Editable)]){
			id<Editable> editable = (id<Editable>) cell;
			NSArray* errorsForCell = [errors objectForKey:editable.errorField];
			editable.errorHighlighted =  errorsForCell != nil;
			if (editable.errorHighlighted) {
					for (NSString* error in  errorsForCell){
						[errorLines addObject:[NSString stringWithFormat:@"%@ %@", editable.errorField, error]];
					}
			}
		}
	}
	[self setFooterLines:errorLines];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
	int i = 0;
	for (UITableViewCell* cell in cells){
		if ([cell isMyEditableTextField:textField]){
			[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section] atScrollPosition:UITableViewScrollPositionNone animated:YES];
			break;
		}
		
		i++;
	}
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
	[staticTable activeSubsequentTextField:textField];
	return YES;
}


@end
