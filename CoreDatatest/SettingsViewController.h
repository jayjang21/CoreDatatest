//
//  SettingsViewController.h
//  CoreDatatest
//
//  Created by Daesik Jang on 2014-09-22.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "Attendance.h"
#import "DDProgressView.h" //dsjang2

@interface SettingsViewController : UIViewController
{
    DDProgressView *progressView ; //dsjang2
    
    int numberOfImagesToSend;
    int numberOfSentImage;
    
    BOOL _isBackupDropbox;
    
}
@end
