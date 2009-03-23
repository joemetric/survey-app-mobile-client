#import "GTMSenTestCase.h"
#import "RestConfiguration.h"

@interface RestConfigurationTest: GTMTestCase
@end


@implementation RestConfigurationTest


-(void)testUsernameAndPasswordReadFromUserDefaults{
	[[NSUserDefaults standardUserDefaults] setObject:@"marvin" forKey:@"username"];
	[[NSUserDefaults standardUserDefaults] setObject:@"monkeyBoy" forKey:@"password"];

	STAssertEqualStrings(@"marvin", [RestConfiguration username], nil);
	STAssertEqualStrings(@"monkeyBoy", [RestConfiguration password], nil);
}


-(void)testReadingAndWritingUsernameAndPassword{
	[RestConfiguration setUsername:@"Rita"];
	[RestConfiguration setPassword:@"My secret"];
	STAssertEqualStrings(@"Rita", [RestConfiguration username], nil);
	STAssertEqualStrings(@"My secret", [RestConfiguration password], nil);
}

-(void)testUrlCredential{
	[RestConfiguration setUsername:@"Sue"];
	[RestConfiguration setPassword:@"Moose"];

	NSURLCredential *urlCredential = [RestConfiguration urlCredential];

	STAssertEqualStrings(@"Sue", urlCredential.user, nil);
	STAssertEqualStrings(@"Moose", urlCredential.password, nil);
}

@end
