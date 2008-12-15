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

-(void)animateTheTransition:(UIViewController *)controller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
    
    [UIView commitAnimations];
}

-(IBAction)answerQuestion:(id)sender {   
    NSLog(@"Answering the question");
    SurveyQuestionViewController *sqvc = [[SurveyQuestionViewController alloc] 
                                          initWithNibName:@"SurveyQuestionView" 
                                                   bundle:nil 
                                                 question:self.selectedQuestion];
    [self.navigationController pushViewController:sqvc animated:YES];    
    [self animateTheTransition:sqvc];
 
    [sqvc release];
}


@end
