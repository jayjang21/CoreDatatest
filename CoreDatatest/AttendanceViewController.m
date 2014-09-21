//
//  AttendanceViewController.m
//  CoreDatatest
//
//  Created by Jay Jang on 14. 9. 10..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import "AttendanceViewController.h"

@import AVFoundation;

static NSString * BCP47LanguageCodeFromISO681LanguageCode(NSString *ISO681LanguageCode) {
    if ([ISO681LanguageCode isEqualToString:@"ar"]) {
        return @"ar-SA";
    } else if ([ISO681LanguageCode hasPrefix:@"cs"]) {
        return @"cs-CZ";
    } else if ([ISO681LanguageCode hasPrefix:@"da"]) {
        return @"da-DK";
    } else if ([ISO681LanguageCode hasPrefix:@"de"]) {
        return @"de-DE";
    } else if ([ISO681LanguageCode hasPrefix:@"el"]) {
        return @"el-GR";
    } else if ([ISO681LanguageCode hasPrefix:@"en"]) {
        return @"en-US"; // en-AU, en-GB, en-IE, en-ZA
    } else if ([ISO681LanguageCode hasPrefix:@"es"]) {
        return @"es-ES"; // es-MX
    } else if ([ISO681LanguageCode hasPrefix:@"fi"]) {
        return @"fi-FI";
    } else if ([ISO681LanguageCode hasPrefix:@"fr"]) {
        return @"fr-FR"; // fr-CA
    } else if ([ISO681LanguageCode hasPrefix:@"hi"]) {
        return @"hi-IN";
    } else if ([ISO681LanguageCode hasPrefix:@"hu"]) {
        return @"hu-HU";
    } else if ([ISO681LanguageCode hasPrefix:@"id"]) {
        return @"id-ID";
    } else if ([ISO681LanguageCode hasPrefix:@"it"]) {
        return @"it-IT";
    } else if ([ISO681LanguageCode hasPrefix:@"ja"]) {
        return @"ja-JP";
    } else if ([ISO681LanguageCode hasPrefix:@"ko"]) {
        return @"ko-KR";
    } else if ([ISO681LanguageCode hasPrefix:@"nl"]) {
        return @"nl-NL"; // nl-BE
    } else if ([ISO681LanguageCode hasPrefix:@"no"]) {
        return @"no-NO";
    } else if ([ISO681LanguageCode hasPrefix:@"pl"]) {
        return @"pl-PL";
    } else if ([ISO681LanguageCode hasPrefix:@"pt"]) {
        return @"pt-BR"; // pt-PT
    } else if ([ISO681LanguageCode hasPrefix:@"ro"]) {
        return @"ro-RO";
    } else if ([ISO681LanguageCode hasPrefix:@"ru"]) {
        return @"ru-RU";
    } else if ([ISO681LanguageCode hasPrefix:@"sk"]) {
        return @"sk-SK";
    } else if ([ISO681LanguageCode hasPrefix:@"sv"]) {
        return @"sv-SE";
    } else if ([ISO681LanguageCode hasPrefix:@"th"]) {
        return @"th-TH";
    } else if ([ISO681LanguageCode hasPrefix:@"tr"]) {
        return @"tr-TR";
    } else if ([ISO681LanguageCode hasPrefix:@"zh"]) {
        return @"zh-CN"; // zh-HK, zh-TW
    } else {
        return nil;
    }
}
typedef NS_ENUM(NSInteger, SpeechUtteranceLanguage) {
    Arabic,
    Chinese,
    Czech,
    Danish,
    Dutch,
    German,
    Greek,
    English,
    Finnish,
    French,
    Hindi,
    Hungarian,
    Indonesian,
    Italian,
    Japanese,
    Korean,
    Norwegian,
    Polish,
    Portuguese,
    Romanian,
    Russian,
    Slovak,
    Spanish,
    Swedish,
    Thai,
    Turkish,
};

static NSString * BCP47LanguageCodeForString(NSString *string) {
    NSString *ISO681LanguageCode = (__bridge NSString *)CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef)string, CFRangeMake(0, [string length]));
    return BCP47LanguageCodeFromISO681LanguageCode(ISO681LanguageCode);
}



@interface AttendanceViewController () <AVSpeechSynthesizerDelegate>
{
    SCShapeView *_boundingBox;
    NSTimer *_boxHideTimer;
    NSTimer *_QRPauseTimer;
}

@property (strong, nonatomic) NSString *currentDateInString;
@property (strong, nonatomic) NSString *currentTime;

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

//@property (readwrite, nonatomic, copy) NSString *utteranceString;
//@property (readwrite, nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

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
    
    [self loadBeepSound];
    
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


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startReadingQRCode];
    
    self.qRCodeInformationLabel.text = @"";
    self.currentStatusLabel.text = @"Waiting for QR code ...";
    [self.startStopReadingButton setTitle:@"Stop Reading!" forState: UIControlStateNormal];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopReadingQRCode];
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

- (NSString *) currentDateInString
{
    _currentDateInString = [Account convertedNSStringFromNSDate:[NSDate date]];
    return _currentDateInString;
}

- (NSString *) currentTime
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [timeFormatter stringFromDate:[NSDate date]];
    
    _currentTime = timeString;
    return _currentTime;
    
}




- (IBAction)startStopReadingButtonPressed:(id)sender
{
    
    //[self speakTTS:@"Hi May, nice to meet you"];
    //return;
    
    if (isReading) {
        
        if ([self stopReadingQRCode]) {
        self.qRCodeInformationLabel.text = @"";
        self.currentStatusLabel.text = @"Please press 'Start Reading Button to start reading QRCode.";
        [self.startStopReadingButton setTitle:@"Start Reading!" forState:UIControlStateNormal];
        }
    } else {
        
        if ([self startReadingQRCode]) {
            self.qRCodeInformationLabel.text = @"";
            self.currentStatusLabel.text = @"Waiting for QR code ...";
            [self.startStopReadingButton setTitle:@"Stop Reading!" forState:UIControlStateNormal];
        }
    }
    
    isReading = !isReading;
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront)
        //if ([device position] == AVCaptureDevicePositionBack)
        {
            return device;
        }
    }
    return nil;
}

-(BOOL) initializeQRCode
{
    NSError *error;

    
    AVCaptureDevice *captureDevice = [self frontCamera]; //[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
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
            
            [self stopReadingQRCode];
            
            [self startQRResumeTimer];
            
            //[_startStopReadingButton setTitle:@"Start Reading!" forState:UIControlStateNormal];
            //[_qRCodeInformationLabel performSelectorOnMainThread:@selector(setText:) withObject:[transformed stringValue] waitUntilDone:NO];

            [self saveAttendanceRecord];
            
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

- (void) saveAttendanceRecord
{
    Attendance *currentAttendance = [[Attendance alloc] init];
    
    currentAttendance.iD = _qRCodeInformationLabel.text;
    currentAttendance.dateNSString = self.currentDateInString;
    currentAttendance.time = self.currentTime;
    
    BOOL result = [currentAttendance saveAttendanceInformation];
    
    NSString *resultstr;
    if(result) {
        resultstr = [NSString stringWithFormat:@"ID : %@ - %@ - %@", currentAttendance.iD, currentAttendance.dateNSString, currentAttendance.time];
    }
    else {
        resultstr = [NSString stringWithFormat:@"Already Attended"];
    }
    
    self.self.currentStatusLabel.text = resultstr;
    
    if(result) {
         NSLog(@"Attendance Saved : %@ - %@ - %@", currentAttendance.iD, currentAttendance.dateNSString, currentAttendance.time);
    }
    else {
        NSLog(@"Attendance Already Saved");
    }
    
    NSString *speechstr = @"Hi";
    //if(result)
    {
        Account *currentAccount = [Account bringAccountWithID:currentAttendance.iD];
        if(currentAccount) {
            NSString *name = currentAccount.name;
            speechstr = [NSString stringWithFormat:@"Hi %@", name];
        }
    }
    //else {
    //    speechstr = [NSString stringWithFormat:@"Already Attended"];
    //}
    [self speakTTS:speechstr];
    
}


#pragma mark - Utility Methods

- (void) startQRResumeTimer
{
    // Cancel it if we're already running
    if(_QRPauseTimer) {
        [_QRPauseTimer invalidate];
    }
    
    // Restart it to hide the overlay when it fires
    _QRPauseTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                     target:self
                                                   selector:@selector(resumeQRCode:)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)resumeQRCode:(id)sender
{
    [self startReadingQRCode];
}


- (void) startOverlayHideTimer
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


- (void)speakTTS:(NSString*)text
{
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    synthesizer.delegate = self;
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:text];
    //NSLog(@"BCP-47 Language Code: %@", BCP47LanguageCodeForString(utterance.speechString));
    
    //utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:BCP47LanguageCodeForString(utterance.speechString)];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    //utterance.pitchMultiplier = 0.5f;
    utterance.rate = AVSpeechUtteranceMaximumSpeechRate/5;//AVSpeechUtteranceDefaultSpeechRate;//AVSpeechUtteranceMinimumSpeechRate;
    utterance.preUtteranceDelay = 0.0f;
    utterance.postUtteranceDelay = 0.0f;
    
    [synthesizer speakUtterance:utterance];
    
    
    
    
    
    //AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    //AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    //[utterance setRate:AVSpeechUtteranceMaximumSpeechRate/3.0f];
    //[synthesizer speakUtterance:utterance];
}

@end
