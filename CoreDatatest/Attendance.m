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
    
    return [Attendance saveAttendanceInformation:self.iD withDate:self.dateNSString withTime:self.time];
    
    /*
    BOOL result = NO;
    if ( [Account AccountAlreadyExists:self.iD] && ![self attendanceIDExistsWithSameAttendanceDate]){
        
       
            
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
     */
}




- (BOOL) attendanceIDExistsWithSameAttendanceDate
{
    
    return [Attendance attendanceIDExistsWithSameAttendanceDate:self.iD withDate:self.dateNSString];
    
    /*
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
        
        if ([chosenEntities count] > 0) {
            result = YES;
        }
        
        
    }
    
    return result;
     */
}



- (BOOL) bringAllDateTimeAndNameFromAttendanceIDAndYear: (NSString *) inputYear AndMonth: (NSString *) inputMonth
{
    
    NSMutableArray *dArray;
    NSMutableArray *tArray;
    
    return [Attendance bringAllDateTimeFromAttendance:self.iD withYear:inputYear withMonth:inputMonth dateArray:&dArray timeArray:&tArray];
    
    
    self.dateArray = dArray;
    self.timeArray = tArray;
    
    /*
    bool result = NO;
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(iD = %@)", self.iD];
        
        
        NSDate *startOfDay = [Account convertedNSDateFromDateString:[NSString stringWithFormat:(@"%@-%@-01"), inputYear, inputMonth]];
        NSDate *endOfDay = [Account convertedNSDateFromDateString:[NSString stringWithFormat:(@"%@-%@-31"), inputYear, inputMonth]];
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"date BETWEEN %@", [NSArray arrayWithObjects:startOfDay, endOfDay, nil]];
        
        
        NSArray *predicates12 = @[predicate1, predicate2];
        
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates12];
        
        
        [request setPredicate: compoundPredicate];
        

        
        
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                                         error:&error]; //only possible in NSArray?
        //Initialize date Array
        if(self.dateArray) {
            [self.dateArray removeAllObjects];
        }
        else {
            self.dateArray = [[NSMutableArray alloc] init];
        }
        
        //Initialize time Array
        if(self.timeArray) {
            [self.timeArray removeAllObjects];
        }
        else {
            self.timeArray = [[NSMutableArray alloc] init];
        }
        
        
        //Load date and time, add them to array
        NSManagedObject *theEntity = nil;
        for (int i = 0; i <= [chosenEntities count]; i ++) {
            theEntity = [chosenEntities objectAtIndex:i];
            
            if (theEntity) {
                
                NSDate *eachDate = [theEntity valueForKey:@"date"];
                NSString *eachTime = [theEntity valueForKey:@"time"];
                
                [self.dateArray addObject:eachDate];
                [self.timeArray addObject:eachTime];
                
                //NSString *eachDateAndTime = NSString stringWithFormat:(@"%@:%@"), [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"date"]], [theEntity valueForKey@
                result = YES;
                
            }
        }

        
    }
    
    return result;
     */
}


#pragma mark - Class Methods

+ (BOOL) saveAttendanceInformation:(NSString*)inputID withDate:(NSString*)inputDate withTime:(NSString*)inputTime
{
    BOOL result = NO;
    if ([Account AccountAlreadyExists:inputID] &&
        ![self attendanceIDExistsWithSameAttendanceDate:inputID withDate:inputDate]){
        
        
        
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context =[appDelegate managedObjectContext];
        
        NSManagedObject *newInformation;
        newInformation = [NSEntityDescription insertNewObjectForEntityForName:@"Attendance" inManagedObjectContext:context];
        
        [newInformation setValue: inputID forKey:@"iD"];
        //if ([informationType isEqualToString: @"name"]) {
        
        
        [newInformation setValue: [Account convertedNSDateFromDateString:inputDate] forKey:@"date"];
        [newInformation setValue: inputTime forKey:@"time"];
        
        
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

+ (BOOL) attendanceIDExistsWithSameAttendanceDate:(NSString*)inputID withDate:(NSString*)inputDate
{
    bool result = NO;
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(date = %@)", [Account convertedNSDateFromDateString: inputDate]];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(iD = %@)", inputID];
        
        NSArray *predicates1And2 = @[predicate1, predicate2];
        
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates1And2];
        
        
        //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(ID = %@)", self.iD];
        [request setPredicate: compoundPredicate];
        
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                                         error:&error]; //only possible in NSArray?
        
        if ([chosenEntities count] > 0) {
            result = YES;
        }
        
        
    }
    
    return result;
}


+ (NSArray*) bringAllAttendance
{
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request
                                                     error:&error]; //only possible in NSArray?
    
    return chosenEntities;
}

+ (BOOL) bringAllDateTimeFromAttendance:(NSString*)inputID withYear:(NSString *) inputYear withMonth: (NSString *) inputMonth dateArray:(NSMutableArray **)dArray timeArray:(NSMutableArray**)tArray;
{
    
    
    if(!dArray) {
        *dArray  = [[NSMutableArray alloc] init];
    }
    
    if(!tArray) {
        *tArray  = [[NSMutableArray alloc] init];
    }
    
    bool result = NO;
    
    //Initialize date Array
    //NSMutableArray *dateTimeArray = nil; //[[NSMutableArray alloc] init];
    
    //if ([self AccountIDAlreadyExists])
    {
        CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Attendance" inManagedObjectContext:context]];
        
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(iD = %@)", inputID];
        
        
        //NSDate *startOfDay = [Account convertedNSDateFromDateString:[NSString stringWithFormat:(@"%@-%@-01"), inputYear, inputMonth]];
        //NSDate *endOfDay = [Account convertedNSDateFromDateString:[NSString stringWithFormat:(@"%@-%@-31"), inputYear, inputMonth]];
        
        
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        [components setDay:1];
        [components setMonth:inputMonth.intValue];
        [components setYear:inputYear.intValue];
        NSDate *startDate = [gregorian dateFromComponents:components];

        NSRange daysRange = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:startDate];

        
        [components setDay:daysRange.length];
        [components setMonth:inputMonth.intValue];
        [components setYear:inputYear.intValue];
        NSDate *endDate = [gregorian dateFromComponents:components];
        
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(date >= %@) && (date <= %@)", startDate, endDate];
        //NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"date BETWEEN %@", [NSArray arrayWithObjects:startOfDay, endOfDay, nil]];
        
        
        NSArray *predicates12 = @[predicate1, predicate2];
        
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates12];
        
        
        [request setPredicate: compoundPredicate];
        
        
        
        
        NSError *error;
        NSArray *chosenEntities = [context executeFetchRequest:request
                                                         error:&error]; //only possible in NSArray?

        
        
        //Initialize time Array
        //NSMutableArray *dateTime = [[NSMutableArray alloc] init];
        
        //if([chosenEntities count] > 0) {
        //    dateTimeArray = [[NSMutableArray alloc] init];
        //}
        
        //Load date and time, add them to array
        NSManagedObject *theEntity = nil;
        for (int i = 0; i < [chosenEntities count]; i ++) {
            theEntity = [chosenEntities objectAtIndex:i];
            
            if (theEntity) {
                
                NSDate *eachDate = [theEntity valueForKey:@"date"];
                NSString *eachTime = [theEntity valueForKey:@"time"];
                
                [(*dArray) addObject:[Account convertedNSStringFromNSDate:eachDate]];
                [(*tArray) addObject:eachTime];
                //[dateTime addObject:eachDate];
                //[dateTime addObject:eachTime];
                
                //[dateTimeArray addObject:dateTime];
                
                //NSString *eachDateAndTime = NSString stringWithFormat:(@"%@:%@"), [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"date"]], [theEntity valueForKey@
                result = YES;
                
            }
        }
        
        
    }
    
    
    return result;
    
    //if(result) {
    //
     //   return dateTimeArray;
    //}
    //else
    //    return nil;
}


@end
