//
//  ViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "JSON.h"
#import "config.h"
#import "SaveData.h"
#import "VINDB.h"
#import "ListViewController.h"
#import "PDFViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
        
    [self.navigationController setNavigationBarHidden:YES];
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];  
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_landscape.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    UIView *bartop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024,23)];
    [bartop setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bartop];
    
    
    pinnumber = [self customTextfield:@"enter pin" textName:@"enter pin" initFrame:CGRectMake(450, 300, 160, 40)];
    pinnumber.contentStretch = CGRectMake(450, 320, 3, 2);
    pinnumber.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:pinnumber];
    
    UIButton *enterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterbtn.frame = CGRectMake(262, 200, 130, 133);
    enterbtn.backgroundColor = [UIColor clearColor];
    [enterbtn addTarget:self action:@selector(Enter) forControlEvents:UIControlEventTouchUpInside];
    [enterbtn setTitle:@"" forState:UIControlStateNormal];
    [enterbtn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
    [enterbtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:enterbtn];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homebtn.enabled = NO;
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:homebtn]; 
   
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.enabled = NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    camerabtn.enabled = NO;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled = NO;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingbtn];
    
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSString*) createAlbumFolder:(NSString*)orderID
{
	NSFileManager *NSFm= [NSFileManager defaultManager]; 
	NSString *dirToCreate = [NSString stringWithFormat:@"%@/myMusic",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir = YES;
	NSError *error;
    if(![NSFm fileExistsAtPath:dirToCreate isDirectory:&isDir])
        if(![NSFm createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Error: Create folder failed");
	
	NSString *orderFolder = [NSString stringWithFormat:@"%@/%@",dirToCreate,orderID];
	
	if(![NSFm fileExistsAtPath:orderFolder isDirectory:&isDir])
		if(![NSFm createDirectoryAtPath:orderFolder withIntermediateDirectories:YES attributes:nil error:&error])
			NSLog(@"Error: Create folder failed");
	
	return orderFolder;
}


-(void)viewWillAppear:(BOOL)animated
{
     [[ACTAPP_DELEGATE carimagearray] removeAllObjects];
    
    [ACTAPP_DELEGATE removeCarView:ACTScreenShotCamera];
    [ACTAPP_DELEGATE setUserDefault:ACT_Notes setObject:@""];
    
    [super viewWillAppear:YES];
}
- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer 
{
    if([pinnumber.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the pin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else 
    {
               
        if([self checkIsSave])
        {
            ListViewController *list = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            [self.navigationController pushViewController:list animated:YES];
        }else
        {
            [self callWebService];
        }

    }
   
       /* Over_ViewController *second2 =[[Over_ViewController alloc]initWithNibName:@"Over_ViewController" bundle:nil];
        [self.navigationController pushViewController:second2 animated:YES];
        [second2 release];*/
   
}

-(BOOL) checkIsSave
{
    NSArray *arr = [VINDB findByCriteria:[NSString stringWithFormat:@"Where is_saved != 0"]];
   
    for (VINDB *vin in [VINDB allObjects]) {
        NSLog(@"save %d",vin.isSaved);
    }
    for (VINDB *vinsave in arr) {
        NSLog(@"vin sav %d",vinsave.isSaved);
    }
    
    if([arr count]>0)
    {
        return YES;
    }else
    {
        return NO;
    }

}

- (void) callWebService
    {
       /* progressAlert = [[UIAlertView alloc] initWithTitle:@""
                                                   message:@"Loading..."
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles: nil];
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
        [progressAlert addSubview:activityView];
        [activityView startAnimating];
        [progressAlert show];
        [progressAlert release];*/

        NSURL *url = [NSURL URLWithString:ACT_Login];
        ASIFormDataRequest *request  = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request addPostValue:[NSString stringWithFormat:@"{\"pin\":\"%@\"}",pinnumber.text] forKey:@"data"];
        [request setTimeOutSeconds:60];
        [request setDelegate:self];
        request.shouldPresentCredentialsBeforeChallenge = YES;
        [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
        [request setDidFinishSelector:@selector(finish:)];
         [request setDidFailSelector :@selector(failure:)];    
        [request startSynchronous];
    }
-(void)finish:(ASIFormDataRequest*)response
{
    if ([response responseStatusCode] == 200) {
     //   NSLog(@"res %@ %@",[response responseString],[[response responseString] JSONValue] );
        NSArray *arr =  [[response responseString] JSONValue]; 
        // NSLog(@"arr %@",[arr objectAtIndex:0]);

        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) {
            [standardUserDefaults setObject:arr forKey:ACTLoginDetails];
            [standardUserDefaults synchronize];
        }
        Over_ViewController *over = [[Over_ViewController alloc] initWithNibName:@"Over_ViewController" bundle:nil];
        [self.navigationController pushViewController:over animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid pin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
-(void)failure:(ASIFormDataRequest*)response
{
    
}
-(void)Enter
{
    [ACTAPP_DELEGATE setUserDefault:ACTPinNumber setObject:pinnumber.text];
    
    if([pinnumber.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the pin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if([pinnumber.text length] != 4){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"PIN should be 4 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
           
    else{
       
        if([self checkIsSave])
        {
            ListViewController *list = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            [self.navigationController pushViewController:list animated:YES];
        }else
        {
            [self callWebService];
        }        
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame
{
    
	UITextField *customField = [[UITextField alloc] initWithFrame:frame];
	customField.delegate = self;
	customField.adjustsFontSizeToFitWidth = NO;
	customField.borderStyle = UITextBorderStyleNone;
	customField.clearButtonMode = UITextFieldViewModeWhileEditing;
	customField.clearsOnBeginEditing = NO;
	customField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	customField.autocorrectionType = UITextAutocorrectionTypeNo;
	customField.enablesReturnKeyAutomatically = YES;
	customField.returnKeyType = UIReturnKeyDefault;
	customField.placeholder = NSLocalizedString(str, nil);
	customField.keyboardType = UIKeyboardTypeNumberPad;
    customField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    customField.textColor = [UIColor blackColor];
    customField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    customField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

	return customField;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
