#import "GTMSenTestCase.h"
#import "DatePickerViewController.h"
#import "LabelledTableViewCell.h"

@interface StubbedViewController : UIViewController{
@public 
	UIViewController* presentedModalViewController;
}
@end

@implementation StubbedViewController
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated{
	presentedModalViewController = modalViewController;
}
@end

@interface StubbedTextView : UITextView{
	BOOL isFirstResponder;
}

- (BOOL)becomeFirstResponder;
- (BOOL)isFirstResponder;

@end

@implementation StubbedTextView
- (BOOL)becomeFirstResponder{
	return isFirstResponder = YES;
}

- (BOOL)isFirstResponder{
	return isFirstResponder;
}

@end

@interface LabelledTableViewCellTest : GTMTestCase{
    LabelledTableViewCell* testee;
}

@property(nonatomic, retain) LabelledTableViewCell* testee;
@end


@implementation LabelledTableViewCellTest
@synthesize testee;

-(void)setUp{
    self.testee = [LabelledTableViewCell loadLabelledCell];
}

-(void)testInitialised{
    STAssertNotNil(self.testee, nil);
    STAssertTrue([testee isKindOfClass:[LabelledTableViewCell class]], nil);
 }

-(void)testWhenSelectedTextfieldBecomesFirstResponder{
	testee.textField = [[[StubbedTextView alloc] init] autorelease];
	[testee setSelected:YES animated:YES];
	STAssertTrue([testee.textField isFirstResponder], nil);
}

-(void)testWhenActivatedTextFieldBecomesFirstResponder{
	testee.textField = [[[StubbedTextView alloc] init] autorelease];
	[testee activateEditing];
	STAssertTrue([testee.textField isFirstResponder], nil);	
}

-(void)testWhenNotSelectedTextfieldDoesNotBecomeFirstResponder{
	testee.textField = [[[StubbedTextView alloc] init] autorelease];
	[testee setSelected:NO animated:YES];
	STAssertFalse([testee.textField isFirstResponder], nil);
}

-(void)testLabel{
	STAssertEqualStrings(@"the label text", [testee withLabelText:@"the label text"].label.text, nil);
}

-(void)testErrorField{
	STAssertEqualStrings(@"Login", [testee withErrorField:@"Login"].errorField, nil);	
}

-(void)testPlaceholder{
	STAssertEqualStrings(@"required", [testee withPlaceholder:@"required"].textField.placeholder, nil);	
}

-(void)testMakeSecure{
    UITextField* textField = [testee makeSecure].textField;
    STAssertEquals(UITextAutocapitalizationTypeNone, textField.autocapitalizationType, nil);
    STAssertEquals(UITextAutocorrectionTypeNo, textField.autocorrectionType, nil);
	STAssertEquals(UIKeyboardTypeASCIICapable, textField.keyboardType, nil);
    STAssertTrue(textField.secureTextEntry, nil);    
}

-(void)testNoCorrections{
    UITextField* textField = [testee withoutCorrections].textField;
    STAssertEquals(UITextAutocapitalizationTypeNone, textField.autocapitalizationType, nil);
    STAssertEquals(UITextAutocorrectionTypeNo, textField.autocorrectionType, nil);
	STAssertEquals(UIKeyboardTypeDefault, textField.keyboardType, nil);
}

-(void)testMakeEmail{
    UITextField* textField = [testee makeEmail].textField;
    STAssertEquals(UITextAutocapitalizationTypeNone, textField.autocapitalizationType, nil);
    STAssertEquals(UITextAutocorrectionTypeNo, textField.autocorrectionType, nil);
	STAssertEquals(UIKeyboardTypeEmailAddress, textField.keyboardType, nil);
	
}

-(void)testMakingDateSetsDisclosureAccessory{
	STAssertEquals(UITableViewCellAccessoryDisclosureIndicator, [testee makeDateUsingParent:nil atInitialDate:[NSDate dateWithTimeIntervalSince1970:0]].accessoryType, nil);
}


-(void)testWhenMadeDateActivatingPresentsDatePickerController{
	NSDate* date = [NSDate dateWithTimeIntervalSince1970:1000];
	StubbedViewController* parent = [[[StubbedViewController alloc] init] autorelease];
	[testee makeDateUsingParent:parent atInitialDate:date];
	[testee activateEditing];
	STAssertNotNil(parent->presentedModalViewController, nil);
	STAssertTrue([parent->presentedModalViewController isKindOfClass:[DatePickerViewController class]], nil);
	STAssertEqualObjects(date, [parent->presentedModalViewController initialDate], nil);
}

-(void)testDatePickerControllerHasReferenceToLabelledTableViewCellTextField{
	StubbedViewController* parent = [[[StubbedViewController alloc] init] autorelease];
	[testee makeDateUsingParent:parent atInitialDate:[NSDate dateWithTimeIntervalSince1970:0]];
	[testee activateEditing];
	DatePickerViewController* datePickerViewController = (DatePickerViewController*) parent->presentedModalViewController;
	STAssertEqualObjects(testee.textField, datePickerViewController.dateTextField, nil);
	
	
}


@end
