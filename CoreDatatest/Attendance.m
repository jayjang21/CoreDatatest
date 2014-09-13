//
//  Attendance.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 12..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "Attendance.h"

@implementation Attendance

- (BOOL) saveAttendanceInformation
{
    BOOL result = NO;
    if (![self attendanceIDExistsWithSameAttendanceDate]){
        
       
            
            CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            NSManagedObjectContext *context =[appDelegate managedObjectContext];
            
            NSManagedObject *newInformation;
            newInformation = [NSEntityDescription insertNewObjectForEntityForName:@"Attendance" inManagedObjectContext:context];
            
            [newInformation setValue: self.iD forKey:@"iD"];
            //if ([informationType isEqualToString: @"name"]) {
        
        
            [newInformation setValue: [Account convertedNSDateFromDateString:self.dateNSString] forKey:@"date"];
            [newInformation setValue: self.time forKey:@"time"];
        
            
            
            NSError *error;
            [context save:&error];
            
            if(!error) {
                result = YES;
            }
            else {
                NSLog(@"%@", error.description);
            }
            //contact saved
            
            //return YES;
            
            
        
        
    }
    //return NO;
    
    return result;
}

- (BOOL) attendanceIDExistsWithSameAttendanceDate
{
    bool result = NO;
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(date = %@)", [Account convertedNSDateFromDateString: self.dateNSString]];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(iD = %@", self.iD];
        
        NSArray *predicates1And2 = @[predicate1, predicate2];
        
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates1And2];
        
        
        //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
        [request setPredicate: compoundPredicate];
         
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                                         error:&error]; //only possible in NSArray?
        
        if ([chosenEntities count] != 0) {
            result = YES;
        }
        
        
    }
    
    return result;

}

- (BOOL) bringAllDateTimeAndNameFromAttendanceIDAndYearMonth
{
    bool result = NO;
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
        
        //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
        NSManagedObject *theEntity = nil;
        
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                                         error:&error]; //only possible in NSArray?
        for (i = 0; i <= [chosenEntities count]; i ++) {
        theEntity = [chosenEntities objectAtIndex:i];
        
        if (theEntity) {
            
            self.dateNSString = [Account convertedNSStringFromNSDate: [theEntity valueForKey:@"date"]];
            self.time = [theEntity valueForKey:@"time"];
            
            
            
            result = YES;
            
        }
        }
        else {
            //error;
        }
        
    }
    
    return result;
}

@end
