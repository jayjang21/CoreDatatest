//
//  Account.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 24..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "Account.h"

#import "UIKit/UIKit.h"

@interface Account()






@end

@implementation Account

- (instancetype) init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


/*- (void) setResisterationDateNSDate:(NSDate *)resisterationDateNSDate
{
    _resisterationDateNSDate = resisterationDateNSDate;
    
    if (!setterBool) {
        setterBool = YES;
        self.resisterationDateNSString = [self convertedNSStringFromNSDate:resisterationDateNSDate];
    }else {
        setterBool = NO;
    }
    

}

- (void) setDateOfBirthNSDate:(NSDate *)dateOfBirthNSDate
{
    _dateOfBirthNSDate = dateOfBirthNSDate;
    
    if (!setterBool) {
        setterBool = YES;
        self.dateOfBirthNSString = [self convertedNSStringFromNSDate:dateOfBirthNSDate];
    }else {
        setterBool = NO;
    }
    
    
}

- (void) setRecentTestDateNSDate:(NSDate *)recentTestDateNSDate
{
    _recentTestDateNSDate = recentTestDateNSDate;
    
    if (!setterBool) {
        setterBool = YES;
        self.recentTestDateNSString = [self convertedNSStringFromNSDate:recentTestDateNSDate];
    }else {
        setterBool = NO;
    }
    
}

- (void) setPayDateNSDate:(NSDate *)payDateNSDate
{
    _payDateNSDate = payDateNSDate;
    
    if (!setterBool) {
        setterBool = YES;
        self.payDateNSString = [self convertedNSStringFromNSDate:payDateNSDate];
    }else {
        setterBool = NO;
    }
    
    
}

- (void) setResisterationDateNSString:(NSString *)resisterationDateNSString
{
    _resisterationDateNSString = resisterationDateNSString;
    
    if (!setterBool) {
        setterBool = YES;
        self.resisterationDateNSDate = [self convertedNSDateFromDateString:resisterationDateNSString];
    } else {
        setterBool = NO;
    }
    
    
}

- (void) setDateOfBirthNSString:(NSString *)dateOfBirthNSString
{
    _dateOfBirthNSString = dateOfBirthNSString;
    
    if (!setterBool) {
        setterBool = YES;
        self.dateOfBirthNSDate = [self convertedNSDateFromDateString:dateOfBirthNSString];
    } else {
        setterBool = NO;
    }
    
    
}

- (void) setRecentTestDateNSString:(NSString *)recentTestDateNSString
{
    _recentTestDateNSString = recentTestDateNSString;
    
    if (!setterBool) {
        setterBool = YES;
        self.recentTestDateNSDate = [self convertedNSDateFromDateString:recentTestDateNSString];
    } else {
        setterBool = NO;
    }
    
    
}

- (void) setPayDateNSString:(NSString *)payDateNSString
{
    _payDateNSString = payDateNSString;
    
    if (!setterBool) {
        setterBool = YES;
        self.payDateNSDate = [self convertedNSDateFromDateString:payDateNSString];
    } else {
        setterBool = NO;
    }
    
    
} */
/*- (NSDate *) resisterationDateNSDate
{
    if (![self.resisterationDateNSString isEqual: @""]) {
        
    _resisterationDateNSDate = [self convertedNSDateFromDateString:self.resisterationDateNSString];
    
    //self.recentTestDateNSString = nil;
    self.resisterationDateNSString = @"";
    
    }
    return _resisterationDateNSDate;
}

- (NSDate *) dateOfBirthNSDate
{
    if (![self.dateOfBirthNSString isEqual: @""]) {
        
    _dateOfBirthNSDate = [self convertedNSDateFromDateString:self.dateOfBirthNSString];
    
    self.dateOfBirthNSString = @"";
        
    }
    return _dateOfBirthNSDate;
}

- (NSDate *) recentTestDateNSDate
{
    if (![self.recentTestDateNSString isEqual: @""]) {
        
    _recentTestDateNSDate = [self convertedNSDateFromDateString:self.recentTestDateNSString];
    
    self.recentTestDateNSString = @"";
        
    }
    return _recentTestDateNSDate;
}

- (NSDate *) payDateNSDate
{
    if (![self.payDateNSString isEqual: @""]) {
        
    _payDateNSDate = [self convertedNSDateFromDateString:self.payDateNSString];
    
    self.payDateNSString = @"";
        
    }
    return _payDateNSDate;
} */

- (BOOL) stringIsNumeric:(NSString*)inputString{
    BOOL isValid=NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}

- (BOOL) AccountIDAlreadyExists
{
    
    return [Account AccountAlreadyExists:self.iD];
    
    /*
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request error:&error];//where does NSError *error go?
    
    if ([chosenEntities count] > 0) {
        return YES;
    }

    return NO;
     */

}

+ (BOOL) AccountAlreadyExists:(NSString*)inputID
{
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", inputID]];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request error:&error];//where does NSError *error go?
    
    if ([chosenEntities count] > 0) {
        return YES;
    }
    
    return NO;
    
}

- (BOOL) iDAndNameInputsAreSuitable
{
    
    if ([self.iD  isEqualToString: @""]) {
        NSLog(@"nothing is written in 'name'");
        return NO;
    }
    
    if ([self.name  isEqualToString: @""]) {
        NSLog(@"nothing is written in 'name'");
        return NO;
    }
    

    /*
    //bool bNumeric = true;
    for(int i=0; i< self.phone.length; i++) {
        //NSString * newString = [self.phone substringWithRange:NSMakeRange(i, 1)];
        
        if(![self stringIsNumeric:[self.phone substringWithRange:NSMakeRange(i, 1)]]) {
            //bNumeric = false;
            //break;
            
            NSLog(@"the 'phone' has to be in numbers only");
            return NO;
        }
    }
    */
    //if(!bNumeric) {
        
    //}
    
    
    //if (![self.phone isKindOfClass:[NSNumber class]]) {
    //    NSLog(@"the 'phone' has to be in numbers only");
    //    return NO;
    //}
    
    //if ([self.address isEqualToString:@""]) {
    //    NSLog(@"nothing is written in 'address'");
    //    return NO;
    //}
    
    //if ([self.email isEqualToString:@""]) {
    //    NSLog(@"nothing is written in 'email'");
    //    return NO;
    //}
    

    
    return YES;
    
}

+ (NSDate *) convertedNSDateFromDateString: (NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *convertedDate = [dateFormatter dateFromString:dateString];
    
    return convertedDate;
}

+ (NSString *) convertedNSStringFromNSDate: (NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    
    return convertedString;
}


- (BOOL) saveAllAccountInformation
{
    BOOL result = NO;
    if (![self AccountIDAlreadyExists]){
    
        if ([self iDAndNameInputsAreSuitable]) {
        
            CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
            NSManagedObjectContext *context =[appDelegate managedObjectContext];
    
            NSManagedObject *newInformation;
            newInformation = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
            
            [newInformation setValue: self.iD forKey:@"ID"];
    //if ([informationType isEqualToString: @"name"]) {
            [newInformation setValue: self.name forKey:@"name"];
    //}
    //else if ([informationType isEqualToString:@"phone"]){
            [newInformation setValue: self.phone forKey:@"phone"];
    //}
    //else if ([informationType isEqualToString:@"address"]){
            [newInformation setValue: self.address forKey:@"address"];
            //}
    //else if ([informationType isEqualToString:@"email"]){
            [newInformation setValue: self.email forKey:@"email"];
    //}
            
            [newInformation setValue: [self.class convertedNSDateFromDateString:self.registerationDateNSString] forKey:@"registerationDate"];
            [newInformation setValue: [Account convertedNSDateFromDateString:self.dateOfBirthNSString] forKey:@"dateOfBirth"];
            [newInformation setValue: [Account convertedNSDateFromDateString:self.recentTestDateNSString] forKey:@"recentTestDate"];
            [newInformation setValue: [Account convertedNSDateFromDateString:self.payDateNSString] forKey:@"payDate"];
            
            
            [newInformation setValue:self.profileImagePath forKey:@"profileImagePath"];

            
    
            NSError *error;
            [context save:&error];
            
            if(!error) {
                [self saveAccountProfileImage];
                
                result = YES;
            }
            else {
                NSLog(@"%@", error.description);
            }
    //contact saved
    
    //return YES;
    
    
        }
      
    }
    //return NO;
    
    return result;
}


-(BOOL) updateAllAccountInformation
{
    //[self updateAccountInformationWithAttribute:@"name"];
    //[self updateAccountInformationWithAttribute:@"phone"];
    //[self updateAccountInformationWithAttribute:@"address"];
    //[self updateAccountInformationWithAttribute:@"email"];
    //[self updateAccountInformationWithAttribute:@"resisterationDateNSString"];
    //[self updateAccountInformationWithAttribute:@"dateOfBirthNSString"];
    //[self updateAccountInformationWithAttribute:@"recentTestDateNSString"];
    //[self updateAccountInformationWithAttribute:@"payDateNSString"];
    
    
    BOOL result = [self updateAccountInformation];
    
    [self saveAccountProfileImage];
    
    return result;
}

- (BOOL) updateAccountInformation
{
    BOOL result = NO;
    if ([self iDAndNameInputsAreSuitable]) {
        
        
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context =[appDelegate managedObjectContext];
        
        
        NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Account"];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"iD==%@",self.iD]; // If required to fetch specific vehicle
        fetchRequest.predicate=predicate;
        NSArray *chosenEntities =[context executeFetchRequest:fetchRequest error:nil];
        
        NSManagedObject *theEntity = [chosenEntities firstObject];
        
        if(theEntity) {

                [theEntity setValue: self.name forKey:@"name"];

                [theEntity setValue: self.phone forKey:@"phone"];

                [theEntity setValue: self.address forKey:@"address"];

                [theEntity setValue: self.email forKey:@"email"];

                [theEntity setValue: [Account convertedNSDateFromDateString:self.registerationDateNSString] forKey:@"registerationDate"];

                [theEntity setValue: [Account convertedNSDateFromDateString:self.dateOfBirthNSString] forKey:@"dateOfBirth"];

                [theEntity setValue: [Account convertedNSDateFromDateString:self.recentTestDateNSString] forKey:@"recentTestDate"];

                [theEntity setValue: [Account convertedNSDateFromDateString:self.payDateNSString] forKey:@"payDate"];

                [theEntity setValue: self.profileImagePath  forKey:@"profileImagePath"];
            
            //[object valueForKey:@"name"];
            
            NSError *error;
            [context save:&error];
            //contact updated
            
            result = YES;
            
        }
        
        //for (NSManagedObject *object in objectsArray) {
        //}
        
        
    }
    
    
    return result;
    
}


- (BOOL) updateAccountInformationWithAttribute:(NSString *)attributeName
{
    BOOL result = NO;
    if ([self iDAndNameInputsAreSuitable]) {
    
    
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =[appDelegate managedObjectContext];
    
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Account"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"iD==%@",self.iD]; // If required to fetch specific vehicle
    fetchRequest.predicate=predicate;
    NSArray *chosenEntities =[context executeFetchRequest:fetchRequest error:nil];
    
    NSManagedObject *theEntity = [chosenEntities firstObject];
    
    if(theEntity) {
        if ([attributeName isEqualToString: @"name"]) {
            [theEntity setValue: self.name forKey:@"name"];
        }
        else if ([attributeName isEqualToString:@"phone"]){
            [theEntity setValue: self.phone forKey:@"phone"];
        }
        else if ([attributeName isEqualToString:@"address"]){
            [theEntity setValue: self.address forKey:@"address"];
        }
        else if ([attributeName isEqualToString:@"email"]){
            [theEntity setValue: self.email forKey:@"email"];
        }
        else if ([attributeName isEqualToString:@"resisterationDateNSString"]){
            [theEntity setValue: [Account convertedNSDateFromDateString:self.registerationDateNSString] forKey:@"registerationDate"];
        }
        else if ([attributeName isEqualToString:@"dateOfBirthNSString"]){
            [theEntity setValue: [Account convertedNSDateFromDateString:self.dateOfBirthNSString] forKey:@"dateOfBirth"];
        }
        else if ([attributeName isEqualToString:@"recentTestDateNSString"]){
            [theEntity setValue: [Account convertedNSDateFromDateString:self.recentTestDateNSString] forKey:@"recentTestDate"];
        }
        else if ([attributeName isEqualToString:@"payDateNSString"]){
            [theEntity setValue: [Account convertedNSDateFromDateString:self.payDateNSString] forKey:@"payDate"];
        }
        else if ([attributeName isEqualToString:@"profileImagePath"]){
            [theEntity setValue: self.profileImagePath  forKey:@"profileImagePath"];
        }

        
        //[object valueForKey:@"name"];
        
        NSError *error;
        [context save:&error];
        //contact updated
        
        result = YES;
        
    }
    
    //for (NSManagedObject *object in objectsArray) {
    //}
    
      
    }

    
    return result;
    
}

+ (NSArray*) bringAllAccount
{
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    
    // Sort first by iD, then by name.
    NSSortDescriptor *idSort = [[NSSortDescriptor alloc] initWithKey:@"iD" ascending:YES];
    NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObjects:idSort, nameSort, nil];
    //request.sortDescriptors = [NSArray arrayWithObject:idSort];


    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
    //[request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
    //NSManagedObject *theEntity = nil;
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request
                                                     error:&error]; //only possible in NSArray?
    
    
    return chosenEntities;
    
    
    /*
    theEntity = [chosenEntities firstObject];
    
    if (theEntity) {
        
        self.name = [theEntity valueForKey:@"name"];
        self.phone = [theEntity valueForKey:@"phone"];
        self.address = [theEntity valueForKey:@"address"];
        self.email = [theEntity valueForKey:@"email"];
        self.registerationDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"registerationDate"]];
        self.dateOfBirthNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"dateOfBirth"]];
        self.recentTestDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"recentTestDate"]];
        self.payDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"payDate"]];
        
        self.profileImagePath = [theEntity valueForKey:@"profileImagePath"];
        
        [self loadAccountProfileImage];
        
        result = YES;
        
    }
    else {
        //error;
    }
     */
    
}

+ (Account*) bringAccountWithID:(NSString*)accountID //in this code we are assuming that IDs can't be duplicated
{
    Account *theAccount = nil;
    
    
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", accountID]];
    NSManagedObject *theEntity = nil;
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request
                                                     error:&error]; //only possible in NSArray?
    
    theEntity = [chosenEntities firstObject];
    
    if (theEntity) {

        theAccount = [[Account alloc] init];
        
        theAccount.iD = [theEntity valueForKey:@"iD"];
        theAccount.name = [theEntity valueForKey:@"name"];
        theAccount.phone = [theEntity valueForKey:@"phone"];
        theAccount.address = [theEntity valueForKey:@"address"];
        theAccount.email = [theEntity valueForKey:@"email"];
        theAccount.registerationDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"registerationDate"]];
        theAccount.dateOfBirthNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"dateOfBirth"]];
        theAccount.recentTestDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"recentTestDate"]];
        theAccount.payDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"payDate"]];
        
        theAccount.profileImagePath = [theEntity valueForKey:@"profileImagePath"];
        
        //[self loadAccountProfileImage];
    }
    
    return theAccount;
}

- (BOOL) bringAllAccountInformationFromAccountID //in this code we are assuming that IDs can't be duplicated
{
    
    bool result = NO;
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
        NSManagedObject *theEntity = nil;
    
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                              error:&error]; //only possible in NSArray?
    
        theEntity = [chosenEntities firstObject];
        
        if (theEntity) {
        
            self.name = [theEntity valueForKey:@"name"];
            self.phone = [theEntity valueForKey:@"phone"];
            self.address = [theEntity valueForKey:@"address"];
            self.email = [theEntity valueForKey:@"email"];
            self.registerationDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"registerationDate"]];
            self.dateOfBirthNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"dateOfBirth"]];
            self.recentTestDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"recentTestDate"]];
            self.payDateNSString = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"payDate"]];
        
            self.profileImagePath = [theEntity valueForKey:@"profileImagePath"];
            
            [self loadAccountProfileImage];
            
            result = YES;
  
        }
        else {
            //error;
        }
        
    }

    return result;
}

-(void)saveAccountProfileImage
{
    //NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:self.profileImagePath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory
                               stringByAppendingPathComponent:self.profileImagePath];
    
    //dsjang2
    [UIImageJPEGRepresentation(self.profileImage, 0.5) writeToFile:imagePath atomically:YES];
    
}

+(void)saveProfileImage:(UIImage*) profileImage withPath:(NSString*)localImagePath
{
    //NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:self.profileImagePath];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
    //                                                     NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *imagePath = [documentsDirectory
    //                       stringByAppendingPathComponent:localImagePath];
    
    //dsjang2
    [UIImageJPEGRepresentation(profileImage, 0.5) writeToFile:localImagePath atomically:YES];
    
}

-(void)loadAccountProfileImage
{
    
    [Account ProfileImageWithProfileImagePath:self.profileImagePath];
    
    self.profileImage = [Account ProfileImageWithProfileImagePath:self.profileImagePath];

}


+(UIImage *)ProfileImageWithProfileImagePath: (NSString *)originalProfileImageName
{
    
    NSString *profileImageName = [originalProfileImageName lastPathComponent];
    
    //NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:profileImagePath];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFullPath = [documentsDirectory
                           stringByAppendingPathComponent:profileImageName];

    //Old version
    if(![[NSFileManager defaultManager] fileExistsAtPath:imageFullPath]) {
        imageFullPath = [NSHomeDirectory() stringByAppendingPathComponent:profileImageName];
    }
    
    UIImage *profileImage = [UIImage imageWithContentsOfFile:imageFullPath];
    
    return profileImage;
}
@end


