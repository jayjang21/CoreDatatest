//
//  AttendanceHistorySearchViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 2014-09-20.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AttendanceHistorySearchViewController.h"

@interface AttendanceHistorySearchViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *yearList;
@property (strong, nonatomic) NSMutableArray *monthList;

@property (strong, nonatomic) NSDate *currentDate;

@property (strong, nonatomic) NSMutableArray *dateList;
@property (strong, nonatomic) NSMutableArray *timeList;
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
    
    self.dateList = [[NSMutableArray alloc] init];
    self.timeList = [[NSMutableArray alloc] init];

    
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

    [self.dateTimeTableView setDataSource:self];
    [self.dateTimeTableView setDelegate:self];
    //[self.dateTimeTableView registerClass:[UITableViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.iDTextField.text = @"1";

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

-(void) findAttendanceWithID:(NSString*)accountID
{
    
    if([accountID isEqualToString:@""])
        return;
    
    self.iDTextField.text = accountID;
    NSString *ID = accountID;
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    
    [self.dateList removeAllObjects];
    [self.timeList removeAllObjects];
    
    int yearrow = [self.yearMonthPickerView selectedRowInComponent:0];
    NSString *yearString = [self.yearList objectAtIndex:yearrow];
    
    int monthrow = [self.yearMonthPickerView selectedRowInComponent:1];
    NSString *monthString = [self.monthList objectAtIndex:monthrow];
    
    [Attendance bringAllDateTimeFromAttendance:ID withYear:yearString withMonth:monthString dateArray:&dateArray timeArray:&timeArray];
    
    if(dateArray) {
        for(int i=0; i<[dateArray count]; i++) {
            [self.dateList addObject: [dateArray objectAtIndex:i] ];
        }
    }
    
    if(timeArray) {
        for(int i=0; i<[timeArray count]; i++) {
            [self.timeList addObject: [timeArray objectAtIndex:i] ];
        }
    }
    //Attendance *currentAttendance = [[Attendance alloc] init];
    
    //currentAttendance.iD = ID;
    //currentAttendance.dateNSString = date;
    //currentAttendance.time = time;
    
    [self.dateTimeTableView reloadData];
}
-(IBAction)findAttendance:(id)sender
{
    NSString *ID = self.iDTextField.text;
    [self findAttendanceWithID:ID];
    
}




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



/*- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    if(section ==0) {
        header.textLabel.textColor = [UIColor redColor];
        header.textLabel.font = [UIFont boldSystemFontOfSize:18];
        CGRect headerFrame = header.frame;
        header.textLabel.frame = headerFrame;
        header.textLabel.textAlignment = NSTextAlignmentCenter;
        header.textLabel.text = @"Date";
    }
    else if(section ==1) {
        header.textLabel.textColor = [UIColor redColor];
        header.textLabel.font = [UIFont boldSystemFontOfSize:18];
        CGRect headerFrame = header.frame;
        header.textLabel.frame = headerFrame;
        header.textLabel.textAlignment = NSTextAlignmentCenter;
        header.textLabel.text = @"Time";
    }

}*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //if(section == 0)
    //    return @"Date";
    //else if(section == 1)
    //    return @"Time";
    //else
        return @"";
    //return [animalSectionTitles objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //if(section == 0)
        return [self.dateList count];
    //else if(section == 1)
    //    return [self.timeList count];
    //else
    //    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSString *cellIdentifier = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    
    if (tableView == self.dateTimeTableView){
        
        NSString *cellLabeldate = @"";
        NSString *cellLabeltime = @"";
        
        //if(indexPath.section==0) {
            cellLabeldate = [self.dateList objectAtIndex:indexPath.row];
        //}
        //else if(indexPath.section == 1) {
            cellLabeltime = [self.timeList objectAtIndex:indexPath.row];
        //}
        //NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
        cell.textLabel.text = cellLabeldate;
        cell.detailTextLabel.text = cellLabeltime;
        //cell.imageView.image = [UIImage imageNamed:[self getImageFilename:animal]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Selected Value is %@",[tableData objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    //[alertView show];
    
}

//-(void) searchAttendanceWithID:(NSString*) accountID
//{
//}

@end
