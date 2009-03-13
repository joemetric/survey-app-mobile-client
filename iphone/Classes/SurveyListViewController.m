//
//  SurveyListViewController.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "SurveyListViewController.h"
#import "SurveyInfoViewController.h"
#import "Survey.h"
#import "ResourceDelegate.h"

@interface SurveyListViewController (Private)
- (void)refreshSurveys;
@end

@implementation SurveyListViewController

@synthesize surveys;

- (void)awakeFromNib {
    // add our custom button to show our modal view controller
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                          pathForResource:@"refresh_icon"
                                                          ofType:@"png"]];

    UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton setImage:image forState:UIControlStateNormal];

    [modalViewButton addTarget:self action:@selector(refreshSurveys) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.rightBarButtonItem = modalButton;
    [modalViewButton release];
}

-(void)refreshSurveys {
    [Survey findAllWithDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshSurveys];
}

-(void)resource:(Resource*)res itemsReceived:(NSArray *)items {
    self.surveys = items;
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
    
    Survey *survey = [self.surveys objectAtIndex:indexPath.row];
    cell.text = [survey nameAndAmountAsString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SurveyInfoViewController *sivc = [[SurveyInfoViewController alloc] initWithNibName:@"SurveyInfoView"
                                                                       bundle:nil
                                                                       survey:[self.surveys objectAtIndex:indexPath.row]];

    [self.navigationController pushViewController:sivc animated:YES];
    [sivc release];
}

- (void)dealloc {
    [surveys release];
    [super dealloc];
}


@end

