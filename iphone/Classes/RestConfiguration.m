#import "RestConfiguration.h"


NSString* userDefaultString(NSString *key){
	return [[NSUserDefaults standardUserDefaults] stringForKey:key]; 
}

void setUserDefaultString(NSString *key, NSString* value){
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

@implementation RestConfiguration

+(NSString*) host{     
	return userDefaultString(@"host");
}

+(NSInteger) port{
 	return [[NSUserDefaults standardUserDefaults] integerForKey:@"port"];
}


+(NSString*) username{
	return userDefaultString(@"username");
}

+(NSString*) password{
	return userDefaultString(@"password");
}

+(void) setUsername:(NSString*)username{
	setUserDefaultString(@"username", username);
}

+(void) setPassword:(NSString*)password{
	setUserDefaultString(@"password", password);
}

+(NSURLCredential*) urlCredential{
	return [NSURLCredential credentialWithUser:[self username] password:[self password]
	 	persistence:NSURLCredentialPersistenceNone];
}


@end
