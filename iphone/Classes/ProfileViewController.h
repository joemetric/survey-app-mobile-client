#import <UIKit/UIKit.h>
#import "Account.h"


@class CredentialsViewController;
@class NewAccountViewController;
@class NoCredentialsProfileDataSource;
@class ValidCredentialsProfileDataSource;
@class NoAccountDataProfileDataSource;
@class Account;

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AccountObserver> {
	UITableView* tableView;
	CredentialsViewController* credentialsController;
	NewAccountViewController* newAccountController;
	NoCredentialsProfileDataSource* noCredentials;
	ValidCredentialsProfileDataSource* validCredentials;
	NoAccountDataProfileDataSource* noAccountData;
    UIView* accountSectionHeader;
    UIView* demographicsSectionHeader;
}

- (void) displayModalCredentialsController;
- (void) displayModalNewAccountController;

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) CredentialsViewController* credentialsController;
@property (nonatomic, retain) NewAccountViewController* newAccountController;
@property (nonatomic, retain) NoCredentialsProfileDataSource* noCredentials;
@property (nonatomic, retain) ValidCredentialsProfileDataSource* validCredentials;
@property (nonatomic, retain) NoAccountDataProfileDataSource* noAccountData;
@property (nonatomic, retain) IBOutlet UIView* accountSectionHeader;
@property (nonatomic, retain) IBOutlet UIView* demographicsSectionHeader;

@end
