//
//  WalletViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewTableCell.h"


@implementation WalletViewController

@synthesize entries;
@synthesize totalTitle, totalValue;

- (void) viewWillAppear:(BOOL)animated {
	totalTitle.text = @"Total";
	totalValue.text = @"$55.00";
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WalletViewTableCell *cell = (WalletViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"WalletViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"WalletViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell
	if (indexPath.row == 3){
		cell.surveyName.text  = @"Withdrawal";
		cell.surveyName.textColor = [UIColor redColor];
		cell.surveyValue.text = @"$-25.00";
		cell.surveyValue.textColor = [UIColor redColor];
	}
	else {
		cell.surveyName.text = [NSString stringWithFormat:@"Survey %d", indexPath.row+1];
		cell.surveyValue.text = [NSString stringWithFormat:@"$%d.00", 5*(indexPath.row+1)];
	}
    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end

