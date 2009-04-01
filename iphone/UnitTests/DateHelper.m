
#import "DateHelper.h"


@implementation DateHelper

+(NSDateFormatter*)formatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter.dateFormat = @"dd MMM yyyy";
	return dateFormatter;
}
+(NSString*) dateFromString:(NSString*)str{
	return @"hello";
}

+(NSString*) stringFromDate:(NSDate*)date{
	return [[self formatter] stringFromDate:date];
}

@end
