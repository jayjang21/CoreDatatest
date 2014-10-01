//
//  ResisterViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 22..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "ResisterViewController.h"
#import "AttendanceHistorySearchViewController.h"

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



@interface ResisterViewController () //<MFMailComposeViewControllerDelegate, DBRestClientDelegate>


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

//@property (nonatomic, strong) DBRestClient *restClient;

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
    
    //self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    //self.restClient.delegate = self;
    
    //numberOfImagesToSend = 0;
    //numberOfSentImage = 0;
    
    
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

#pragma mark - DB IBActions

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



- (IBAction)nextButtomTapped:(id)sender
{

    
    // Sort first by iD, then by name.
    NSSortDescriptor *iDSort = [[NSSortDescriptor alloc] initWithKey:@"iD" ascending:YES selector:@selector(localizedStandardCompare:)];

    //request.sortDescriptors = [NSArray arrayWithObject:idSort];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(iD > %@)", self.iDTextField.text ];
    //[request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
    //NSManagedObject *theEntity = nil;

    [self switchAccountWithIDSort:iDSort AndCurrentID:self.iDTextField.text];
    //[self switchAccountWithIDSort:iDSort AndPredicate:pred];
    
    
}

- (IBAction)prevButtomTapped:(id)sender
{
    // Sort first by iD, then by name.
    NSSortDescriptor *iDSort = [[NSSortDescriptor alloc] initWithKey:@"iD" ascending:NO selector:@selector(localizedStandardCompare:)];
    
    //request.sortDescriptors = [NSArray arrayWithObject:idSort];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(iD < %@)", self.iDTextField.text];
    //[request setPredicate:[NSPredicate predicateWithFormat:@"(iD = %@)", self.iD]];
    //NSManagedObject *theEntity = nil;
    
    [self switchAccountWithIDSort:iDSort AndCurrentID:self.iDTextField.text];
    //[self switchAccountWithIDSort:iDSort AndPredicate:pred];
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

#pragma mark - DB Processing

- (void)switchAccountWithIDSort: (NSSortDescriptor *) iDSort AndCurrentID:(NSString*)currentID
{
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    
    
    request.sortDescriptors = [NSArray arrayWithObject:iDSort];
    //request.sortDescriptors = [NSArray arrayWithObject:idSort];
    //[request setPredicate:pred];
    //NSManagedObject *theEntity = nil;
    
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request
                                                     error:&error]; //only possible in NSArray?
    

    
    NSManagedObject *nextEntity = nil;
    
    if([currentID isEqualToString:@""]) {
        nextEntity = [chosenEntities firstObject];
    }
    else {
        int foundidx = -1;
        //for(NSManagedObject *theEntity in chosenEntities)
        for(int e=0; e< [chosenEntities count]; e++)
        {
            NSManagedObject *theEntity = [chosenEntities objectAtIndex:e];
            NSString *ID = [theEntity valueForKey:@"iD"];
            if([ID isEqualToString:currentID]){
                foundidx = e;
                break;
            }
        }
        
        
        if(foundidx >=0) {
            int nextidx = foundidx + 1;
            
            if(nextidx < [chosenEntities count]) {
                nextEntity = [chosenEntities objectAtIndex:nextidx];
            }
        }
    }
    
    NSManagedObject *theEntity = nextEntity; //[chosenEntities firstObject];
    
    if (theEntity) {
        
        self.iDTextField.text = [theEntity valueForKey:@"iD"];
        self.nameTextField.text = [theEntity valueForKey:@"name"];
        self.phoneTextField.text = [theEntity valueForKey:@"phone"];
        self.addressTextField.text = [theEntity valueForKey:@"address"];
        self.emailTextField.text = [theEntity valueForKey:@"email"];
        self.registerationDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"registerationDate"]];
        self.dateOfBirthLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"dateOfBirth"]];
        self.recentTestDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"recentTestDate"]];
        self.payDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"payDate"]];
        
        NSString *profileImagePath = [theEntity valueForKey:@"profileImagePath"];
        
        self.profileImageView.image = [Account ProfileImageWithProfileImagePath:profileImagePath];
        
    }
    else {
        NSLog(@"no more available next ID!");
    }

}
- (void)switchAccountWithIDSort: (NSSortDescriptor *) iDSort AndPredicate: (NSPredicate *) pred
{
    CoreDatatestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:context]];
    

    request.sortDescriptors = [NSArray arrayWithObject:iDSort];
    //request.sortDescriptors = [NSArray arrayWithObject:idSort];
    [request setPredicate:pred];
    //NSManagedObject *theEntity = nil;
    
    
    NSError *error;
    NSArray *chosenEntities = [context executeFetchRequest:request
                                                     error:&error]; //only possible in NSArray?
    
    NSManagedObject *theEntity = [chosenEntities firstObject];

    if (theEntity) {
        
        self.iDTextField.text = [theEntity valueForKey:@"iD"];
        self.nameTextField.text = [theEntity valueForKey:@"name"];
        self.phoneTextField.text = [theEntity valueForKey:@"phone"];
        self.addressTextField.text = [theEntity valueForKey:@"address"];
        self.emailTextField.text = [theEntity valueForKey:@"email"];
        self.registerationDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"registerationDate"]];
        self.dateOfBirthLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"dateOfBirth"]];
        self.recentTestDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"recentTestDate"]];
        self.payDateLabel.text = [Account convertedNSStringFromNSDate:[theEntity valueForKey:@"payDate"]];
        
        NSString *profileImagePath = [theEntity valueForKey:@"profileImagePath"];
        
        self.profileImageView.image = [Account ProfileImageWithProfileImagePath:profileImagePath];
        
    }
    else {
        NSLog(@"no more available next ID!");
    }
}

#pragma mark - UX Delegate

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
        
        //[self.profileImageView setImage: [self processProfileImage:image] ]; //dsjang2
        //[self.profileImageView setImage: image];
        //[photoImageView setImage:photoImage];
        //[self showViewController:nil];
    }
    else {
        //[picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:^{
            
            //[self.profileImageView setImage: [self processProfileImage:image] ]; //dsjang2
            //[self.profileImageView setImage:image];
            //[photoImageView setImage:photoImage];
            //[self showViewController:nil];
        }];
    }
    
    UIImage *faceImage = [self processProfileImage:image];
    
    if(faceImage) {
        originalTakenImage = image;
        faceTakenImage = faceImage;
        
        //UIImage *smallface = [self resizeWithImage:faceImage scaledToSize:CGSizeMake(faceImage.size.width/2, faceImage.size.height/2)];
        UIImage *smallface = [ResisterViewController resizeImage:faceImage withWidth:200.0f withHeight:200.0f];
        UIImageView *faceImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, smallface.size.width, smallface.size.height)];
        [faceImageView setImage:smallface];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want the face image?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert setValue:faceImageView forKey:@"accessoryView"];
        //[alert inputAccessoryView:faceImageView];
        
        [alert setTag:10];
        [alert show];
    }
    else {
        [self.profileImageView setImage:image];
    }

}

- (void) datePickingShowAlertView
{
    bool bUseAlertController = false;
    Class klass = NSClassFromString(@"UIAlertController");
    
    //if ([UIAlertController class]) {
    if(klass) {
        bUseAlertController = true;
    }
    
    
    // Create date picker (could / should be an ivar)
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 30, 260, 260)];
    //UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, alert.bounds.size.height, 260, 260)];
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
    
    /*
    PickerAlertView *pickerAlertView = [[PickerAlertView alloc] initWithTitle:@" " message:@" " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

    
    //[pickerAlertView setFrame:CGRectMake(0,0, 300, 300)];
    
    pickerAlertView.datePickerView.datePickerMode = UIDatePickerModeDate;
    
    
    if (self.registerationDateLabel.text == nil  || self.payDateLabel.text == nil|| self.dateOfBirthLabel.text ==nil || self.recentTestDateLabel.text == nil) {
        
        pickerAlertView.datePickerView.date = [Account convertedNSDateFromDateString:self.currentDateInString];
        
    }
    else {
        if ([self.datePickingDateKind isEqualToString:@"Registeration Date"]) {
            pickerAlertView.datePickerView.date = [Account convertedNSDateFromDateString: self.registerationDateLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Pay Date"]) {
            pickerAlertView.datePickerView.date = [Account convertedNSDateFromDateString: self.payDateLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Date Of Birth"]) {
            pickerAlertView.datePickerView.date = [Account convertedNSDateFromDateString: self.dateOfBirthLabel.text];
        }
        else if ([self.datePickingDateKind isEqualToString:@"Recent Test Date"]) {
            pickerAlertView.datePickerView.date = [Account convertedNSDateFromDateString: self.recentTestDateLabel.text];
        }
    }
    
    
    [pickerAlertView show];
    
    
    return;
     */

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    //if(bUseAlertController)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Date" message:@"\r\r\r\r\r\r\r\r\r\r\r" preferredStyle:UIAlertControllerStyleAlert] ;//]  UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //  [action doSomething];
                                                                  
                                                                  for(int s=0; s<[alert.view.subviews count]; s++) {
                                                                      if([[alert.view.subviews objectAtIndex:s] isKindOfClass:[UIDatePicker class]]) {
                                                                          [self updateDateFromDatePicker:[alert.view.subviews objectAtIndex:s]];
                                                                      }
                                                                  }
                                                              }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancel];
        //[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //    textField.placeholder = @"Your username here";
        //}];
        //[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //    textField.placeholder = @"Your Email here";
        //}];
        
        //[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //    textField.placeholder = @"Your Password here";
        //}];
        
        [alert.view addSubview:picker];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
#else
    
    //else
    {
        // Create alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        // Show alert (required for sizes to be available)
        
        // Add picker to alert
        //alert.alertViewStyle = UIAlertViewStyleDefault;
        //[alert addSubview:picker];
        
        //[alert addSubview:picker];
        [alert setValue:picker forKey:@"accessoryView"];
        // Adjust the alerts bounds
        //alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
        //alert.frame = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
        
        [alert show];
    }
    
#endif

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

    if(alertView.tag == 10)
    {
        if(buttonIndex == 1) {
            [self.profileImageView setImage:faceTakenImage];
        }
        else {
            [self.profileImageView setImage:originalTakenImage];
        }
    }
    else {
        if(buttonIndex == 1) {

            UIDatePicker *picker = [alertView valueForKey:@"accessoryView"];
            
            [self updateDateFromDatePicker:picker];
            
            
        }
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
    
    //CGFloat textFieldBottomLine = textFieldRect.origin.y + (textFieldRect.size.height + 10);
    CGFloat textFieldBottomLine = 869;
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

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}


#pragma mark - QR Code Generation

- (IBAction)generateQRCodeBtn:(id)sender {
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
          withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20], NSForegroundColorAttributeName:[UIColor blackColor] }];
    
    if(firstImage)
        [firstImage drawInRect:CGRectMake(30, 50, 340, 340)];// 100, 50, 200, 210)];
    
    if(secondImage)
        [secondImage drawInRect:CGRectMake(100, 390, 200, 200)]; //30, 260, 340, 340)];
    
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



/*
#pragma mark - XML backup


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
                               stringByAppendingPathComponent:@"Attendances.xml"];
    if (forSave ||
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"Attendances" ofType:@"xml"];
    }
    
}


-(IBAction)backDatabase:(id)sender
{
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    else
        [self backupDBtoXML];
}


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


#pragma mark - XML backup - Dropbox

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
    
    //Prepare Temporary Files Names
    NSMutableArray *validFileNameArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempFileNameArray = [[NSMutableArray alloc] init];
    for(int i=0; i< [imageArray count]; i++) {
        //   for (NSString *imageprofilepath in imageArray) {
        
        NSString *originalImageFileName = [imageArray objectAtIndex:i];
        
        NSString *profileImageName = [originalImageFileName lastPathComponent];
        //NSString *ID = [idArray objectAtIndex:i];
        
        //NSString  *imageLocalPath = [NSHomeDirectory() stringByAppendingPathComponent:imageprofilepath];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageLocalPath = [documentsDirectory
                                    stringByAppendingPathComponent:profileImageName];
        
        
        //Make Temp Path
        NSString *purefilename = [[profileImageName lastPathComponent] stringByDeletingPathExtension];
        NSString *tempFileNmae = [NSString stringWithFormat:@"%@-2%@", purefilename, @".jpg" ];
        NSString *tempLocalPath = [documentsDirectory
                                    stringByAppendingPathComponent:tempFileNmae];
        
        
        
        //NSString *filename = imageprofilepath; //[NSString stringWithFormat:@"%@.jpg", ID ]; //imageprofilepath;
        
        //resize image if > 500
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:imageLocalPath]) {
            imageLocalPath = [NSHomeDirectory() stringByAppendingPathComponent:profileImageName];
        }

        UIImage *profileImage =  [UIImage imageWithContentsOfFile:imageLocalPath]; //  [Account ProfileImageWithProfileImagePath:imageLocalPath];
        if(profileImage) {
            
            UIImage *resizedImage = [ResisterViewController resizeProfileImage:profileImage];
            
            //CGSize orgsize = profileImage.size;
            //float targetwidth = 500.0f;
            //float ratio = (float)targetwidth / (float)orgsize.width;
            //float targetheight = orgsize.height * ratio;
            //CGSize targetsize = CGSizeMake(targetwidth, targetheight);
            //UIImage *resizedImage = [self resizeWithImage:profileImage scaledToSize:targetsize];
            //NSString *tempLocalPath = [documentsDirectory
            //                           stringByAppendingPathComponent:@"temp.jpg"];
            
            if(resizedImage) {
                [Account saveProfileImage:resizedImage withPath:tempLocalPath];
                
                
                NSLog(@"%@", tempLocalPath);
                [tempFileNameArray addObject:tempFileNmae];
                
                [validFileNameArray addObject:profileImageName];
            }
        }
    }
    
    numberOfSentImage = 0;
    numberOfImagesToSend = [validFileNameArray count];
    [self showProgressView];
    
    //Send Temp Files
    for(int i=0; i< [validFileNameArray count]; i++) {
        //   for (NSString *imageprofilepath in imageArray) {
        
        NSString *imagefilename = [tempFileNameArray objectAtIndex:i]; //[imageArray objectAtIndex:i];
        //NSString *ID = [idArray objectAtIndex:i];
        
        //NSString  *imageLocalPath = [NSHomeDirectory() stringByAppendingPathComponent:imageprofilepath];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageLocalPath = [documentsDirectory
                                    stringByAppendingPathComponent:imagefilename];
        
        
        NSString *filename = [validFileNameArray objectAtIndex:i];
        //NSString *filename = imageprofilepath; //[NSString stringWithFormat:@"%@.jpg", ID ]; //imageprofilepath;
        
        
        
        //UIImage *resizedImage = [self resizeProfileImage:profileImage];
        //resize image if > 500
        //UIImage *profileImage = [Account ProfileImageWithProfileImagePath:imageLocalPath];
        //CGSize orgsize = profileImage.size;
        //float targetwidth = 500.0f;
        //float ratio = (float)targetwidth / (float)orgsize.width;
        //float targetheight = orgsize.height * ratio;
        //CGSize targetsize = CGSizeMake(targetwidth, targetheight);
        //UIImage *resizedImage = [self resizeWithImage:profileImage scaledToSize:targetsize];
        //NSString *tempLocalPath = [documentsDirectory
        //                            stringByAppendingPathComponent:@"temp.jpg"];
         
        //[Account saveProfileImage:resizedImage withPath:tempLocalPath];
        
        // Upload file to Dropbox
        NSString *destDir = @"/";
        [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:imageLocalPath] ; //]imageLocalPath];
    }
}


-(BOOL) restoreDBfromXMLAccount
{
    BOOL result = NO;
    {
        NSString *filePath = [self accountFilePath:FALSE];
        NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                               options:0 error:&error];
        if (doc == nil) { return NO; }
        
        //NSLog(@"%@", doc.rootElement);
        
        NSArray *accountArray = [doc.rootElement elementsForName:@"Account"];
        for (GDataXMLElement *anAccount in accountArray) {
            
            // Let's fill these in!
            NSString *ID;
            NSArray *ids = [anAccount elementsForName:@"ID"];
            if (ids.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [ids objectAtIndex:0];
                ID = Element.stringValue;
            } else continue;
            
            NSString *name;
            NSArray *names = [anAccount elementsForName:@"name"];
            if (names.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [names objectAtIndex:0];
                name = Element.stringValue;
            } else continue;
            
            NSString *phone;
            NSArray *phones = [anAccount elementsForName:@"phone"];
            if (phones.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [phones objectAtIndex:0];
                phone = Element.stringValue;
            } else continue;
            
            NSString *address;
            NSArray *addresses = [anAccount elementsForName:@"address"];
            if (addresses.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [addresses objectAtIndex:0];
                address = Element.stringValue;
            } else continue;
            
            
            NSString *email;
            NSArray *emails = [anAccount elementsForName:@"email"];
            if (emails.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [emails objectAtIndex:0];
                email = Element.stringValue;
            } else continue;
            
            NSString *registerationDateNSString;
            NSArray *registerationDates = [anAccount elementsForName:@"registerationDate"];
            if (registerationDates.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [registerationDates objectAtIndex:0];
                registerationDateNSString = Element.stringValue;
            } else continue;
            
            NSString *dateOfBirthNSString;
            NSArray *dateOfBirths = [anAccount elementsForName:@"dateOfBirth"];
            if (dateOfBirths.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [dateOfBirths objectAtIndex:0];
                dateOfBirthNSString = Element.stringValue;
            } else continue;
            
            NSString *recentTestDateNSString;
            NSArray *recentTestDates = [anAccount elementsForName:@"recentTestDate"];
            if (recentTestDates.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [recentTestDates objectAtIndex:0];
                recentTestDateNSString = Element.stringValue;
            } else continue;
            
            NSString *payDateNSString;
            NSArray *payDates = [anAccount elementsForName:@"payDate"];
            if (payDates.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [payDates objectAtIndex:0];
                payDateNSString = Element.stringValue;
            } else continue;
            
            NSString *profileImagePath;
            NSArray *profileImagePaths = [anAccount elementsForName:@"profileImagePath"];
            if (profileImagePaths.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [profileImagePaths objectAtIndex:0];
                profileImagePath = Element.stringValue;
            } else continue;
            
            
            
            ///NSLog(@"%@ - %@", ID, name);
            //continue;
            
            Account *currentAccount = [[Account alloc] init];
            
            currentAccount.iD = ID;
            currentAccount.name = name;
            currentAccount.phone = phone;
            currentAccount.address = address;
            currentAccount.email = email;
            currentAccount.registerationDateNSString = registerationDateNSString;
            currentAccount.dateOfBirthNSString = dateOfBirthNSString;
            currentAccount.recentTestDateNSString = recentTestDateNSString;
            currentAccount.payDateNSString = payDateNSString;
            currentAccount.profileImagePath = [profileImagePath lastPathComponent];
            //currentAccount.profileImage = self.profileImageView.image;
            
            result = [currentAccount saveAllAccountInformation];
            
        }//for account
        
    }
    
    
    
    return result;
}

-(BOOL) restoreDBfromXMLAttendance
{
    BOOL result = NO;
    {
        NSString *filePath = [self attendanceFilePath:FALSE];
        NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                               options:0 error:&error];
        if (doc == nil) { return NO; }
        
        //NSLog(@"%@", doc.rootElement);
        
        NSArray *accountArray = [doc.rootElement elementsForName:@"Attendance"];
        for (GDataXMLElement *anAccount in accountArray) {
            
            // Let's fill these in!
            NSString *ID;
            NSArray *ids = [anAccount elementsForName:@"ID"];
            if (ids.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [ids objectAtIndex:0];
                ID = Element.stringValue;
            } else continue;
            
            NSString *date;
            NSArray *dates = [anAccount elementsForName:@"date"];
            if (dates.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [dates objectAtIndex:0];
                date = Element.stringValue;
            } else continue;
            
            
            NSString *time;
            NSArray *times = [anAccount elementsForName:@"time"];
            if (times.count > 0) {
                GDataXMLElement *Element = (GDataXMLElement *) [times objectAtIndex:0];
                time = Element.stringValue;
            } else continue;
            
            //NSLog(@"%@ - %@ - %@", ID, date, time);
            //continue;
            
            Attendance *currentAttendance = [[Attendance alloc] init];
            
            currentAttendance.iD = ID;
            currentAttendance.dateNSString = date;
            currentAttendance.time = time;
            
            result = [currentAttendance saveAttendanceInformation];
            
        }
    }
    
    return result;
}


-(IBAction)restoreDatabase:(id)sender
{
    [self downloadFromDropboxWithBackupFile];
    
    [self downloadFromDropboxWithImages];
    
    //[self restoreDBfromXML];
    
}

-(void)downloadFromDropboxWithBackupFile
{
    
    {
        NSString* accountLocalFilePath = [self accountFilePath:TRUE];
        NSString *filename = @"/Accounts.xml";
        
        //NSString *destDir = @"/";
        [self.restClient loadFile:filename intoPath:accountLocalFilePath];
        
        
    }
    
    {
        NSString* attendanceLocalFilePath = [self attendanceFilePath:TRUE];
        NSString *filename = @"/Attendances.xml";
        
        //NSString *destDir = @"/";
        [self.restClient loadFile:filename intoPath:attendanceLocalFilePath];
    }
    
    //(NSString*)attendanceLocalFilePath = [self attendanceFilePath:TRUE];
    
    
}

-(void)downloadFromDropboxWithImages
{
    NSString *photosRoot = @"/";
    [self.restClient loadMetadata:photosRoot];
}

#pragma mark - XML backup - Dropbox Delegate


- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    
    
    NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    NSString* extension = [[srcPath pathExtension] lowercaseString];
    
    //If image
    if ([validExtensions indexOfObject:extension] != NSNotFound) {
        
        numberOfSentImage++;
        if(numberOfImagesToSend > 0) {
            float sentratio = (float)numberOfSentImage / (float)numberOfImagesToSend;
            
            [progressView setProgress:sentratio];
        }
        
        if(numberOfSentImage == numberOfImagesToSend) {
            [self hideProgressView];
        }
    }
    
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed with error: %@", error);
}


//When Files were downloaded
- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    NSLog(@"File loaded into path: %@", localPath);
    
    NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    NSString* extension = [[localPath pathExtension] lowercaseString];
    
    //If not image
    if ([validExtensions indexOfObject:extension] == NSNotFound) {
        NSData *xmlData = [NSData dataWithContentsOfFile: localPath ];
        NSString *xmlString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", xmlString);
        
        if([[[localPath lastPathComponent] stringByDeletingPathExtension] isEqualToString:@"Accounts"]) {
           [self restoreDBfromXMLAccount];
        }
        else if([[[localPath lastPathComponent] stringByDeletingPathExtension] isEqualToString:@"Attendances"]) {
           [self restoreDBfromXMLAttendance];
        }
    }
    else {
        
        numberOfSentImage++;
        if(numberOfImagesToSend > 0) {
            float sentratio = (float)numberOfSentImage / (float)numberOfImagesToSend;
            
            [progressView setProgress:sentratio];
        }
        
        if(numberOfSentImage == numberOfImagesToSend) {
            [self hideProgressView];
        }
    }
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error {
    NSLog(@"There was an error loading the file: %@", error);
}

//When file list downloaded
- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        
        
        //NSLog(@"Folder '%@' contains:", metadata.path);
        
        NSMutableArray* newPhotoPaths = [NSMutableArray new];
        NSMutableArray* newPhotoNames = [NSMutableArray new];
        
        //Collect Filenames and paths
        NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
        for (DBMetadata *file in metadata.contents) {
            
            NSString* extension = [[file.path pathExtension] lowercaseString];
            //If image file
            if (!file.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
                
                //NSLog(@"	%@", file.path);
                //NSLog(@"	%@", file.filename);
                
                [newPhotoPaths addObject:file.path];
                [newPhotoNames addObject:file.filename];
            }
            
        }
        
        numberOfSentImage = 0;
        numberOfImagesToSend = [newPhotoPaths count];
        [self showProgressView];
        
        for(int f=0; f< [newPhotoPaths count]; f++) {
            NSString *serverfilepath = [newPhotoPaths objectAtIndex:f];
            NSString *filename = [newPhotoNames objectAtIndex:f];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *imagePath = [documentsDirectory
                                   stringByAppendingPathComponent:filename];
            
            [self.restClient loadFile:serverfilepath intoPath:imagePath];
        }
        

    }
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
}

- (DBRestClient*)restClient {
    if (_restClient == nil) {
        _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
    }
    return _restClient;
}
*/

#pragma mark - Image Processing

- (UIImage *)processProfileImage:(UIImage*)image
{
    if(!image)
        return nil;
    
    UIImage *fixedImage = [self fixOrientation:image];
    
    
    //UIImage *faceImage = [self detectForFaces:image.CGImage orientation:image.imageOrientation];
    UIImage *faceImage = [self detectForFaces:fixedImage.CGImage orientation:fixedImage.imageOrientation];
    //
    //CGSize originalsize = fixedImage.size;
    //CGRect cropRect = CGRectMake(originalsize.width/4, 9, originalsize.width/2, originalsize.height/2);
    //UIImage *cropImage = [self cropImage:fixedImage withRect:cropRect];
    //UIImage *faceImage = [self detectForFaces:cropImage.CGImage orientation:cropImage.imageOrientation];
    
    UIImage *imageToProcess = nil;
    if(faceImage)
        imageToProcess = faceImage;
    else {

        return nil;
        //imageToProcess = fixedImage; //when no face
    }
    
    UIImage *resizedImage = [ResisterViewController resizeProfileImage:imageToProcess];

    /*
    CGSize orgsize = imageToProcess.size;
    float targetwidth = 500.0f;
    float ratio = (float)targetwidth / (float)orgsize.width;
    float targetheight = orgsize.height * ratio;
    CGSize targetsize = CGSizeMake(targetwidth, targetheight);
    
    UIImage *resizedImage = [self resizeWithImage:imageToProcess scaledToSize:targetsize];
    */
    
    return resizedImage;
    
}

+ (UIImage *)resizeProfileImage:(UIImage *)image
{
    /*
    CGSize orgsize = image.size;
    float targetwidth = 500.0f;
    float ratio = (float)targetwidth / (float)orgsize.width;
    float targetheight = orgsize.height * ratio;
    CGSize targetsize = CGSizeMake(targetwidth, targetheight);
    
    UIImage *resizedImage = [self resizeWithImage:image scaledToSize:targetsize];
    */
    UIImage *resizedImage = [self resizeImage:image withWidth:500.0f];
    return resizedImage;
}

+ (UIImage *)resizeImage:(UIImage *)image withWidth:(float)targetwidth
{
    CGSize orgsize = image.size;
    //float targetwidth = 500.0f;
    float ratio = (float)targetwidth / (float)orgsize.width;
    float targetheight = orgsize.height * ratio;
    CGSize targetsize = CGSizeMake(targetwidth, targetheight);
    
    UIImage *resizedImage = [self resizeWithImage:image scaledToSize:targetsize];
    
    return resizedImage;
}

+ (UIImage *)resizeImage:(UIImage *)image withWidth:(float)targetwidth withHeight:(float)targetheight
{
    CGSize targetsize = CGSizeMake(targetwidth, targetheight);
    
    UIImage *resizedImage = [self resizeWithImage:image scaledToSize:targetsize];
    
    return resizedImage;
}

+ (UIImage *)resizeWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    //UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    //[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    //UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();
    //return newImage;
    
    
    if (CGSizeEqualToSize(image.size, newSize))
    {
        return image;
    }
    
    if(image.size.width <= newSize.width) {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0f);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *) detectForFaces:(CGImageRef)facePicture orientation:(UIImageOrientation)orientation {
    
    
    CIImage* image = [CIImage imageWithCGImage:facePicture];
    
    CIContext *context = [CIContext contextWithOptions:nil];                    // 1
    NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh}; //, CIDetectorMinFeatureSize: @0.1 };      // 2
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:opts];                    // 3
    
    int exifOrientation;
    switch (orientation) {
        case UIImageOrientationUp:
            exifOrientation = 1;
            break;
        case UIImageOrientationDown:
            exifOrientation = 3;
            break;
        case UIImageOrientationLeft:
            exifOrientation = 8;
            break;
        case UIImageOrientationRight:
            exifOrientation = 6;
            break;
        case UIImageOrientationUpMirrored:
            exifOrientation = 2;
            break;
        case UIImageOrientationDownMirrored:
            exifOrientation = 4;
            break;
        case UIImageOrientationLeftMirrored:
            exifOrientation = 5;
            break;
        case UIImageOrientationRightMirrored:
            exifOrientation = 7;
            break;
        default:
            break;
    }
    
    
    opts = @{ CIDetectorImageOrientation :[NSNumber numberWithInt:exifOrientation
                                           ] };
    
    
    


    
    
    NSArray *features = [detector featuresInImage:image options:opts];
    
    int maxidx = -1;
    float maxarea = 0.0f;
    CGRect maxRect;
    for(int i=0; i< [features count]; i++) {
        CIFaceFeature *face = [features objectAtIndex:i];
        CGRect facerect = face.bounds;
        
        if(facerect.size.width * facerect.size.height > maxarea) {
            maxidx = i;
            maxarea = facerect.size.width * facerect.size.height;
            maxRect = facerect;
        }
    }
    
    UIImage *faceImage;
    
    if(maxidx >=0) {
        
        //UIImage *uiImage = [[UIImage alloc] initWithCIImage:image];
        
        
        
        UIImage *uiImage = [UIImage imageWithCGImage:facePicture];
        
        // CoreImage coordinate system origin is at the bottom left corner
        // and UIKit is at the top left corner. So we need to translate
        // features positions before drawing them to screen. In order to do
        // so we make an affine transform
        CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
        transform = CGAffineTransformTranslate(transform,
                                               0, -uiImage.size.height);
        
        // Get the face rect: Convert CoreImage to UIKit coordinates
        const CGRect faceRect = CGRectApplyAffineTransform(maxRect, transform);
        
        float extratio = 6.0f;
        CGRect facerect = faceRect;
        facerect.origin.x = facerect.origin.x - facerect.size.width / extratio;
        facerect.origin.y = facerect.origin.y - facerect.size.height / extratio;
        facerect.size.width = facerect.size.width + facerect.size.width * 2.0f / extratio;
        facerect.size.height = facerect.size.height + facerect.size.height * 2.0f / extratio;
        
        faceImage = [self cropImage:uiImage withRect:facerect] ; //]facerect];
        
        return faceImage;
    }
    else
        return nil;
    
    //if ([features count] > 0) {
    //    CIFaceFeature *face = [features lastObject];
    //    NSLog(@"%@", NSStringFromCGRect(face.bounds));
    //}
    
    //return features;
}

- (UIImage *)cropImage:(UIImage*)image withRect:(CGRect)rect {
    
    //CGSize orgsize = image.size;
    CGRect orgrect = CGRectMake(0, 0, image.size.width, image.size.height);
    rect = CGRectMake(rect.origin.x*image.scale,rect.origin.y*image.scale,rect.size.width*image.scale,rect.size.height*image.scale);
    
    if(rect.origin.x < 0)
        rect.origin.x = 0;
    if(rect.origin.y < 0)
        rect.origin.y = 0;
    if(rect.origin.x + rect.size.width >= orgrect.size.width) {
        rect.size.width = orgrect.size.width - rect.origin.x;
    }
    if(rect.origin.y + rect.size.height >= orgrect.size.height) {
        rect.size.height = orgrect.size.height - rect.origin.y;
    }
    /*
     CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
     UIImage *result = [UIImage imageWithCGImage:imageRef
     scale:image.scale
     orientation:image.imageOrientation];
     CGImageRelease(imageRef);
     */
    
    //UIImage *result = (__bridge UIImage *)(CGImageCreateWithImageInRect((__bridge CGImageRef)(image), rect));
    
    //CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    //UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    //CGImageRelease(imageRef);
    //CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], cropRect);
    
    //rect.size.width = 50;
    //rect.size.height = 50;
    
    //keep orientation if landscape
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    
    UIImage *newImage;
    
    if (image.size.width > image.size.height || image.size.width == image.size.height) {
        newImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:image.imageOrientation];
    }
    else
    {
        newImage = [UIImage imageWithCGImage:imageRef];
    }
    
    CGImageRelease(imageRef);
    
    
    return newImage;
}

- (UIImage *)fixOrientation : (UIImage*) image{
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    
    return img;
}
- (IBAction)showAttendance:(id)sender {
    
    //UIViewController *attendanceViewController = [self.tabBarController.viewControllers objectAtIndex:2];
    
    
    //for(UIViewController *viewController in self.tabBarController.viewControllers)
    for(int v=0; v< [self.tabBarController.viewControllers count]; v++)
    {
        UIViewController *viewController = [self.tabBarController.viewControllers objectAtIndex:v];
        if([viewController.title isEqualToString:@"AttendanceSearch"])
        //if( ![viewController isKindOfClass:[AttendanceHistorySearchViewController class]] )
        {

            if([viewController respondsToSelector:@selector(findAttendanceWithID:)]) {

                [viewController performSelector:@selector(findAttendanceWithID:) withObject:self.iDTextField.text afterDelay:0];
                
                [self.tabBarController setSelectedIndex:v];
                break;
            }
        }
    }
}

/*
#pragma mark - ProgressView

-(void)showProgressView
{
    if(!progressView) {
        progressView = [[DDProgressView alloc] initWithFrame: CGRectMake(20.0f, 60.0f, self.view.bounds.size.width-40.0f, 0.0f)] ;
        [progressView setOuterColor: [UIColor grayColor]] ;
        [progressView setInnerColor: [UIColor lightGrayColor]] ;
        progressView.alpha = 1.0;
        
        [self.view addSubview: progressView] ;
 
    }

    progressView.hidden = NO;
    //progressView.alpha = 1.0;
}

-(void)hideProgressView
{
    progressView.hidden = YES;
    //progressView.alpha = 0.0;
    [progressView setProgress:0.0];
}

-(void)setProgressView:(float)val
{
    [progressView setProgress:val];
}
*/
@end


