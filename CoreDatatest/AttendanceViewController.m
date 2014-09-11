//
//  AttendanceViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 10..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "AttendanceViewController.h"

@interface AttendanceViewController ()

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic)

@end

@implementation AttendanceViewController

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
    isReading = NO;
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

- (IBAction)startStopReadingButtonPressed:(id)sender
{
    if (isReading) {
        
        if ([self stopReadingQRCode]) {
        self.qRCodeInformationLabel.text = @"";
        self.currentStatusLabel.text = @"Please press 'Start Reading Button to start reading QRCode.";
        [self.startStopReadingButton setTitle:@"Start Reading!" forState:UIControlStateNormal];
        }
    } else {
        
        if ([self startReadingQRCode]) {
            self.currentStatusLabel.text = @"Your attendance has been recorded successfully!";
            [self.startStopReadingButton setTitle:@"Stop Reading!" forState:UIControlStateNormal];
        }
    }
    
}

- (BOOL) startReadingQRCode
{
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input]; //why not _captureSession = [addinput:input] or something like this
    AVCaptureMetadataOutput *captureMetaDataOutput = [[AVCaptureMetadataOutput alloc] init]; //why did we create *captureSession beforeahand as a @property but not create *captureMetaDataOutput beforehand?
    [_captureSession addOutput:captureMetaDataOutput];
    dispatch_queue_t dispatchQueue; //???
    dispatchQueue = dispatch_queue_create("myQueue", NULL); //why not @"myQueu"?
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetaDataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //[captureMetaDataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession]; //why use _ when *videoPreviewLayer is declared within .m? do you still need to synthesis even though the variable was privately declared?
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    [_captureSession startRunning];
    return YES;
    
}

- (BOOL) stopReadingQRCode
{
    return YES;
}
@end
