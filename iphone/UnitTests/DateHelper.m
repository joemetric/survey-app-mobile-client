#import "GTMSenTestCase.h"

#import "DateHelper.h"


@implementation DateHelper

+(NSDateFormatter*)formatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter.dateFormat = @"dd MMM yyyy";
	return dateFormatter;
}
+(NSDate*) dateFromString:(NSString*)str{
	return [[self formatter] dateFromString:str];
}

+(NSString*) stringFromDate:(NSDate*)date{
	return [[self formatter] stringFromDate:date];
}

+(NSDateFormatter*)localFormatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	return dateFormatter;
}

+(NSString*)localDateFormatFromDateString:(NSString*)dateString{
	NSDate *date = [self dateFromString:dateString];
	NSString* res =  [[self localFormatter] stringFromDate:date];
	return res;
}


@end
