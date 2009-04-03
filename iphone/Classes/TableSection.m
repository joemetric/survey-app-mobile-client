#import "TableSection.h"


@interface TableSection()
@property(nonatomic, retain) NSMutableArray* cells;
@end

@implementation TableSection
@synthesize cells;

+(id)tableSection{
	return [[[self alloc] init] autorelease];
}

-(id)init{
	[super init];
	self.cells = [NSMutableArray array];
	return self;
}

-(void) dealloc{
	self.cells = nil;
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

@end
