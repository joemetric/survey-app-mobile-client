
#import "DateHelper.h"


@implementation DateHelper

+(NSDateFormatter*)formatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter.dateFormat = @"dd MMM yyyy";
	return dateFormatter;
}
+(NSString*) dateFromString:(NSString*)str{
	return [[self formatter] dateFromString:str];
}

+(NSString*) stringFromDate:(NSDate*)date{
	return [[self formatter] stringFromDate:date];
}

@end
