//
//  WalletViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewTableCell.h"
#import "Account.h"

@interface WalletViewController (Private)
- (void) updateWallet;
- (NSString*) balanceString:(NSNumber*)balance;
@end

@implementation WalletViewController

@synthesize entries;
@synthesize totalTitle, totalValue;

- (void) viewDidLoad {
	[[Account currentAccount] onChangeNotifyObserver:self];
	[self updateWallet];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void) updateWallet {
	if( [Account currentAccount] != nil ) {
		totalValue.text = [self balanceString:[[Account currentAccount] walletBalance]];
		[entries reloadData];		
	} else {
		totalValue.text = @"unknown";
	}
}

- (NSString*) balanceString:(NSNumber*)balance {
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	NSString* balanceString = [numberFormatter stringFromNumber:balance];
	[numberFormatter release];
	return balanceString;
	
}

-(void) changeInAccount:(Account*)account{	
	[self updateWallet];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if( [Account currentAccount] != nil ) {
		return [Account currentAccount].walletTransactionCount;
	} else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletViewTableCell *cell = (WalletViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"WalletViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"WalletViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
	NSDictionary* wallet_transaction = [[[Account currentAccount].wallet objectForKey:@"wallet_transactions"] objectAtIndex:indexPath.row];
    // Configure the cell
	cell.surveyName.text  = [wallet_transaction objectForKey:@"description"];
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	cell.surveyValue.text = [numberFormatter stringFromNumber:[wallet_transaction objectForKey:@"amount"]];
	[numberFormatter release];
	if( [[wallet_transaction objectForKey:@"description"] isEqualToString:@"Withdrawal"] )
	  [cell setupAsDebit];
	else
		[cell setupAsCredit];

	if( indexPath.row % 2 == 1 ) {
		cell.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	} else {
		cell.contentView.backgroundColor = [UIColor whiteColor];
	}
    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end

