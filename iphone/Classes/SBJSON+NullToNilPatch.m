
#import "SBJSON+NullToNilPatch.h"
extern NSError *err(int code, NSString *str); 

@implementation SBJSON(NullToNilPatch)
- (BOOL)scanRestOfNull:(NSNull **)o error:(NSError **)error
{
    if (!strncmp(c, "ull", 3)) {
        c += 3;
        *o = [NSNull null];
        return YES;
    }
    *error = err(EPARSE, @"Expected 'null'");
    return NO;
}
 

- (BOOL)scanRestOfDictionary:(NSMutableDictionary **)o error:(NSError **)error
{
    if (maxDepth && ++depth > maxDepth) {
        *error = err(EDEPTH, @"Nested too deep");
        return NO;
    }
    
    *o = [NSMutableDictionary dictionaryWithCapacity:7];
    
    for (; *c ;) {
        id k, v;
        
        skipWhitespace(c);
        if (*c == '}' && c++) {
            depth--;
            return YES;
        }    
        
        if (!(*c == '\"' && c++ && [self scanRestOfString:&k error:error])) {
            *error = errWithUnderlier(EPARSE, error, @"Object key string expected");
            return NO;
        }
        
        skipWhitespace(c);
        if (*c != ':') {
            *error = err(EPARSE, @"Expected ':' separating key and value");
            return NO;
        }
        
        c++;
        if (![self scanValue:&v error:error]) {
            NSString *string = [NSString stringWithFormat:@"Object value expected for key: %@", k];
            *error = errWithUnderlier(EPARSE, error, string);
            return NO;
        }
        
        [*o setObject:v forKey:k];
        
        skipWhitespace(c);
        if (*c == ',' && c++) {
            skipWhitespace(c);
            if (*c == '}') {
                *error = err(ETRAILCOMMA, @"Trailing comma disallowed in object");
                return NO;
            }
        }        
    }
    
    *error = err(EEOF, @"End of input while parsing object");
    return NO;
}

@end
