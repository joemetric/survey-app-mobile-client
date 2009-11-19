//
//  WalletController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "WalletController.h"
#import "TransferRestRequest.h"
#import "PaymentCell.h"
#import "Metadata.h"
#import "User.h"
#import "SurveyAppDelegate.h"


@implementation WalletController
@synthesize paymentHeaderCell, paymentTable, instructionLabel;
@synthesize pendingPayments, needRefresh;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void) awakeFromNib {
	UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.tiff"]];
	[iv setFrame:CGRectMake(0, 0, 27, 44)];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:iv];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButton release];
	[iv release];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[aiv setFrame:CGRectMake(0, 0, 22, 22)];
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:aiv];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
	[aiv release];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
	backButton.title = @"Back";
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	instructionLabel.hidden = TRUE;
	needRefresh = TRUE;
}

- (void)viewWillAppear:(BOOL)animated {
	if (needRefresh) {
		[self.pendingPayments removeAllObjects];
		[paymentTable reloadData];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	if (needRefresh) {
		[self performSelectorInBackground:@selector(getTransfers) withObject:nil];
		self.needRefresh = FALSE;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.paymentTable = nil;
	self.paymentHeaderCell = nil;
	self.instructionLabel = nil;
}


- (void)dealloc {
	[paymentTable release];
	[paymentHeaderCell release];
	[instructionLabel release];
	[pendingPayments release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark PaymentTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([pendingPayments count] == 0) {
		paymentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
		return 0;
	} else {
		paymentTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		paymentTable.separatorColor = [UIColor grayColor];
		return 1 + [pendingPayments count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0)
		return paymentHeaderCell;

	static NSString *CellIdentifier = @"PaymentCell";
	PaymentCell *cell = (PaymentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PaymentCellView" owner:self options:nil];
		cell = [nib objectAtIndex:0];
    }
	
	Transfer *transfer = [pendingPayments objectAtIndex:indexPath.row-1];
	[cell updateTransfer:transfer];
	return cell;	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0)
		return 32.0;
	else
		return 36.0;
}

- (void)getTransfers {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView startAnimating];

	User *user = [[Metadata getMetadata] user];
	NSError *error;
	self.pendingPayments = [RestRequest getPendingTransfers:user Error:&error];
	[self performSelectorOnMainThread:@selector(transferLoaded) withObject:nil waitUntilDone:YES];
	
	[(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView stopAnimating];
	[pool release];
}

- (void)transferLoaded {
	if ([pendingPayments count] == 0) {
		instructionLabel.hidden = FALSE;
	} else {
		instructionLabel.hidden = TRUE;
	}
	[paymentTable reloadData];
}

@end
