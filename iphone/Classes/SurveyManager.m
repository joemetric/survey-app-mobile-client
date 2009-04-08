#import "SurveyManager.h"
#import "RestConfiguration.h"
#import "JSON.h"

@implementation SurveyManager

@synthesize observer;

- (BOOL)loadSurveysFromNetwork {    
    [[RestfulRequests restfulRequestsWithObserver:self] GET:@"/surveys.json"];
    return YES;
}

+ (NSArray *)loadSurveysFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    NSMutableArray *surveys = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id surveyFile in [[NSFileManager defaultManager] directoryContentsAtPath:surveyDirectory]) {        
        [surveys addObject:[NSDictionary dictionaryWithContentsOfFile:[surveyDirectory stringByAppendingPathComponent:surveyFile]]];
    }
    
    return [surveys autorelease];
}



-(void) authenticationFailed {
    
}

-(void) failedWithError:(NSError *)error {
    
}

-(void) finishedLoading:(NSString *)data {
    NSArray *surveys;
    
    surveys = [data JSONFragmentValue];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    
    // Ensure surveys directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:surveyDirectory attributes:nil];
    
    // Write one plist file per survey, surveys/n.plist
    // Can do 'sync' by checking updated_at from the plist
    for (id survey in surveys) {
        NSString *surveyFilePath = [surveyDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", 
                                                                                    [survey objectForKey:@"id"]]];
        [survey writeToFile:surveyFilePath atomically:YES];
    }
        
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
