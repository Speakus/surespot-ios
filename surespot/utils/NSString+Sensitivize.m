//
//  NSString+Sensitivize.m
//  surespot
//
//  Created by Adam on 12/1/13.
//  Copyright (c) 2013 2fours. All rights reserved.
//

#import "NSString+Sensitivize.h"
#import "ChatUtils.h"
#import "DDLog.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

@implementation NSString (Sensitivize)


-(NSString *) hexEncode {
    NSString  * s = [@"1-" stringByAppendingString:[ChatUtils hexFromData:[self dataUsingEncoding:NSUTF8StringEncoding]]];
    return s;
}

-(NSString *) hexDecode: (NSString *) string {
    NSString * s = [[NSString alloc] initWithData:[ChatUtils dataFromHex:string] encoding:NSUTF8StringEncoding];
    return s;
    
    
}

-(NSString *) caseInsensitivize {
    
        
        
        // char buffer[100];
        //    BOOL gotFilename = [self getFileSystemRepresentation:buffer maxLength:100];
        //  [NSString stringWithUTF8String: [self fileSystemRepresentation]];
        
        NSMutableString * sb = [NSMutableString new];
        [self enumerateSubstringsInRange:NSMakeRange(0,[self length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  DDLogInfo(@"char: %@", substring);
                                  unichar buffer[1];
                                  
                                  [self getCharacters:buffer range:substringRange];
                                  
                                  if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:buffer[0]]) {
                                      
                                      [sb appendString:@"_"];
                                  }
                                  [sb appendFormat:@"%@",substring];
                              }];
        
        
        //    for (int i = 0; i < [self length]; i++) {
        //        unichar uni = [self characterAtIndex:i];
        //
        //        NSString * newchar = [NSString stringWithFormat:@"%c", uni];
        //        DDLogInfo(@"newchar: %@", newchar);
        //
        //        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:uni]) {
        //            [sb appendString:@"_"];
        //            [sb appendFormat:@"%c",uni];
        //        }
        //        else {
        //            [sb appendFormat:@"%c",uni];
        //        }
        //    }
        //    NSString * s = [NSString stringWithString:sb];
        //    return s;
        return sb;
    }

//-(NSString *) caseInsensitivize {
//    NSMutableString * sb = [NSMutableString new];
//    
//    for (int i = 0; i < [self length]; i++) {
//        unichar uni = [self characterAtIndex:i];
//        
//        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:uni]) {
//            [sb appendString:@"_"];
//            [sb appendFormat:@"%c",[self characterAtIndex:i]];
//        }
//        else {
//            [sb appendFormat:@"%c",uni];
//        }
//    }
//    return sb;
//}

-(NSString *) caseInsensitivize: (NSInteger) version {
    switch (version) {
        case 0:
            return [self caseInsensitivize];
            break;
        case 1:
            return [self hexEncode];
            
        default:
            break;
    }
    return [self hexEncode];
}

-(NSString *) caseSensitivize {
    if ([self hasPrefix:@"1-"]) {
        //new filename format
        return [self hexDecode: [self substringFromIndex:[@"1-" length]]];
    }
    else {
        
        NSMutableString * sb = [NSMutableString new];
        
        for (int i = 0; i < [self length]; i++) {
            unichar uni = [self characterAtIndex:i];
            
            if (uni == '_') {
                [sb appendFormat: @"%c",[[self uppercaseString] characterAtIndex: ++i]];
            }
            else {
                [sb appendFormat: @"%c",uni];
            }
        }
        
        return sb;
    }
}

@end
