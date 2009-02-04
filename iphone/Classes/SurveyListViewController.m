//
//  SurveyListViewController.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "SurveyListViewController.h"
#import "QuestionListViewController.h"
#import "Survey.h"
#import "SurveyList.h"

@implementation SurveyListViewController

@synthesize surveys;

- (void)awakeFromNib {
    self.navigationItem.title = @"Surveys";
    self.surveys = [[SurveyList alloc] init];
    
    // add our custom button to show our modal view controller
    UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton addTarget:self action:@selector(refreshSurveys) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.rightBarButtonItem = modalButton;
    [modalViewButton release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)refreshSurveys {
    [self.surveys refreshSurveyList];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.surveys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Survey *survey = [self.surveys surveyAtIndex:indexPath.row];
    cell.text = [survey nameAndAmountAsString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    QuestionListViewController *questionListViewController = 
		[[QuestionListViewController alloc] initWithNibName:@"QuestionListView" 
													 bundle:nil 
												   survey:[self.surveys surveyAtIndex:indexPath.row]];
    
	[self.navigationController pushViewController:questionListViewController animated:YES];
	NSLog(@"Survey name: %@", questionListViewController.surveyName);
	NSLog(@"Survey id: %@", questionListViewController.surveyId);
    [questionListViewController release];    
}

- (void)dealloc {
    [surveys release];
    [super dealloc];
}


@end

