#import <UIKit/UIKit.h>
#import "Account.h"
#import "TableShrinksWhenKeyboardIsShownViewController.h"


@class CredentialsViewController;
@class NewAccountViewController;
@class NoCredentialsProfileDataSource;
@class ValidCredentialsProfileDataSource;
@class NoAccountDataProfileDataSource;
@class EditProfileDataSource;
@class Account;


@interface ProfileViewController : TableShrinksWhenKeyboardIsShownViewController <AccountObserver> {
	id currentDataSource;
    IBOutlet UIActivityIndicatorView* activityIndicator;
}

- (void) displayModalCredentialsController;
- (void) displayModalNewAccountController;
-(IBAction)refreshAccount;

@property(nonatomic, retain) id currentDataSource;
@property(nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@end
