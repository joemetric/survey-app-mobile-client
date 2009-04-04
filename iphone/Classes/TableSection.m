#import "TableSection.h"
#import "HasError.h"

@interface TableSection()
@property(nonatomic, retain) NSMutableArray* cells;
@end

@implementation TableSection
@synthesize cells;
@synthesize headerView;


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
	return [[[[self alloc] init] autorelease] withTitle:title];
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

-(void)handleErrors:(NSDictionary*)errors{
	for (id cell in cells){
		if ([cell conformsToProtocol:@protocol(HasError)]){
			id<HasError> hasError = (id<HasError>) cell;
			hasError.errorHighlighted = [errors objectForKey:hasError.errorField] != nil;
		}
	}
}


@end
