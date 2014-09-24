//
//  PayDateViewController.m
//  CoreDatatest
//
//  Created by Daesik Jang on 2014-09-23.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "PayDateViewController.h"
#import "Account.h"

@interface PayDateViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UIPickerView *yearMonthPickerView;
@property (strong, nonatomic) IBOutlet UITableView *paydateTableView;

@property (strong, nonatomic) NSMutableArray *yearList;
@property (strong, nonatomic) NSMutableArray *monthList;

@property (strong, nonatomic) NSMutableArray *idList;
@property (strong, nonatomic) NSMutableArray *nameList;
@property (strong, nonatomic) NSMutableArray *paydateList;

@property (strong, nonatomic) NSDate *currentDate;

-(IBAction)findPayDate:(id)sender;
@end

@implementation PayDateViewController

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
    
    self.idList = [[NSMutableArray alloc] init];
    self.nameList = [[NSMutableArray alloc] init];
    self.paydateList = [[NSMutableArray alloc] init];
    
    
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
    
    [self.paydateTableView setDataSource:self];
    [self.paydateTableView setDelegate:self];
    //[self.paydateTableView registerClass:[UITableViewCell class] forCellWithReuseIdentifier:@"Cell"];

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

-(IBAction)findPayDate:(id)sender
{
    
    [self.idList removeAllObjects];
    [self.nameList removeAllObjects];
    [self.paydateList removeAllObjects];
    
    int yearrow = [self.yearMonthPickerView selectedRowInComponent:0];
    NSString *yearString = [self.yearList objectAtIndex:yearrow];
    
    int monthrow = [self.yearMonthPickerView selectedRowInComponent:1];
    NSString *monthString = [self.monthList objectAtIndex:monthrow];
    
    NSArray *accountArray = [Account bringAccountsWithPayDate:yearString withMonth:monthString];
    
    int numofaccount = [accountArray count];
    
    for(int a=0; a<numofaccount; a++) {
        //Load from Core Data
        NSManagedObject *anAccount = [accountArray objectAtIndex:a];
        
        NSString *ID = [anAccount valueForKey:@"iD"];
        NSString *name = [anAccount valueForKey:@"name"];
        //NSString *phone = [anAccount valueForKey:@"phone"];
        //NSString *address = [anAccount valueForKey:@"address"];
        //NSString *email = [anAccount valueForKey:@"email"];
        //NSString *registerationDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"registerationDate"]];
        //NSString *dateOfBirthNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"dateOfBirth"]];
        //NSString *recentTestDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"recentTestDate"]];
        NSString *payDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"payDate"]];
        
        //NSString *profileImagePath = [anAccount valueForKey:@"profileImagePath"];
        
        [self.idList addObject:ID];
        [self.nameList addObject:name];
        [self.paydateList addObject:payDateNSString];

    }

    [self.paydateTableView reloadData];
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
    return [self.idList count];
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
    
    if (tableView == self.paydateTableView ){
        
        NSString *cellLabelID = @"";
        NSString *cellLabelName = @"";
        NSString *cellLabelPayDate = @"";
        
        //if(indexPath.section==0) {
        cellLabelID = [self.idList objectAtIndex:indexPath.row];
        //}
        //else if(indexPath.section == 1) {
        cellLabelName = [self.nameList objectAtIndex:indexPath.row];
        //}
        //NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
        cellLabelPayDate = [self.paydateList objectAtIndex:indexPath.row];
        
        cell.textLabel.text = cellLabelID;
        
        NSString *namepaydate = [NSString stringWithFormat:@"%@( %@ )",cellLabelName,cellLabelPayDate ];
        cell.detailTextLabel.text = namepaydate;
        
        //cell.imageView.image = [UIImage imageNamed:[self getImageFilename:animal]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Selected Value is %@",[tableData objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    //[alertView show];
    
}

@end
