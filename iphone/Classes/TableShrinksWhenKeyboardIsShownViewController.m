
#import "TableShrinksWhenKeyboardIsShownViewController.h"


@implementation TableShrinksWhenKeyboardIsShownViewController
@synthesize tableView, keyboardIsShowing;

- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];	
	[super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL) animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

-(NSInteger) tableShrinkingKeyboardHeightCorrection{
    return 0;
}

-(NSInteger)amountToShrinkTableWhenKeyboardIsShownFromNotification:(NSNotification*)note{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    return keyboardHeight - [self tableShrinkingKeyboardHeightCorrection];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    if (self.keyboardIsShowing == NO)
    {
        self.keyboardIsShowing = YES;
        CGRect frame = self.tableView.frame ;
        frame.size.height -= [self amountToShrinkTableWhenKeyboardIsShownFromNotification:note];
		
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        self.tableView.frame = frame;
        [UIView commitAnimations];
    }
}


-(void) keyboardWillHide:(NSNotification *)note
{
    if (self.keyboardIsShowing == YES)
    {
        self.keyboardIsShowing = NO;
        CGRect frame = self.tableView.frame;
        frame.size.height += [self amountToShrinkTableWhenKeyboardIsShownFromNotification:note];
		
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        self.tableView.frame = frame;
        [UIView commitAnimations];
    }
}


- (void)dealloc {
    self.tableView = nil;
    [super dealloc];
}


@end
