#import "GTMSenTestCase.h"
#import "NSDictionary+RemoveNulls.h"

@interface NSDictionary_RemoveNullsTest : GTMTestCase{
}


@end



@implementation NSDictionary_RemoveNullsTest

-(void)testRemovingNSNulls{

    
   NSDictionary* hasNulls = [NSDictionary
                            dictionaryWithObjects:
                            [NSArray arrayWithObjects:@"hello", [NSNull null], @"matey", nil]
                            forKeys:[NSArray arrayWithObjects:@"a", @"nv", @"b", nil]];
    NSDictionary* withoutNulls = [hasNulls withoutNulls];
    
    STAssertEqualStrings(@"hello", [withoutNulls valueForKey:@"a"], nil);
    STAssertEqualStrings(@"matey", [withoutNulls valueForKey:@"b"], nil);
    STAssertNil([withoutNulls valueForKey:@"nv"], nil);
                
}

@end
