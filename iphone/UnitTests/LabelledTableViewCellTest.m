#import "GTMSenTestCase.h"

#import "LabelledTableViewCell.h"


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

-(void)testWhenNotSelectedTextfieldDoesNotBecomeFirstResponder{
	testee.textField = [[[StubbedTextView alloc] init] autorelease];
	[testee setSelected:NO animated:YES];
	STAssertFalse([testee.textField isFirstResponder], nil);
}

-(void)testLabel{
	STAssertEqualStrings(@"the label text", [testee withLabelText:@"the label text"].label.text, nil);
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


@end
