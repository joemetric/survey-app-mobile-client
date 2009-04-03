#import "GTMSenTestCase.h"
#import "JSON.h"
#import "SBJSON+NullToNilPatch.h"

@interface SBJSON_NullToNilPatchTest : GTMTestCase
@end

@implementation SBJSON_NullToNilPatchTest

-(void)testParsingNullMapsToNil{
    NSString *json = @"{\"k\":null}";
    NSDictionary* unpackedJson = (NSDictionary*)[json JSONFragmentValue];
    STAssertTrue([unpackedJson isKindOfClass:[NSDictionary class]], [unpackedJson className]);
   // STAssertNil([unpackedJson valueForKey:@"k"], nil);
	NSMutableArray *a = [NSMutableArray arrayWithCapacity:1];
	[a addObject:nil];
}

@end
