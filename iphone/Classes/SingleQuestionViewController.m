//
//  SingleQuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "SingleQuestionViewController.h"
#import "SurveyQuestionViewController.h"


@implementation SingleQuestionViewController

-(IBAction)answerQuestion:(id)sender {
    NSLog(@"Answering the question");
    SurveyQuestionViewController *sqvc = [[SurveyQuestionViewController alloc] 
                                          initWithNibName:@"SurveyQuestionView" 
                                                   bundle:nil 
                                                 question:self.selectedQuestion];
    [self.navigationController pushViewController:sqvc animated:YES];    
    [sqvc release];
}

@end
