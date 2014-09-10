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

@interface ResisterViewController : UIViewController  <UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

{
    UIPopoverController *popoverController;

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


- (IBAction)registerationDateButtonTapped:(id)sender;
- (IBAction)payDateButtonTapped:(id)sender;
- (IBAction)dateOfBirthButtonTapped:(id)sender;
- (IBAction)recentTestDateButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;// do we need this?



- (IBAction)updateAccount:(id)sender;
- (IBAction)findAcocuntWithID:(id)sender;
- (IBAction)registerAccount:(id)sender;
//- (IBAction)returnToMainView:(id)sender;


@end