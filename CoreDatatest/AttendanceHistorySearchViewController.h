//
//  AttendanceHistorySearchViewController.h
//  CoreDatatest
//
//  Created by Jay Jang on 2014-09-20.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceHistorySearchViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *iDTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *yearMonthPickerView;
//@property (strong, nonatomic) IBOutlet UIPickerView *monthPickerView;



@end
