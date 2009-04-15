#import <UIKit/UIKit.h>
#import "Account.h"


@class CredentialsViewController;
@class NewAccountViewController;
@class NoCredentialsProfileDataSource;
@class ValidCredentialsProfileDataSource;
@class NoAccountDataProfileDataSource;
@class EditProfileDataSource;
@class Account;


@interface ProfileViewController : UIViewController <AccountObserver> {
	UITableView* tableView;
	CredentialsViewController* credentialsController;
	NewAccountViewController* newAccountController;
	NoCredentialsProfileDataSource* noCredentials;
	ValidCredentialsProfileDataSource* validCredentials;
	NoAccountDataProfileDataSource* noAccountData;
	NoAccountDataProfileDataSource* loadingAccountData;
	EditProfileDataSource* editProfileDataSource;
}

- (void) displayModalCredentialsController;
- (void) displayModalNewAccountController;

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) CredentialsViewController* credentialsController;
@property (nonatomic, retain) NewAccountViewController* newAccountController;
@property (nonatomic, retain) NoCredentialsProfileDataSource* noCredentials;
@property (nonatomic, retain) ValidCredentialsProfileDataSource* validCredentials;
@property (nonatomic, retain) NoAccountDataProfileDataSource* noAccountData;
@property (nonatomic, retain) NoAccountDataProfileDataSource* loadingAccountData;
@property (nonatomic, retain) 	EditProfileDataSource* editProfileDataSource;
@end
