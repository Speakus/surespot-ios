//
//  EncryptionParams.m
//  surespot
//
//  Created by Adam on 12/14/13.
//  Copyright (c) 2013 surespot. All rights reserved.
//

#import "EncryptionParams.h"

@implementation EncryptionParams
-(id) initWithOurUsername: (NSString *) ourUsername
               ourVersion: (NSString *) ourVersion
            theirUsername: (NSString *) theirUsername
             theirVersion: (NSString *) theirVersion
                       iv: (NSString *) iv
                   hashed:(BOOL)hashed {
    self = [super init];
    if (self) {
        self.ourUsername = ourUsername;
        self.ourVersion = ourVersion;
        self.theirUsername = theirUsername;
        self.theirVersion = theirVersion;
        self.iv = iv;
        self.hashed = hashed;
    }    
    
    return self;

}
@end
