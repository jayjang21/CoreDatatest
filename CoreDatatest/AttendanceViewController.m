//
//  AttendanceViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 10..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "AttendanceViewController.h"
#import "SCShapeView.h"

@interface AttendanceViewController ()
{
    SCShapeView *_boundingBox;
    NSTimer *_boxHideTimer;
}

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (BOOL) startReadingQRCode;
- (BOOL) stopReadingQRCode;
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
    _captureSession = nil;
    
    isReading = NO;
    
    [self initializeQRCode];
    /*
    if([self initializeQRCode]) {
        
        // Add the view to draw the bounding box for the UIView
        _boundingBox = [[SCShapeView alloc] initWithFrame:_viewPreview.bounds];
        _boundingBox.backgroundColor = [UIColor redColor]; //[UIColor clearColor];
        _boundingBox.hidden = YES;
        [_viewPreview addSubview:_boundingBox];
    }
     */
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
            self.qRCodeInformationLabel.text = @"";
            self.currentStatusLabel.text = @"Your attendance has been recorded successfully!";
            [self.startStopReadingButton setTitle:@"Stop Reading!" forState:UIControlStateNormal];
        }
    }
    
    isReading = !isReading;
}

-(BOOL) initializeQRCode
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
    
    
    //dispatch_queue_t dispatchQueue; //???
    //dispatchQueue = dispatch_queue_create("myQueue", NULL); //why not @"myQueu"?
    //[captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [captureMetaDataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //[captureMetaDataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //Display on screen
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession]; //why use _ when *videoPreviewLayer is declared within .m? do you still need to synthesis even though the variable was privately declared?
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    _videoPreviewLayer.bounds = _viewPreview.bounds;
    _videoPreviewLayer.position = CGPointMake(CGRectGetMidX(_viewPreview.layer.bounds), CGRectGetMidY(_viewPreview.layer.bounds));

    //[_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Add the view to draw the bounding box for the UIView
    _boundingBox = [[SCShapeView alloc] initWithFrame:_viewPreview.bounds];
    _boundingBox.backgroundColor = [UIColor clearColor];
    _boundingBox.hidden = YES;
    [_viewPreview addSubview:_boundingBox];
    
    self.qRCodeInformationLabel.text = @"";

    return true;
}

- (BOOL) startReadingQRCode
{
    if(!_captureSession) {
        [self initializeQRCode];
    }
    
    if(_captureSession)
        [_captureSession startRunning];
    
    return YES;
    
}

- (BOOL) stopReadingQRCode
{
    [_captureSession stopRunning];
    //_captureSession = nil;
    
    //[_videoPreviewLayer removeFromSuperlayer];
    
    return true;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        //AVMetadataMachineReadableCodeObject
        AVMetadataObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            
            
            
            //[self performSelectorOnMainThread:@selector(stopReadingQRCode) withObject:nil waitUntilDone:NO];
            //[_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            //[_currentStatusLabel performSelectorOnMainThread:@selector(setText:) withObject: @"Please press 'Start Reading Button to start reading QRCode." waitUntilDone:NO];
            //[_startStopReadingButton performSelectorOnMainThread:@selector(setTitle:) withObject: @"Start Reading!" waitUntilDone:NO];

            //isReading = NO;
            
            // Transform the meta-data coordinates to screen coords
            AVMetadataMachineReadableCodeObject *transformed = (AVMetadataMachineReadableCodeObject *)[_videoPreviewLayer transformedMetadataObjectForMetadataObject:metadataObj];
            // Update the frame on the _boundingBox view, and show it
            _boundingBox.frame = transformed.bounds;
            
            
            //_boundingBox.frame = CGRectMake(0, 0, 200, 100);
            //NSLog(@"bounding box origin : %f, %f",_boundingBox.frame.origin.x, _boundingBox.frame.origin.y);
            //NSLog(@"bounding box size : %f, %f",_boundingBox.frame.size.width, _boundingBox.frame.size.height);
            // _boundingBox.backgroundColor = [UIColor redColor];
            _boundingBox.hidden = NO;
            // Now convert the corners array into CGPoints in the coordinate system
            //  of the bounding box itself
            NSArray *translatedCorners = [self translatePoints:transformed.corners
                                                      fromView:_viewPreview
                                                        toView:_boundingBox];
            
            //for(int a=0; a< translatedCorners.count; a++) {
            //    CGPoint *point = (__bridge CGPoint*)[translatedCorners objectAtIndex:a];
            //     NSLog(@"corner : %f, %f",point->x, point->y);
            //}
            
            // Set the corners array
            _boundingBox.corners = translatedCorners;
            
            
            [_qRCodeInformationLabel setText:[transformed stringValue] ];
            
            //[self stopReadingQRCode];
            //[_startStopReadingButton setTitle:@"Start Reading!" forState:UIControlStateNormal];
            //[_qRCodeInformationLabel performSelectorOnMainThread:@selector(setText:) withObject:[transformed stringValue] waitUntilDone:NO];

            
            
            // Start the timer which will hide the overlay
            [self startOverlayHideTimer];

            
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
}

-(void)loadBeepSound{
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}

#pragma mark - Utility Methods
- (void)startOverlayHideTimer
{
    // Cancel it if we're already running
    if(_boxHideTimer) {
        [_boxHideTimer invalidate];
    }
    
    // Restart it to hide the overlay when it fires
    _boxHideTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                     target:self
                                                   selector:@selector(removeBoundingBox:)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)removeBoundingBox:(id)sender
{
    // Hide the box and remove the decoded text
    _boundingBox.hidden = YES;
    self.qRCodeInformationLabel.text = @"";
}

- (NSArray *)translatePoints:(NSArray *)points fromView:(UIView *)fromView toView:(UIView *)toView
{
    NSMutableArray *translatedPoints = [NSMutableArray new];
    
    // The points are provided in a dictionary with keys X and Y
    for (NSDictionary *point in points) {
        // Let's turn them into CGPoints
        CGPoint pointValue = CGPointMake([point[@"X"] floatValue], [point[@"Y"] floatValue]);
        // Now translate from one view to the other
        CGPoint translatedPoint = [fromView convertPoint:pointValue toView:toView];
        // Box them up and add to the array
        [translatedPoints addObject:[NSValue valueWithCGPoint:translatedPoint]];
    }
    
    return [translatedPoints copy];
}


@end
