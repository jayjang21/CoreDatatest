//
//  Attendance.h
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 12..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface Attendance : NSObject

@property (strong, nonatomic) NSString *dateNSString;
@property (strong, nonatomic) NSString *iD;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray *dateAndTime;

- (BOOL) saveAttendanceInformation;
- (BOOL) bringAllDateTimeAndNameFromAttendanceIDAndYearMonth;


@end
