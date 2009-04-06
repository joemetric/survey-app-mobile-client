#import <Foundation/Foundation.h>

@protocol SurveyManagerObserver
- (void)surveysStored;
@end

@interface SurveyManager : NSObject {
    NSString      *host;
    NSInteger      port;
    NSMutableData *buffer;
    NSMutableURLRequest *request;
    NSURLConnection *conn;
    NSObject<SurveyManagerObserver>* observer;
}

- (id)initWithObserver:(NSObject<SurveyManagerObserver> *)delegate;

- (BOOL)loadSurveysFromNetwork;
+ (NSArray *)loadSurveysFromLocal;

@property (nonatomic, assign) NSObject<SurveyManagerObserver>* observer;

@end
