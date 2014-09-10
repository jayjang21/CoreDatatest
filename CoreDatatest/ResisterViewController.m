//
//  ResisterViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 22..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "ResisterViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>

@interface ResisterViewController ()

//@property (strong, nonatomic) NSString *iD;
//@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSString *phone;
//@property (strong, nonatomic) NSString *address;
//@property (strong, nonatomic) NSString *email;
//@property (strong, nonatomic) NSString *registerationDateNSString;
//@property (strong, nonatomic) NSString *dateOfBirthNSString;
//@property (strong, nonatomic) NSString *recentTestDateNSString;
//@property (strong, nonatomic) NSString *payDateNSString;

@property (strong, nonatomic) NSString *currentDateInString;
@property (strong, nonatomic) NSString *datePickingPickedDate;
@property (strong, nonatomic) NSString *datePickingDateKind;


@end

@implementation ResisterViewController
@synthesize popoverController;

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
    
   
    [self.profileImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleDoubleTap:)];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleSingleTap:)];
    
    [singleTap requireGestureRecognizerToFail : doubleTap];
    [doubleTap setDelaysTouchesBegan : YES];
    [singleTap setDelaysTouchesBegan : YES];
    
    [doubleTap setNumberOfTapsRequired : 2];
    [singleTap setNumberOfTapsRequired : 1];
    
    [self.profileImageView addGestureRecognizer : doubleTap];
    [self.profileImageView addGestureRecognizer : singleTap];
    

    
    //self.registerationDateButton.titleLabel.text = @"Hello";
   
    /*[self.registerationDateButton setTitle:[self.registerationDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.payDateButton setTitle:[self.payDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.dateOfBirthButton setTitle:[self.dateOfBirthButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.recentTestDateButton setTitle:[self.recentTestDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];*/
    
    self.registerationDateLabel.text = self.currentDateInString;
    self.payDateLabel.text = self.currentDateInString;
    self.dateOfBirthLabel.text = self.currentDateInString;
    self.recentTestDateLabel.text = self.currentDateInString;
   
    

    //made a NSString *currentDateInString and put the current date in string, using +date and -description method. Used *currentDateInString to set the labels in the four date text with the current date.
    
    //[self.datePickingDatePicker addTarget:self action:@selector(updateDateFromDatePicker:) forControlEvents:UIControlEventValueChanged];//perameter?
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

/*- (NSString *) iD
{
    _iD = self.iDTextField.text;
    return _iD;
}

- (NSString *) name
{
    _name = self.nameTextField.text;
    return _name;
}

- (NSString *) phone
{
    _phone = self.phoneTextField.text;
    return _phone;
}

- (NSString *) address
{
    _address = self.addressTextField.text;
    return _address;
}

- (NSString *) email
{
    _email = self.emailTextField.text;
    return _email;
}

- (NSString *) registerationDateNSString
{
    _registerationDateNSString = self.registerationDateLabel.text;
    return _registerationDateNSString;
}

- (NSString *) payDateNSString
{
    _payDateNSString = self.payDateLabel.text;
    return _payDateNSString;
}

- (NSString *) dateOfBirthNSString
{
    _dateOfBirthNSString = self.dateOfBirthLabel.text;
    return _dateOfBirthNSString;
}

- (NSString *) recentTestDateNSString
{
    _recentTestDateNSString = self.recentTestDateLabel.text;
    return _recentTestDateNSString;
}
*/

- (NSString *) currentDateInString
{
    //_currentDateInString = [[NSDate date] description];
    _currentDateInString = [Account convertedNSStringFromNSDate:[NSDate date]];
    return _currentDateInString;
}


- (IBAction)updateAccount:(id)sender
{
    Account *currentAccount = [[Account alloc] init];
    
    currentAccount.iD = self.iDTextField.text;
    currentAccount.name = self.nameTextField.text;
    currentAccount.phone = self.phoneTextField.text;
    currentAccount.address = self.addressTextField.text;
    currentAccount.email = self.emailTextField.text;
    currentAccount.registerationDateNSString = self.registerationDateLabel.text;
    currentAccount.dateOfBirthNSString = self.dateOfBirthLabel.text;
    currentAccount.recentTestDateNSString = self.recentTestDateLabel.text;
    currentAccount.payDateNSString = self.payDateLabel.text;
    currentAccount.profileImagePath = [NSString stringWithFormat: @"Documents/%@.jpg", currentAccount.iD];
    currentAccount.profileImage = self.profileImageView.image;
    
    [currentAccount updateAllAccountInformation];
}

- (IBAction)findAcocuntWithID:(id)sender
{
    if(self.iDTextField.text == nil || [self.iDTextField.text isEqualToString:@""])
        return;
    
    Account *currentAccount = [[Account alloc] init];
    
    currentAccount.iD = self.iDTextField.text;
    
    BOOL result = [currentAccount bringAllAccountInformationFromAccountID];
    
    if(result)
    {
        self.nameTextField.text = currentAccount.name;
        self.phoneTextField.text = currentAccount.phone;
        self.addressTextField.text = currentAccount.address;
        self.emailTextField.text= currentAccount.email;
        
        self.registerationDateLabel.text = currentAccount.registerationDateNSString;
        self.payDateLabel.text = currentAccount.payDateNSString;
        self.dateOfBirthLabel.text = currentAccount.dateOfBirthNSString;
        self.recentTestDateLabel.text = currentAccount.recentTestDateNSString;
        
        self.profileImageView.image = currentAccount.profileImage;
    }
}

- (IBAction)registerAccount:(id)sender
{
    Account *currentAccount = [[Account alloc] init];
    
    currentAccount.iD = self.iDTextField.text;
    currentAccount.name = self.nameTextField.text;
    currentAccount.phone = self.phoneTextField.text;
    currentAccount.address = self.addressTextField.text;
    currentAccount.email = self.emailTextField.text;
    currentAccount.registerationDateNSString = self.registerationDateLabel.text;
    currentAccount.dateOfBirthNSString = self.dateOfBirthLabel.text;
    currentAccount.recentTestDateNSString = self.recentTestDateLabel.text;
    currentAccount.payDateNSString = self.payDateLabel.text;
    currentAccount.profileImagePath = [NSString stringWithFormat: @"Documents/%@.jpg", currentAccount.iD];
    currentAccount.profileImage = self.profileImageView.image;
    
    [currentAccount saveAllAccountInformation];
}



- (IBAction)registerationDateButtonTapped:(UIButton *)sender
{
    self.datePickingDateKind = @"Registeration Date";
    
    
    //[self datePickingContainerViewPrepare];
    //self.datePickingContainerView.hidden = NO;
    
    [self datePickingShowAlertView];
}
- (IBAction)dateOfBirthButtonTapped:(id)sender
{
    self.datePickingDateKind = @"Date Of Birth";
    //[self datePickingContainerViewPrepare];
    //self.datePickingContainerView.hidden = NO;
    [self datePickingShowAlertView];
}

- (IBAction)recentTestDateButtonTapped:(id)sender
{
    self.datePickingDateKind = @"Recent Test Date";
    //[self datePickingContainerViewPrepare];
    //self.datePickingContainerView.hidden = NO;
    [self datePickingShowAlertView];
}

- (IBAction)payDateButtonTapped:(id)sender
{
    self.datePickingDateKind = @"Pay Date";
    //[self datePickingContainerViewPrepare];
    //self.datePickingContainerView.hidden = YES;
    [self datePickingShowAlertView];
}


/*- (IBAction)returnToMainView:(id)sender
{
    if ([self.datePickingDateKind isEqualToString: @"Registeration Date"]) {
        self.registerationDateNSString = self.datePickingPickedDate;
        self.registerationDateButton.titleLabel.text = self.datePickingResultLabel.text;
    } else if ([self.datePickingDateKind isEqualToString: @"Date Of Birth"]) {
        self.dateOfBirthNSString = self.datePickingPickedDate;
        self.dateOfBirthButton.titleLabel.text = self.datePickingResultLabel.text;
    } else if ([self.datePickingDateKind isEqualToString: @"Recent Test Date"]) {
        self.recentTestDateNSString = self.datePickingPickedDate;
        self.recentTestDateButton.titleLabel.text = self.datePickingResultLabel.text;
    } else if ([self.datePickingDateKind isEqualToString: @"Pay date"]) {
        self.payDateNSString = self.datePickingPickedDate;
        self.payDateButton.titleLabel.text = self.datePickingResultLabel.text;
    }
    
    self.datePickingContainerView.hidden = YES;
    
}*/

/*- (void) datePickingContainerViewPrepare
{
    if ([self.datePickingPickedDate isEqualToString: @"Registeration Date"]) {
        self.datePickingResultLabel.text = self.registerationDateButton.titleLabel.text;
    } else if ([self.datePickingPickedDate isEqualToString: @"Date Of Birth"]) {
        self.datePickingResultLabel.text = self.dateOfBirthButton.titleLabel.text;
    } else if ([self.datePickingPickedDate isEqualToString: @"Recent Test Date"]) {
        self.datePickingResultLabel.text = self.recentTestDateButton.titleLabel.text;
    } else if ([self.datePickingPickedDate isEqualToString: @"Pay date"]) {
        self.datePickingResultLabel.text = self.payDateButton.titleLabel.text;
    }
    
    
}*/
- (void) handleSingleTap:(UITapGestureRecognizer *)gr
{

    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == YES) {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePickerController.allowsEditing = NO;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


- (void) handleDoubleTap:(UITapGestureRecognizer *)gr
{
    // We are using an iPad
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if(popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:NO];
    }
    self.popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    self.popoverController.delegate=self;
    //[popoverController presentPopoverFromRect:imageView.bounds inView:imageView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    CGRect viewrect = self.profileImageView.bounds;
    viewrect.size.width /= 2;
    viewrect.size.height /= 2;

    [self.popoverController presentPopoverFromRect:viewrect inView:self.profileImageView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    UIImage *image = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        // Media is an image
        image = info[UIImagePickerControllerOriginalImage];
        //UIImage *image = info[UIImagePickerControllerEditedImage];
    }
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
        [self.profileImageView setImage: image];
        //[photoImageView setImage:photoImage];
        //[self showViewController:nil];
    }
    else {
        //[picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.profileImageView setImage:image];
            //[photoImageView setImage:photoImage];
            //[self showViewController:nil];
        }];
    }
}

- (void) datePickingShowAlertView
{
    // Create alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    // Show alert (required for sizes to be available)
    
    // Create date picker (could / should be an ivar)
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, alert.bounds.size.height, 260, 260)];
    picker.datePickerMode = UIDatePickerModeDate;
    
    if (self.registerationDateLabel.text == nil  || self.payDateLabel.text == nil|| self.dateOfBirthLabel.text ==nil || self.recentTestDateLabel.text == nil) {
        
        picker.date = [Account convertedNSDateFromDateString:self.currentDateInString];
        
    }
    else {
        if ([self.datePickingDateKind isEqualToString:@"Registeration Date"]) {
            picker.date = [Account convertedNSDateFromDateString: self.registerationDateLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Pay Date"]) {
            picker.date = [Account convertedNSDateFromDateString: self.payDateLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Date Of Birth"]) {
            picker.date = [Account convertedNSDateFromDateString: self.dateOfBirthLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Recent Test Date"]) {
            picker.date = [Account convertedNSDateFromDateString: self.recentTestDateLabel.text];
        }
    }
    
    // Add picker to alert
    //alert.alertViewStyle = UIAlertViewStyleDefault;
    //[alert addSubview:picker];
    
    [alert setValue:picker forKey:@"accessoryView"];
    // Adjust the alerts bounds
    //alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
    
    [alert show];
}
- (void) updateDateFromDatePicker: (UIDatePicker *) datePicker
{

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    self.datePickingPickedDate = [dateFormatter stringFromDate:datePicker.date];
    //self.datePickingResultLabel.text = [[NSString stringWithFormat:@"%@: ", self.datePickingDateKind ] stringByAppendingString:self.datePickingPickedDate];
    
    
    //[alert objectForKey:@"accessoryView"];
    //[alert getValue:picker forKey:@"accessoryView"];
    
    if ([self.datePickingDateKind isEqualToString: @"Registeration Date"]) {
        //self.registerationDateNSString = self.datePickingPickedDate;
        //[self.registerationDateButton setTitle: [NSString stringWithFormat:@"%@ :%@ ", self.datePickingDateKind, self.registerationDateNSString ]forState:UIControlStateNormal];
        //self.registerationDateButton.titleLabel.text = self.registerationDateNSString;
        self.registerationDateLabel.text = self.datePickingPickedDate;
    } else if ([self.datePickingDateKind isEqualToString: @"Date Of Birth"]) {
        //self.dateOfBirthNSString = self.datePickingPickedDate;
        //[self.dateOfBirthButton setTitle: [NSString stringWithFormat:@"%@ :%@ ", self.datePickingDateKind, self.dateOfBirthNSString ]forState:UIControlStateNormal];
        self.dateOfBirthLabel.text = self.datePickingPickedDate;

    } else if ([self.datePickingDateKind isEqualToString: @"Recent Test Date"]) {
        //self.recentTestDateNSString = self.datePickingPickedDate;
        //[self.recentTestDateButton setTitle: [NSString stringWithFormat:@"%@ :%@ ", self.datePickingDateKind, self.recentTestDateNSString ]forState:UIControlStateNormal];
        self.recentTestDateLabel.text = self.datePickingPickedDate;

    } else if ([self.datePickingDateKind isEqualToString: @"Pay Date"]) {
        //self.payDateNSString = self.datePickingPickedDate;
        //[self.payDateButton setTitle: [NSString stringWithFormat:@"%@ :%@ ", self.payDateNSString, self.payDateNSString ]forState:UIControlStateNormal];
        self.payDateLabel.text = self.datePickingPickedDate;

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 1) {
        
        UIDatePicker *picker = [alertView valueForKey:@"accessoryView"];
        
        [self updateDateFromDatePicker:picker];
        
        
    }
    /*
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Button 1"])
    {
        NSLog(@"Button 1 was selected.");
    }
    else if([title isEqualToString:@"Button 2"])
    {
        NSLog(@"Button 2 was selected.");
    }
    else if([title isEqualToString:@"Button 3"])
    {
        NSLog(@"Button 3 was selected.");
    }
     */
}



- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

@end


