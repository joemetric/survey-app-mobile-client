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
    self.testee = [LabelledTableViewCell loadLabelledCellWithOwner: self];
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


@end
