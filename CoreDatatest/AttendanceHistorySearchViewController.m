//
//  AttendanceHistorySearchViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 2014-09-20.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AttendanceHistorySearchViewController.h"

@interface AttendanceHistorySearchViewController ()

@property (strong, nonatomic) NSMutableArray *yearList;
@property (strong, nonatomic) NSMutableArray *monthList;

@property (strong, nonatomic) NSDate *currentDate;

@end

@implementation AttendanceHistorySearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.yearList = [[NSMutableArray alloc] init];
    self.monthList = [[NSMutableArray alloc] init];
    
    NSDateFormatter *dateFormatterYear = [[NSDateFormatter alloc]init];
    [dateFormatterYear setDateFormat:@"yyyy"];
    NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc]init];
    [dateFormatterMonth setDateFormat:@"MM"];
    
    NSInteger currentYear = [[dateFormatterYear stringFromDate:self.currentDate] integerValue];
    NSInteger currentMonth = [[dateFormatterMonth stringFromDate:self.currentDate] integerValue];


    
    NSInteger i;
    int startYear = 2012;
    for (i = startYear; i <= currentYear; i ++) {

        [self.yearList addObject:[NSString stringWithFormat: @"%d", i]];
    }

    for (i = 1; i <= 12; i ++) {
        [self.monthList addObject:[NSString stringWithFormat: @"%d", i]];
    }
    
    
    
    // Init the data array.


    [self.yearMonthPickerView setDataSource: self];
    [self.yearMonthPickerView setDelegate: self];
    self.yearMonthPickerView.showsSelectionIndicator = YES;

    [self.yearMonthPickerView selectRow:currentMonth - 1 inComponent:1 animated:YES];
    [self.yearMonthPickerView selectRow:currentYear - startYear inComponent:0 animated:YES];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSDate *) currentDate
{
    _currentDate = [NSDate date];
    return _currentDate;
}

/*
- (NSMutableArray *) list1
{

    return _list1;
}

- (NSMutableArray *) list2
{

    return _list2;
}
*/
- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //if(component == 1)
        //selectedRowPicker1 = row;
        //else if(component == 2)
        //selectedRowPicker2 = row;
        //else{}
        //selectedRowPicker3 = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return [self.yearList count];
    else {
        return [self.monthList count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
        return [self.yearList objectAtIndex:row];
    else {
        return [self.monthList objectAtIndex:row];
    }

}


@end
