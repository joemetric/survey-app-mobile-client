#import "RestConfiguration.h"

/*  Should make these build configurable */
#define REST_HOST @"localhost"
#define REST_PORT 3000 

NSString* userDefaultString(NSString *key){
	return [[NSUserDefaults standardUserDefaults] stringForKey:key]; 
}

void setUserDefaultString(NSString *key, NSString* value){
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

@implementation RestConfiguration

+(NSString*) host{     
    return REST_HOST;
}

+(NSInteger) port{
 	return REST_PORT;
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
