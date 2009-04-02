#import "Regex.h"
#import "NSString+Regex.h"


@implementation RegexMatch

@end


@implementation NSString(Regex)

-(RegexMatch*) matchRegex:(NSString*)regex{
	regex_t preg;
	int err=regcomp(&preg,[regex UTF8String],REG_EXTENDED);
	if(err){
	    char errbuf[256];
	    regerror(err,&preg,errbuf,sizeof(errbuf));
	    [NSException raise:@"CSRegexException" format:@"Could not compile regex \"%@\": %s",regex,errbuf];
	}
    
	regmatch_t match;
    NSInteger res = regexec(&preg,[self UTF8String],1,&match,0);
    regfree(&preg);
	if(res == 0)
	{
	    return [[[RegexMatch alloc] init] autorelease];
	}
   return nil;
}
@end
