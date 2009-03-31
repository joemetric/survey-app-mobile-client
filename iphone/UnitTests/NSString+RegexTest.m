#import "GTMSenTestCase.h"
#import "NSString+Regex.h"

@interface NSString_RegexTest : GTMTestCase{

}
@end


@implementation NSString_RegexTest 

-(void) testRaisesNSExceptionIfRegularExpressionIsIllegal{
    @try {
        [@"hello" matchRegex:@"+"];
        STFail(@"Expecting exception due to invalid regex");
    }
    @catch (NSException * e) {
        STAssertEqualStrings(@"Could not compile regex \"+\": repetition-operator operand invalid", [e reason] , @"error reason");
    }
    
}

-(void)testReturnsNilWhenNoMatch{
    STAssertNil([@"hello" matchRegex:@"x"] ,nil);
}

-(void)testReturnsNotNillWhenThereIsAMatch{
    STAssertNotNil([@"hello" matchRegex:@"ll"] ,nil);
}
@end
