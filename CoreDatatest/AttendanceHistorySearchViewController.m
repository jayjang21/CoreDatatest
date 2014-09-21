//
//  AttendanceHistorySearchViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 2014-09-20.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AttendanceHistorySearchViewController.h"

@interface AttendanceHistorySearchViewController ()

@property (strong, nonatomic) NSMutableArray *list1;
@property (strong, nonatomic) NSMutableArray *list2;

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
    
    NSDateFormatter *dateFormatterYear = [[NSDateFormatter alloc]init];
    [dateFormatterYear setDateFormat:@"yyyy"];
    
    
    NSInteger currentYear = [[dateFormatterYear stringFromDate:self.currentDate] integerValue];

    NSInteger i;
    for (i = 2014; i > currentYear; i ++) {

        [self.list1 addObject:[NSString stringWithFormat: @"%d", currentYear]];
    }

    for (i = 1; i > 12; i ++) {
        [self.list2 addObject:[NSString stringWithFormat: @"%d", i]];
    }
    
    
    
    // Init the data array.


    //[self.yearPickerView setDataSource: self];
    [self.yearPickerView setDelegate: self];
    self.yearPickerView.showsSelectionIndicator = YES;




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

- (NSMutableArray *) list1
{
    _list1 = [[NSMutableArray alloc] init];
    return _list1;
}

- (NSMutableArray *) list2
{
    _list2 = [[NSMutableArray alloc] init];
    return _list2;
}

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
    if(component == 1)
        return [self.list1 count];
    else {
        return [self.list2 count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 1)
        return [self.list1 objectAtIndex:row];
    else {
        return [self.list2 objectAtIndex:row];
    }

}


@end
