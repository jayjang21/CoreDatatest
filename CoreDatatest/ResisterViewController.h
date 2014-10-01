//
//  ResisterViewController.h
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 22..
//  Copyright (c) 2014년 Private. All rights reserved.
//
//Need to find out how to display the UIPickerview

#import <UIKit/UIKit.h>
#import "Account.h"
#import "Attendance.h"
#import "DDProgressView.h" //dsjang2

//#define isIOS7 floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1
//#define isIOS8 floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1

@interface ResisterViewController : UIViewController  <UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UITextFieldDelegate>

{
    UIPopoverController *popoverController;
    
    //DDProgressView *progressView ; //dsjang2
    
    //int numberOfImagesToSend;
    //int numberOfSentImage;
    
    UIImage *originalTakenImage;
    UIImage *faceTakenImage;

}
//@property (weak, nonatomic) IBOutlet UIView *datePickingContainerView;
//@property (weak, nonatomic) IBOutlet UILabel *datePickingResultLabel;

@property (nonatomic, strong) UIPopoverController *popoverController;



@property (weak, nonatomic) IBOutlet UIDatePicker *datePickingDatePicker;

@property (weak, nonatomic) IBOutlet UITextField *iDTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerationDateButton;
@property (weak, nonatomic) IBOutlet UIButton *payDateButton;
@property (weak, nonatomic) IBOutlet UIButton *dateOfBirthButton;
@property (weak, nonatomic) IBOutlet UIButton *recentTestDateButton;

@property (weak, nonatomic) IBOutlet UILabel *registerationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *payDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *recentTestDateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;// do we need this?


- (IBAction)nextButtomTapped:(id)sender;
- (IBAction)prevButtomTapped:(id)sender;


- (IBAction)registerationDateButtonTapped:(id)sender;
- (IBAction)payDateButtonTapped:(id)sender;
- (IBAction)dateOfBirthButtonTapped:(id)sender;
- (IBAction)recentTestDateButtonTapped:(id)sender;


- (IBAction)resetAllInputs:(id)sender;
- (IBAction)updateAccount:(id)sender;
- (IBAction)findAcocuntWithID:(id)sender;
- (IBAction)registerAccount:(id)sender;
//- (IBAction)returnToMainView:(id)sender;


- (IBAction)generateQRCodeBtn:(id)sender;

-(IBAction)textFieldReturn:(id)sender;

//-(IBAction)backDatabase:(id)sender;

+ (UIImage *)resizeProfileImage:(UIImage *)image;
+ (UIImage *)resizeImage:(UIImage *)image withWidth:(float)targetwidth;
+ (UIImage *)resizeImage:(UIImage *)image withWidth:(float)targetwidth withHeight:(float)targetheight;
+ (UIImage *)resizeWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
