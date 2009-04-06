#import "TableSection.h"
#import "HasError.h"

@interface TableSection()
@property(nonatomic, retain) NSMutableArray* cells;
@end

@implementation TableSection
@synthesize cells;
@synthesize headerView;
@synthesize footerView;



-(id)initFooter{
   	self.footerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
	return self;
}

-(id)withTitle:(NSString*)title{
   	self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)] autorelease];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 30)]; 
	label.textAlignment = UITextAlignmentLeft;
	label.font = [UIFont systemFontOfSize:22.0];
	label.opaque = NO ;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.text = title;
	[self.headerView addSubview:label];
    [label release];
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
 	self.cells = nil;
    self.headerView = nil;
    [super dealloc];
}

-(void)addCell:(UITableViewCell*)cell{
	[cells addObject:cell];
}

-(UITableViewCell*)cellAtIndex:(NSUInteger)index{
	return [cells objectAtIndex:index];
}


-(NSUInteger)rowCount{
	return cells.count;
}


-(void)setFooterLines:(NSString*)lines{
	for (NSString* footerline in lines){
		UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 30)] autorelease];
		label.text = footerline;
		[self.footerView addSubview: label];
	}
}


-(void)handleErrors:(NSDictionary*)errors{
	for (id cell in cells){
		if ([cell conformsToProtocol:@protocol(HasError)]){
			id<HasError> hasError = (id<HasError>) cell;
			hasError.errorHighlighted = [errors objectForKey:hasError.errorField] != nil;
		}
	}
}


@end
