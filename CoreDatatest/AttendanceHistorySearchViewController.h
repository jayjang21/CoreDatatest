//
//  AttendanceHistorySearchViewController.h
//  CoreDatatest
//
//  Created by Jay Jang on 2014-09-20.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "Attendance.h"
@interface AttendanceHistorySearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *iDTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *yearMonthPickerView;
//@property (strong, nonatomic) IBOutlet UIPickerView *monthPickerView;

@property (strong, nonatomic) IBOutlet UITableView *dateTimeTableView;



-(IBAction)findAttendance:(id)sender;
-(void) findAttendanceWithID:(NSString*)accountID;

@end
