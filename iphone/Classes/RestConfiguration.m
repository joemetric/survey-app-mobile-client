#import "RestConfiguration.h"


NSString* userDefaultString(NSString *key, NSString* defaultValue){
	NSString* value =  [[NSUserDefaults standardUserDefaults] stringForKey:key]; 
	return nil == value ? defaultValue : value;
}

void setUserDefaultString(NSString *key, NSString* value){
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

@implementation RestConfiguration

+(NSString*) host{     
	NSString* result =  userDefaultString(@"host", @"localhost");
    NSLog(@"host: %@", result);
    return result;
}

+(NSInteger) port{
	NSString* strResult = userDefaultString(@"port", @"3000");
    return [strResult integerValue];
}


+(NSString*) username{
	return userDefaultString(@"username", @"");
}

+(NSString*) password{
	return userDefaultString(@"password", @"");
}

+(void) setUsername:(NSString*)username{
	setUserDefaultString(@"username", username);
}

+(void) setPassword:(NSString*)password{
	setUserDefaultString(@"password", password);
}

+(NSURLCredential*) urlCredential{
	NSLog(@"requesting a urlcredential");
	return [[NSURLCredential credentialWithUser:[self username] password:[self password]
	 	persistence:NSURLCredentialPersistenceNone] autorelease];
}


@end
