#import "GTMSenTestCase.h"
#import "NSObject+CleanUpProperties.h"


@interface NSObject_CleanUpPropertiesTest :GTMTestCase{
    NSString* prop1;
    NSString* prop2;
    NSInteger notAnObject;
}

@property(nonatomic, retain) NSString* prop1;
@property(nonatomic, retain) NSString* prop2;
@property(nonatomic) NSInteger notAnObject;
@property(nonatomic,readonly) NSString* readOnly;
@end


@implementation NSObject_CleanUpPropertiesTest : GTMTestCase
@synthesize prop1, prop2, notAnObject;

-(NSString*)notReallyAProperty{
    return @"hi";
}

-(NSString*)readOnly{
    return @"hello";
}

-(void)testSettingPropertiesToNil{
    self.prop1 = @"hello";
    self.prop2 = @"matey";
    self.notAnObject = 3;
    
    [self setEveryObjCObjectPropertyToNil];
    STAssertNil(self.prop1, nil);
    STAssertNil(self.prop2, nil);
    STAssertEquals(3, self.notAnObject,nil);
}
@end
