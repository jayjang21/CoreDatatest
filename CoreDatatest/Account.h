//
//  Account.h
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 24..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDatatestAppDelegate.h"

@interface Account : NSObject
{
    //BOOL setterBool;
}

@property (strong, nonatomic) NSString *iD;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *registerationDateNSString;
@property (strong, nonatomic) NSString *dateOfBirthNSString;
@property (strong, nonatomic) NSString *recentTestDateNSString;
@property (strong, nonatomic) NSString *payDateNSString;
@property (strong, nonatomic) NSString *profileImagePath;
@property (strong, nonatomic) UIImage *profileImage;

/*@property (strong, nonatomic) NSDate *resisterationDateNSDate;
@property (strong, nonatomic) NSDate *dateOfBirthNSDate;
@property (strong, nonatomic) NSDate *recentTestDateNSDate;
@property (strong, nonatomic) NSDate *payDateNSDate;*/

+ (NSDate *) convertedNSDateFromDateString: (NSString *)dateString;
+ (NSString *) convertedNSStringFromNSDate: (NSDate *)date;
+(UIImage *)ProfileImageWithProfileImagePath: (NSString *)profileImagePath;



- (BOOL) saveAllAccountInformation;
- (BOOL) updateAccountInformationWithAttribute:(NSString *)attributeName;
- (BOOL) bringAllAccountInformationFromAccountID;
- (BOOL) updateAllAccountInformation;

+ (BOOL) AccountAlreadyExists:(NSString*)inputID;
+ (NSArray*) bringAllAccount;
+ (Account*) bringAccountWithID:(NSString*)accountID;

@end
