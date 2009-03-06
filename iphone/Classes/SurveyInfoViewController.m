//
//  SurveyInfoViewController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "SurveyInfoViewController.h"
#import "QuestionListViewController.h"
#import "Survey.h"

@implementation SurveyInfoViewController

@synthesize surveyName;
@synthesize surveyAmount;
@synthesize survey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)aSurvey {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.survey = aSurvey;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.surveyName.text = self.survey.name;
    self.surveyAmount.text = [self.survey amountAsDollarString];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (IBAction)takeSurvey:(id) sender {
    QuestionListViewController *questionListViewController = 
        [[QuestionListViewController alloc] initWithNibName:@"QuestionListView" 
                                            bundle:nil];
    
    questionListViewController.survey = self.survey;
    [questionListViewController refreshQuestions];
    
    [self.navigationController pushViewController:questionListViewController animated:YES];
    
    [questionListViewController release];
}

- (void)dealloc {
    [super dealloc];
}


@end
