#import "GTMSenTestCase.h"
#import "RestConfiguration.h"

@interface RestConfigurationTest: GTMTestCase
@end


@implementation RestConfigurationTest

-(void)tearDown{
	[[NSUserDefaults standardUserDefaults] setObject:@"3000" forKey:@"port"];
	[[NSUserDefaults standardUserDefaults] setObject:@"localhost" forKey:@"host"];
	
}

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

-(void)testHostAndPortReadFromUserDefaults{
	[[NSUserDefaults standardUserDefaults] setObject:@"2301" forKey:@"port"];
	[[NSUserDefaults standardUserDefaults] setObject:@"ahost" forKey:@"host"];

    STAssertEquals(2301, [RestConfiguration port], nil);
    STAssertEqualStrings(@"ahost", [RestConfiguration host], nil);
}

@end
