//
//  SurveyInfoViewController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey;

@interface SurveyInfoViewController : UIViewController {
    UILabel *surveyName;
    UILabel *surveyAmount;
    Survey *survey;
}

- (IBAction)takeSurvey:(id) sender;

@property (nonatomic, assign) IBOutlet UILabel *surveyName;
@property (nonatomic, assign) IBOutlet UILabel *surveyAmount;
@property (nonatomic, assign) Survey *survey;

@end
