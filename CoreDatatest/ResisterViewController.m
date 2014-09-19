//
//  ResisterViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 22..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "ResisterViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>

#import <MessageUI/MFMailComposeViewController.h>

#import "GDataXMLNode.h"

#import <DropboxSDK/DropboxSDK.h>


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;
CGFloat animatedDistance;



@interface ResisterViewController () <MFMailComposeViewControllerDelegate, DBRestClientDelegate>


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
@property (strong, nonatomic) id justTappedTextField;

@property (nonatomic, strong) DBRestClient *restClient;

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
    
    
    [self.iDTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];//UIKeyboardTypeEmailAddress is the same as UIKeyboardTypeNumberPad.
    [self.phoneTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    
    [self.iDTextField setDelegate:self];
    [self.nameTextField setDelegate:self];
    [self.phoneTextField setDelegate:self];
    [self.addressTextField setDelegate:self];
    [self.emailTextField setDelegate:self];
    
    //self.registerationDateButton.titleLabel.text = @"Hello";
   
    /*[self.registerationDateButton setTitle:[self.registerationDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.payDateButton setTitle:[self.payDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.dateOfBirthButton setTitle:[self.dateOfBirthButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];
    [self.recentTestDateButton setTitle:[self.recentTestDateButton.titleLabel.text stringByAppendingString:self.currentDateInString] forState:UIControlStateNormal];*/
    
    self.registerationDateLabel.text = self.currentDateInString;
    self.payDateLabel.text = self.currentDateInString;
    self.dateOfBirthLabel.text = self.currentDateInString;
    self.recentTestDateLabel.text = self.currentDateInString;
   
    
    
    self.qrImageView.hidden = YES;
    

    //made a NSString *currentDateInString and put the current date in string, using +date and -description method. Used *currentDateInString to set the labels in the four date text with the current date.
    
    //[self.datePickingDatePicker addTarget:self action:@selector(updateDateFromDatePicker:) forControlEvents:UIControlEventValueChanged];//perameter?
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
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

- (IBAction)resetAllInputs:(id)sender
{
    //clear all texts
    self.iDTextField.text = @"";
    self.nameTextField.text = @"";
    self.phoneTextField.text = @"";
    self.addressTextField.text = @"";
    self.emailTextField.text = @"";
    
    //reset all date to currentDateInString
    self.registerationDateLabel.text = self.currentDateInString;
    self.payDateLabel.text = self.currentDateInString;
    self.dateOfBirthLabel.text = self.currentDateInString;
    self.recentTestDateLabel.text = self.currentDateInString;
    
    //clear the ImageView
    self.profileImageView.image = nil;
    
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
    currentAccount.profileImagePath = [NSString stringWithFormat: @"%@.jpg", currentAccount.iD];
    currentAccount.profileImage = self.profileImageView.image;
    
    BOOL result = [currentAccount updateAllAccountInformation];
    
    if(result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Failed to update" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

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
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Not Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    self.qrImageView.hidden = YES;
    

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
    currentAccount.profileImagePath = [NSString stringWithFormat: @"%@.jpg", currentAccount.iD];
    currentAccount.profileImage = self.profileImageView.image;
    
    BOOL result = [currentAccount saveAllAccountInformation];
    
    if(result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Failed to Register" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
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
    //whenever alert view's buttons are clicked, this function is called. for now I just disabled 'otherbutton' for the alert views that don't need to come into this if statement, but in the future I might need to make booleans to make sure.
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

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField
{
    
    
    //textFieldRect.size.height += 0.5;
    /*CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =  midline - viewRect.origin.y  - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }*/
    
    //reseting the view and the keyboard
    
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y  = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    //begining to calculate the animation
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat textFieldBottomLine = textFieldRect.origin.y + (textFieldRect.size.height + 10);
    CGFloat keyboardBttomLine = viewRect.size.height - PORTRAIT_KEYBOARD_HEIGHT;
    
    
    if (textFieldBottomLine >= keyboardBttomLine) {
        
        animatedDistance = textFieldBottomLine - keyboardBttomLine;
        
    } else {
        animatedDistance = 0;
    }
    
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];

    self.justTappedTextField = textField.copy;
    return YES;

}

- (BOOL) textFieldShouldEndEditing:(UITextField*)textField
{
    
    if ([textField.copy isEqual:self.justTappedTextField]) {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
        
    }
    
    [textField setSelected:NO];
    return YES;
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
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    //[controller presentModalViewController: cameraUI animated: YES ];
    return YES;
}

#pragma mark - QR Code Generation

- (IBAction)handleGenerateButtonPressed:(id)sender {
    // Disable the UI
    //[self setUIElementsAsEnabled:NO];
    //[self.stringTextField resignFirstResponder];
    
    // Get the string
    NSString *stringToEncode = self.iDTextField.text;
    
    if([stringToEncode isEqualToString:@""])
        return;
    
    // Generate the image
    CIImage *qrCode = [self createQRForString:stringToEncode];
    
    // Convert to an UIImage
    UIImage *qrCodeImg = [self createNonInterpolatedUIImageFromCIImage:qrCode withScale:2*[[UIScreen mainScreen] scale]];
    
    
    
    UIImage* mergedImage = [self mergeImage:_profileImageView.image withSecondImage:qrCodeImg];
    
    
    [self sendEmailWithImage:mergedImage];
    // And push the image on to the screen
    //self.qrImageView.image = mergedImage;
    //self.qrImageView.hidden = NO;
    
    // Re-enable the UI
    //[self setUIElementsAsEnabled:YES];
}


- (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // Send the image back
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale
{
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}

- (UIImage*) mergeImage:(UIImage*)firstImage withSecondImage:(UIImage*)secondImage
{
    
    if(secondImage == nil)
        return nil;
    
    CGSize imageSize = CGSizeMake(400,600);
    
    CGSize size = CGSizeMake(imageSize.width, imageSize.height);
    
    //UIGraphicsBeginImageContextWithOptions(size, self.view.alpha, 1.0);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextClearRect(contextRef, CGRectMake(0, 0, 400, 600));
    CGContextSetRGBFillColor(contextRef, 1, 1, 1, 1);
    CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 0.5);
    
    CGContextFillRect(contextRef,CGRectMake(0, 0, 400, 600));
    
    NSString *title = [NSString stringWithFormat: @"%@ : %@",self.iDTextField.text, self.nameTextField.text];
    //[title drawAtPoint:CGPointMake(10,5) withAttributes:nil];
    [title drawAtPoint:CGPointMake(10, 5)
          withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:40], NSForegroundColorAttributeName:[UIColor blackColor] }];
    
    if(firstImage)
        [firstImage drawInRect:CGRectMake(100, 50, 200, 210)];
    
    if(secondImage)
        [secondImage drawInRect:CGRectMake(30, 260, 340, 340)];
    
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return mergedImage;

}

- (UIImage*) mergeImage
{
    UIImage *firstImage = _profileImageView.image;
    UIImage *secondImage = _qrImageView.image;
    
    return [self mergeImage:firstImage withSecondImage:secondImage];
    
    
    /*
    CGSize imageSize = CGSizeMake(400,800);
    
    CGSize size = CGSizeMake(imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(size, self.view.alpha, 0.0);
    
    
    [firstImage drawInRect:CGRectMake(10, 10, 380, 380)];
    [secondImage drawInRect:CGRectMake(10, 400, 380, 380)];
    
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return mergedImage;
    //UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, framedImage.size.width,framedImage.size.height)];
    //newImageView.image = imageC;
    //newImageView.contentMode = UIViewContentModeScaleAspectFill;
     */
}

-(void)sendEmailWithImage:(UIImage*) image
{
    
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Failed to Send Email. Register Email Address at Setting." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    
    picker.mailComposeDelegate = self;
    
    NSString *subject = [NSString stringWithFormat:@"Member Card(QR Code) : %@", self.iDTextField.text];
     
    [picker setSubject:subject];
    
    // Set up recipients
     NSArray *toRecipients = [NSArray arrayWithObject:@"kwonpyo@naver.com"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
     [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    UIImage *coolImage = image;
    NSData *myData = UIImagePNGRepresentation(coolImage);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    // Fill out the email body text
    NSString *emailBody = @"";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}



#pragma mark - XML backup

-(IBAction)backDatabase:(id)sender
{
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    
    [self backupDBtoXML];
}

- (NSString *)accountFilePath:(BOOL)forSave {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:@"Accounts.xml"];
    if (forSave ||
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"Accounts" ofType:@"xml"];
    }
    
}

- (NSString *)attendanceFilePath:(BOOL)forSave {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:@"Attencances.xml"];
    if (forSave ||
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"Attendances" ofType:@"xml"];
    }
    
}

/*
-(BOOL) restoreDBfromXML
{
    {
        NSString *filePath = [self accountFilePath:FALSE];
        NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                               options:0 error:&error];
        if (doc == nil) { return NO; }
        
        NSLog(@"%@", doc.rootElement);
        
        Party *party = [[[Party alloc] init] autorelease];
        NSArray *partyMembers = [doc.rootElement elementsForName:@"Player"];
        for (GDataXMLElement *partyMember in partyMembers) {
            
            // Let's fill these in!
            NSString *name;
            int level;
            RPGClass rpgClass;
            
            // Name
            NSArray *names = [partyMember elementsForName:@"Name"];
            if (names.count > 0) {
                GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
                name = firstName.stringValue;
            } else continue;
        }
    }
}
*/
- (void)backupDBtoXML
{
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    NSMutableArray *idArray = [[NSMutableArray alloc] init];
    
    
    //Save XML for Account Entity
    {
        NSArray *accountArray = [Account bringAllAccount];
        
        

        
        int numofaccount = [accountArray count];
        
        GDataXMLElement * accountArrayElement = [GDataXMLNode elementWithName:@"Accounts"];
        
        for(int a=0; a<numofaccount; a++) {
            
            //Load from Core Data
            NSManagedObject *anAccount = [accountArray objectAtIndex:a];
            
            NSString *ID = [anAccount valueForKey:@"iD"];
            NSString *name = [anAccount valueForKey:@"name"];
            NSString *phone = [anAccount valueForKey:@"phone"];
            NSString *address = [anAccount valueForKey:@"address"];
            NSString *email = [anAccount valueForKey:@"email"];
            NSString *registerationDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"registerationDate"]];
            NSString *dateOfBirthNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"dateOfBirth"]];
            NSString *recentTestDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"recentTestDate"]];
            NSString *payDateNSString = [Account convertedNSStringFromNSDate:[anAccount valueForKey:@"payDate"]];
            
            NSString *profileImagePath = [anAccount valueForKey:@"profileImagePath"];
            
            
            //Make XML
            GDataXMLElement * accountElement = [GDataXMLNode elementWithName:@"Account"];
            
            GDataXMLElement * idElement = [GDataXMLNode elementWithName:@"ID" stringValue:ID];
            GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"name" stringValue:name];
            GDataXMLElement * phoneElement = [GDataXMLNode elementWithName:@"phone" stringValue:phone];
            GDataXMLElement * addressElement = [GDataXMLNode elementWithName:@"address" stringValue:address];
            GDataXMLElement * emailElement = [GDataXMLNode elementWithName:@"email" stringValue:email];
            GDataXMLElement * registerationDateElement = [GDataXMLNode elementWithName:@"registerationDate" stringValue:registerationDateNSString];
            GDataXMLElement * dateOfBirthElement = [GDataXMLNode elementWithName:@"dateOfBirth" stringValue:dateOfBirthNSString];
            GDataXMLElement * recentTestDateElement = [GDataXMLNode elementWithName:@"recentTestDate" stringValue:recentTestDateNSString];
            GDataXMLElement * payDateElement = [GDataXMLNode elementWithName:@"payDate" stringValue:payDateNSString];
            GDataXMLElement * profileImagePathElement = [GDataXMLNode elementWithName:@"profileImagePath" stringValue:profileImagePath];
            
            //Make One Account
            [accountElement addChild:idElement];
            [accountElement addChild:nameElement];
            [accountElement addChild:phoneElement];
            [accountElement addChild:addressElement];
            [accountElement addChild:emailElement];
            [accountElement addChild:registerationDateElement];
            [accountElement addChild:dateOfBirthElement];
            [accountElement addChild:recentTestDateElement];
            [accountElement addChild:payDateElement];
            [accountElement addChild:profileImagePathElement];
            
            //Add one Accout to Array
            [accountArrayElement addChild:accountElement];
            
            [imageArray addObject:profileImagePath];
            
            [idArray addObject:ID];
            
        }
        
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:accountArrayElement] ;
        NSData *xmlData = document.XMLData;
        
        NSString *filePath = [self accountFilePath:TRUE];
        //NSLog(@"Saving xml account to %@...", filePath);
        [xmlData writeToFile:filePath atomically:YES];
        
        NSString *xmlString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", xmlString);
    }

    //Save XML for Attendance
    {
        NSArray *attendanceArray = [Attendance bringAllAttendance];
        
        
        int numofattendance = [attendanceArray count];
        
        GDataXMLElement * attencanceArrayElement = [GDataXMLNode elementWithName:@"Attendances"];
        
        for(int a=0; a<numofattendance; a++) {
            
            NSManagedObject *anAttendance = [attendanceArray objectAtIndex:a];
            
            NSString *ID = [anAttendance valueForKey:@"iD"];
            //NSDate *eachDate = [anAttendance valueForKey:@"date"];
            NSString *eachDate = [Account convertedNSStringFromNSDate:[anAttendance valueForKey:@"date"]];
            NSString *eachTime = [anAttendance valueForKey:@"time"];
            
            
            GDataXMLElement * attendanceElement = [GDataXMLNode elementWithName:@"Attendance"];
            
            GDataXMLElement * idElement = [GDataXMLNode elementWithName:@"ID" stringValue:ID];
            GDataXMLElement * dateElement = [GDataXMLNode elementWithName:@"date" stringValue:eachDate];
            GDataXMLElement * timeElement = [GDataXMLNode elementWithName:@"time" stringValue:eachTime];
            
            [attendanceElement addChild:idElement];
            [attendanceElement addChild:dateElement];
            [attendanceElement addChild:timeElement];
            
            [attencanceArrayElement addChild:attendanceElement];
        }
        
        
        GDataXMLDocument *document2 = [[GDataXMLDocument alloc] initWithRootElement:attencanceArrayElement] ;
        NSData *xmlData2 = document2.XMLData;
        
        NSString *filePath2 = [self attendanceFilePath:TRUE];
        //NSLog(@"Saving xml attencance to %@...", filePath2);
        [xmlData2 writeToFile:filePath2 atomically:YES];
        
        NSString *xmlString2 = [[NSString alloc] initWithData:xmlData2 encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", xmlString2);
    }
    
    
    
    
    //[self sendEmailWithBackupFile:[self accountFilePath:NO] withAttendanceFile:[self attendanceFilePath:NO] ];
    
    
    [self sendToDropboxWithBackupFile:[self accountFilePath:NO] withAttendanceFile:[self attendanceFilePath:NO] ];
    
    [self sendToDropboxWithImages:imageArray]; // withIDArray:idArray];

}

-(void)sendEmailWithBackupFile: (NSString*)accountFilePath withAttendanceFile:(NSString*)attendanceFilePath
{
    
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Failed to Send Email. Register Email Address at Setting." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    
    picker.mailComposeDelegate = self;
    
    //NSString *subject = [NSString stringWithFormat:@"Member Card(QR Code) : %@", self.iDTextField.text];
    NSString *subject = [NSString stringWithFormat:@"Database Backup"];
    [picker setSubject:subject];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"kwonpyo@naver.com"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //UIImage *coolImage = image;
    //NSData *myData = UIImagePNGRepresentation(coolImage);
    //[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    NSData *xmlData = [NSData dataWithContentsOfFile: accountFilePath ];
    [picker addAttachmentData:xmlData mimeType:@"text/plain" fileName:@"Accounts.xml"];
    
    NSData *xmlData2 = [NSData dataWithContentsOfFile: attendanceFilePath ];
    [picker addAttachmentData:xmlData2 mimeType:@"text/plain" fileName:@"Attendances.xml"];
    
    // Fill out the email body text
    NSString *emailBody = @"";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}


-(void)sendToDropboxWithBackupFile: (NSString*)accountFilePath withAttendanceFile:(NSString*)attendanceFilePath
{
    {
        // Write a file to the local documents directory
        //NSString *text = @"Hello world.";
        NSString *filename = @"Accounts.xml";
        //NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *localPath = accountFilePath; //[localDir stringByAppendingPathComponent:filename];
        //[text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        // Upload file to Dropbox
        NSString *destDir = @"/";
        [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:localPath];
    }
    
    {
        // Write a file to the local documents directory
        //NSString *text = @"Hello world.";
        NSString *filename = @"Attendances.xml";
        //NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *localPath = attendanceFilePath; //[localDir stringByAppendingPathComponent:filename];
        //[text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        // Upload file to Dropbox
        NSString *destDir = @"/";
        [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:localPath];
    }
}

-(void)sendToDropboxWithImages:(NSArray*)imageArray //withIDArray:(NSArray*)idArray
{
    
    for(int i=0; i< [imageArray count]; i++) {
 //   for (NSString *imageprofilepath in imageArray) {
    
        NSString *imageprofilepath = [imageArray objectAtIndex:i];
        //NSString *ID = [idArray objectAtIndex:i];
        
        //NSString  *imageLocalPath = [NSHomeDirectory() stringByAppendingPathComponent:imageprofilepath];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageLocalPath = [documentsDirectory
                               stringByAppendingPathComponent:imageprofilepath];

        
        
        NSString *filename = imageprofilepath; //[NSString stringWithFormat:@"%@.jpg", ID ]; //imageprofilepath;
        
        // Upload file to Dropbox
        NSString *destDir = @"/";
        [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:imageLocalPath];
    }
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed with error: %@", error);
}

@end


