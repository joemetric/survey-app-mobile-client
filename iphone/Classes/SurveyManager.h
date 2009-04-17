#import <Foundation/Foundation.h>
#import "RestfulRequests.h"

@class Survey;
@protocol SurveyManagerObserver
- (void)surveysStored;
@end

@interface SurveyManager : NSObject <RestfulRequestsObserver> {
    NSObject<SurveyManagerObserver>* observer;
}

- (id)initWithObserver:(NSObject<SurveyManagerObserver> *)delegate;

- (BOOL)loadSurveysFromNetwork;
+ (NSArray *)loadSurveysFromLocal;
+ (void) removeLocalSurvey:(Survey*)survey;
+ (NSString*)surveyDirectory;
@property (nonatomic, assign) NSObject<SurveyManagerObserver>* observer;

@end
