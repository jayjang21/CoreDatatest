//
//  AttendanceViewController.h
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 10..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SCShapeView.h"
#import "Account.h"
#import "Attendance.h"

@interface AttendanceViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL isReading;
}

@property (weak, nonatomic) IBOutlet UIImageView *qRCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *qRCodeInformationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopReadingButton;


- (IBAction)startStopReadingButtonPressed:(id)sender;

@end
