//
//  QuestionsViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionListViewController.h"
#import "QuestionViewController.h"
#import "Question.h"
#import "Survey.h"

@implementation QuestionListViewController

@synthesize survey;
@synthesize surveyName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil survey:(Survey *)aSurvey {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.survey = aSurvey;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.survey.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Question *q = [self.survey.questions objectAtIndex:indexPath.row];
    cell.text = [q questionAndAmountAsString];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    QuestionViewController *qvc = 
//        [[QuestionViewController alloc] initWithNibName:@"QuestionView" 
//                                        bundle:nil
//                                        question:[self.survey.questions objectAtIndex:indexPath.row]];
//    qvc.questionList = self;
//    [self.navigationController pushViewController:qvc animated:YES];  
//    [qvc release];    
}


- (void)dealloc {
    [survey release];
    [surveyName release];
    [super dealloc];
}


@end

