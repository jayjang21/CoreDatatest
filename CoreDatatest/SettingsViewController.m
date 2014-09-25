//
//  SettingsViewController.m
//  CoreDatatest
//
//  Created by Daesik Jang on 2014-09-22.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "SettingsViewController.h"

#import "ResisterViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>

#import <MessageUI/MFMailComposeViewController.h>

#import "GDataXMLNode.h"

#import <DropboxSDK/DropboxSDK.h>

@interface SettingsViewController () <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, DBRestClientDelegate>

@property (nonatomic, strong) DBRestClient *restClient;
@property (nonatomic, strong) NSString *dropBoxDataPath;

-(IBAction)backDatabase:(id)sender;
@end

@implementation SettingsViewController

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
    
    numberOfImagesToSend = 0;
    numberOfSentImage = 0;
    
    _isBackupDropbox = NO;
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

- (IBAction)prepareBackupPressed:(id)sender {
    //Check "data" folder first, if it does not exist, don't remove "backup" folder
    NSString *photosRoot =  @"/";
    [self.restClient loadMetadata:photosRoot];
    
    //[self backupPrevDropboxData];
    
}
-(void) backupPrevDropboxData
{

    NSString *destDir = @"/";
    
    NSString *fromFile = [NSString stringWithFormat:@"%@%@",destDir, @"data"];
    NSString *toFile = [NSString stringWithFormat:@"%@%@",destDir, @"backup"];
    
    //[self.restClient deletePath:toFile];
    
    [self.restClient moveFrom:fromFile toPath:toFile];
    
    //_isBackupDropbox = YES;
    ///NSString *photosRoot = @"/";
    //[self.restClient loadMetadata:photosRoot];
}
/*
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
 */

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
        NSString *destDir = self.dropBoxDataPath; //@"/data/";
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
        NSString *destDir = self.dropBoxDataPath; //@"/data/";
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
            /*
             CGSize orgsize = profileImage.size;
             float targetwidth = 500.0f;
             float ratio = (float)targetwidth / (float)orgsize.width;
             float targetheight = orgsize.height * ratio;
             CGSize targetsize = CGSizeMake(targetwidth, targetheight);
             UIImage *resizedImage = [self resizeWithImage:profileImage scaledToSize:targetsize];
             //NSString *tempLocalPath = [documentsDirectory
             //                           stringByAppendingPathComponent:@"temp.jpg"];
             */
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
        
        
        /*
         UIImage *resizedImage = [self resizeProfileImage:profileImage];
         //resize image if > 500
         UIImage *profileImage = [Account ProfileImageWithProfileImagePath:imageLocalPath];
         CGSize orgsize = profileImage.size;
         float targetwidth = 500.0f;
         float ratio = (float)targetwidth / (float)orgsize.width;
         float targetheight = orgsize.height * ratio;
         CGSize targetsize = CGSizeMake(targetwidth, targetheight);
         UIImage *resizedImage = [self resizeWithImage:profileImage scaledToSize:targetsize];
         NSString *tempLocalPath = [documentsDirectory
         stringByAppendingPathComponent:@"temp.jpg"];
         
         [Account saveProfileImage:resizedImage withPath:tempLocalPath];
         */
        // Upload file to Dropbox
        NSString *destDir = self.dropBoxDataPath; //@"/data/";
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
    
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    else {
        [self downloadFromDropboxWithBackupFile];
        
        [self downloadFromDropboxWithImages];
        
        //[self restoreDBfromXML];
    }
}

-(void)downloadFromDropboxWithBackupFile
{
    
    NSString *destDir = self.dropBoxDataPath; //@"/data/";
    
    {
        NSString* accountLocalFilePath = [self accountFilePath:TRUE];
        NSString *filename = [NSString stringWithFormat:@"%@%@", destDir, @"Accounts.xml"];//@"/data/Accounts.xml";
        
        //NSString *destDir = @"/";
        [self.restClient loadFile:filename intoPath:accountLocalFilePath];
        
        
    }
    
    {
        NSString* attendanceLocalFilePath = [self attendanceFilePath:TRUE];
        NSString *filename = [NSString stringWithFormat:@"%@%@", destDir, @"Attendances.xml"];//@"/data/Attendances.xml";
        
        //NSString *destDir = @"/";
        [self.restClient loadFile:filename intoPath:attendanceLocalFilePath];
    }
    
    //(NSString*)attendanceLocalFilePath = [self attendanceFilePath:TRUE];
    
    
}

-(void)downloadFromDropboxWithImages
{
    NSString *photosRoot = self.dropBoxDataPath;// @"/data/";
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
            else if(file.isDirectory) {
                NSLog(@"Folder '%@' : %@", file.path, file.filename);
                //If data folder exist, then remove backup folder and move data
                if([file.filename isEqualToString:@"data"]) {
                    [self backupPrevDropboxData];
                }
            }
            
        }
        
        if([newPhotoPaths count] <=0)
            return;
        
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

- (void)restClient:(DBRestClient*)client deletedPath:(NSString *)path {
    NSLog(@"PASSED: deleted path %@", path);
    
    NSString *destDir = @"/";
    
    NSString *fromFile = [NSString stringWithFormat:@"%@%@",destDir, @"data"];
    NSString *toFile = [NSString stringWithFormat:@"%@%@",destDir, @"backup"];
    
    [self.restClient moveFrom:fromFile toPath:toFile];
}

- (void)restClient:(DBRestClient*)client movedPath:(NSString *)from_path toPath:(NSString *)to_path
{
    NSLog(@"PASSED: moved path %@ to %@", from_path, to_path);
}

- (void)restClient:(DBRestClient*)client movePathFailedWithError:(NSError*)error
{
    NSLog(@"Error moving path");
    
    NSString *destDir = @"/";
    
    NSString *fromFile = [NSString stringWithFormat:@"%@%@",destDir, @"data"];
    NSString *toFile = [NSString stringWithFormat:@"%@%@",destDir, @"backup"];
    
    [self.restClient deletePath:toFile];
}


- (DBRestClient*)restClient {
    if (_restClient == nil) {
        _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
    }
    return _restClient;
}

-(NSString*)dropBoxDataPath {
    return @"/data/";
}


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
- (IBAction)testButton:(id)sender {
    
    //[self backupPrevDropboxData];
    
    //NSString *destDir = @"/";
    
    //NSString *fromFile = [NSString stringWithFormat:@"%@%@",destDir, @"1-2.jpg"];
    //NSString *toFile = [NSString stringWithFormat:@"%@%@",destDir, @"1.jpg"];
    //[self.restClient moveFrom:fromFile toPath:toFile];
}

@end
