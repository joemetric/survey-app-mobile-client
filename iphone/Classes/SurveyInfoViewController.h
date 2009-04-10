//
//  SurveyInfoViewController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey;

@interface SurveyInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UILabel *surveyName;
    UILabel *surveyAmount;
	UITextView *surveyDescription;
	UITableView *questionList;
    Survey *survey;
}

@property (nonatomic, assign) IBOutlet UILabel *surveyName;
@property (nonatomic, assign) IBOutlet UILabel *surveyAmount;

@property (nonatomic, assign) IBOutlet	UITextView *surveyDescription;
@property (nonatomic, assign) IBOutlet UITableView *questionList;
@property (nonatomic, assign) Survey *survey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)aSurvey;

@end
