#import "EditProfileDataSource.h"
#import "TableSection.h"
#import "NSObject+CleanUpProperties.h"
#import "LabelledTableViewCell.h"
#import "MaleFemaleTableViewCell.h"
#import "Account.h"
#import "TableSection+AccountFields.h"

@implementation EditProfileDataSource
@synthesize emailCell, incomeCell, dobCell, genderCell, parent, loginCell;



-(void)addAccountSection{
    TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
    [self addSection:section];
    loginCell = [section addLoginCell];
    loginCell.textField.enabled = false;
}

-(void)addDemographicsSection{
    TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
    [self addSection:section];
    self.emailCell = [section addEmailCell];
    self.incomeCell = [section addIncomeCell];
    self.dobCell = [section addDobCellWithParent:parent];
    self.genderCell = [section addGenderCell];
}

-(void)setCellValues{
	Account* account = [Account currentAccount];
    loginCell.textField.text = account.username;
    emailCell.textField.text = account.email;
    incomeCell.textField.text = [NSString stringWithFormat:@"%d", account.income];
    dobCell.date = account.birthdate;
	genderCell.gender = account.gender;
}

-(void)updateAccount{
	Account* account = [Account currentAccount];
	account.email = emailCell.textField.text;
	account.birthdate = dobCell.date;
	account.income = incomeCell.integer;
	account.gender = genderCell.gender;
	
	[account onChangeNotifyObserver:self];
	[account update];
}
-(void)finishedEditing{
	[self updateAccount];
	[self resignFirstResponder];
	
}


-(void)populate{
    [self addAccountSection];
    [self addDemographicsSection];
	[self setCellValues];
}


+(id)editProfileDataSourceWithParentViewController:(UIViewController*)parent andTableView:(UITableView*)tableView{
    EditProfileDataSource* result = [self staticTableForTableView:tableView];
    result.parent = parent;
    [result populate];
    return result;
}

-(void)changeInAccount:(Account*)account{
	[account noLongerNotifyObserver:self];
	if (accountLoadStatusLoadFailed == account.accountLoadStatus){
		UIAlertView *errorAlert = [[UIAlertView alloc] 
			initWithTitle: [account.lastLoadError localizedDescription] 
			message: [account.lastLoadError localizedFailureReason] 
			delegate:nil 
			cancelButtonTitle:@"OK" 
			otherButtonTitles:nil];
		[errorAlert show];
		[errorAlert release];
	}
	[self handleErrors:[account errors]];
}

-(void) dealloc{
    [self setEveryObjCObjectPropertyToNil];
    [super dealloc];
}


@end
