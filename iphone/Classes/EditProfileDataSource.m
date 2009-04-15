#import "EditProfileDataSource.h"
#import "TableSection.h"
#import "NSObject+CleanUpProperties.h"

@implementation EditProfileDataSource
@synthesize emailCell, incomeCell, dobCell, genderCell;

-(id)init{
    [super init];
    [self addSection:[TableSection tableSectionWithTitle:@"Editing"]];
    return self;
}


-(void) dealloc{
    [self setEveryObjCObjectPropertyToNil];
    [super dealloc];
}


@end
