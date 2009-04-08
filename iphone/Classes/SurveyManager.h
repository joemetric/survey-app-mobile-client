#import <Foundation/Foundation.h>
#import "RestfulRequests.h"

@protocol SurveyManagerObserver
- (void)surveysStored;
@end

@interface SurveyManager : NSObject <RestfulRequestsObserver> {
    NSObject<SurveyManagerObserver>* observer;
}

- (id)initWithObserver:(NSObject<SurveyManagerObserver> *)delegate;

- (BOOL)loadSurveysFromNetwork;
+ (NSArray *)loadSurveysFromLocal;

@property (nonatomic, assign) NSObject<SurveyManagerObserver>* observer;

@end
