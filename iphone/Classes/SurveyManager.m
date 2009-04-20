#import "SurveyManager.h"
#import "Survey.h"
#import "RestConfiguration.h"
#import "JSON.h"

@implementation SurveyManager

@synthesize observer;

+ (NSString *)surveyDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"surveys"]; 
}

- (BOOL)loadSurveysFromNetwork {   
	NSLog(@"loadSurveysFromNetwork");
    [[RestfulRequests restfulRequestsWithObserver:self] GET:@"/surveys.json"];
    return YES;
}

+ (NSArray *)loadSurveysFromLocal {
    NSMutableArray *surveys = [[NSMutableArray alloc] initWithCapacity:0];
    
	NSLog(@"looking for surveys in %@", [SurveyManager surveyDirectory]);
    for (id surveyFile in [[NSFileManager defaultManager] directoryContentsAtPath:[SurveyManager surveyDirectory]]) {
        NSLog(@"found survey %@", surveyFile);
        [surveys addObject:[NSDictionary dictionaryWithContentsOfFile:[[self surveyDirectory] stringByAppendingPathComponent:surveyFile]]];
    }
    
    return [surveys autorelease];
}

+ (void) removeLocalSurvey:(Survey*)survey {
	NSString* path = [survey localFilePath];
	[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}


-(void) authenticationFailed {
    
}

-(void) failedWithError:(NSError *)error {
    
}

- (void)deleteStaleLocalSurveys:(NSArray *)surveys {
    NSMutableArray *localSurveys = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *remoteSurveys = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id surveyFile in [[NSFileManager defaultManager] directoryContentsAtPath:[SurveyManager surveyDirectory]]) {
        [localSurveys addObject:[NSDecimalNumber 
                                 decimalNumberWithString:[[surveyFile componentsSeparatedByString:@"."] objectAtIndex:0]]];
    }

    for (id survey in surveys) {
        [remoteSurveys addObject:[survey objectForKey:@"id"]];
    }
    
    for (id local in localSurveys) {
        if (![remoteSurveys containsObject:local]) {
            NSString *surveyPath = [[SurveyManager surveyDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", local]];
            [[NSFileManager defaultManager] removeFileAtPath:surveyPath handler:nil];
        }
    }
    
    [remoteSurveys release];
    [localSurveys release];
}

-(void) finishedLoading:(NSString *)data {
	NSLog(@"finishedLoading");
    NSArray *surveys;
    
    surveys = [data JSONFragmentValue];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[SurveyManager surveyDirectory] attributes:nil];
    
    [self deleteStaleLocalSurveys:surveys];
    for (id survey in surveys) {
        NSString *surveyFilePath = [[SurveyManager surveyDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", 
                                                                                    [survey objectForKey:@"id"]]];
		NSLog(@"writing survey to file %@\n", surveyFilePath);
        NSLog(@"written: %d", [survey writeToFile:surveyFilePath atomically:YES]);
//		[[NSDictionary dictionary] writeToFile:surveyFilePath atomically:YES];
		NSLog(@"Exists? : %d", [[NSFileManager defaultManager] fileExistsAtPath:surveyFilePath]);
    }
        
	NSLog(@"callig observer");
    [observer surveysStored];    
}


- (id)init {
    return [self initWithObserver:nil];
}

- (id)initWithObserver:(NSObject<SurveyManagerObserver> *)delegate {
    if (self = [super init]) {
        self.observer = delegate;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end
