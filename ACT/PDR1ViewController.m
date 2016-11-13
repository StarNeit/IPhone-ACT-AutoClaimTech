//
//  PDR1ViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PDR1ViewController.h"
#import "PDRViewController.h"
#import "Over_ViewController.h"
#import "PDFViewController.h"
#import "JSON.h"
#import "config.h"
@interface PDR1ViewController ()

@end

@implementation PDR1ViewController
@synthesize pdrtext;


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
    [self.navigationController setNavigationBarHidden:YES];
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
   
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(Takepic) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
       
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.enabled =NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    // [keybtn addTarget:self action:@selector(presskeypad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    //  [settingbtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
    
    estmatelbl = [self customLabel:@"PDR Estimate(Contd.)" initFrame:CGRectMake(390, 10, 300, 100)];
    estmatelbl.font=[UIFont fontWithName:@"Gill Sans"size:34.0];
    estmatelbl.backgroundColor = [UIColor clearColor];
    estmatelbl.textColor=[UIColor whiteColor];
    [self.view addSubview:estmatelbl];
    
    pdrlbl = [self customLabel:@"PDR Total($)" initFrame:CGRectMake(300, 170, 200, 50)];
    [self.view addSubview:pdrlbl];
    
    partlbl = [self customLabel:@"Parts($)" initFrame:CGRectMake(300, 230, 200, 50)];
    [self.view addSubview:partlbl];
    
    secondlbl = [self customLabel:@"R&I($)" initFrame:CGRectMake(300, 290, 200, 50)];
    [self.view addSubview:secondlbl];
    
    grand = [self customLabel:@"Grand Total($)" initFrame:CGRectMake(300, 350, 200, 50)];
    [self.view addSubview:grand];
    
    pdrlbl = [[UILabel alloc] initWithFrame:CGRectMake(650, 175, 110, 40)];
    pdrlbl.tag = ACTPDRCONTTotal;
    // pdrlbl.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"PDFTotal"]];
    pdrlbl.font = [UIFont fontWithName:@"Gill Sans" size:20.0f];
    pdrlbl.textAlignment = UITextAlignmentCenter;
    pdrlbl.backgroundColor = [UIColor whiteColor];
    pdrlbl.textColor =[UIColor blackColor];
    [self.view addSubview:pdrlbl];

    parttxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(650, 235, 110, 40)];
    parttxt.textAlignment = UITextAlignmentCenter;
    parttxt.tag = ACTPDRCONTParts;
    parttxt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:parttxt];
    
    secondtxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(650, 295, 110, 40)];
    secondtxt.textAlignment = UITextAlignmentCenter;
    secondtxt.tag = ACTPDRCONTRI;
     secondtxt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondtxt];
       
    grandlbl= [[UILabel alloc] initWithFrame:CGRectMake(650, 355, 110, 40)];
    grandlbl.tag = ACTPDRCONTGrand;
    grandlbl.font = [UIFont fontWithName:@"Gill Sans" size:20.0f];
    grandlbl.textAlignment = UITextAlignmentCenter;
    grandlbl.backgroundColor = [UIColor whiteColor];
    grandlbl.textColor =[UIColor blackColor];
    [self.view addSubview:grandlbl];
      
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame
{
	UILabel *customLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
	customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = str;
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.font=[UIFont fontWithName:@"Gill Sans"size:24.0f];
    customLabel.textColor=[UIColor whiteColor];
    
	return customLabel;
}
-(void)Notes
{
    NotesViewController *notes1 = [[NotesViewController alloc] init];
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:notes1];
    navigate.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navigate animated:YES ];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     return YES;	
}

-(void)total
{
    int totalval =0;
    totalval = [pdrlbl.text intValue]+[parttxt.text intValue]+[secondtxt.text intValue];
    grandlbl.text = [NSString stringWithFormat:@"%d",totalval];
  
}
-(int) formatHour:(NSString*)txt
{
    NSArray *costarr = [txt componentsSeparatedByString:@" "];
    int hour;
    if ([costarr count] >1) {
        hour = [[costarr objectAtIndex:1] intValue];
    }
    
    return hour;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *jsonstr = [ACTAPP_DELEGATE getdate:ACT_PDRCONTID];
    NSDictionary *dict = [jsonstr JSONValue];
    
    if(dict)
    {
       NSDictionary *dict = [jsonstr JSONValue];
        pdrlbl.text = [dict objectForKey:@"PDRTotal"];
        parttxt.text = [dict objectForKey:@"parts"];
        secondtxt.text = [dict objectForKey:@"r_n_i"];
        grandlbl.text = [dict objectForKey:@"grand_total"];
     
    }
    pdrlbl.text = pdrtext;
    [self total];
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    UILabel *lbl =(UILabel*)[self.view viewWithTag:ACTPDRCONTTotal];
    UITextField *text1 = (UITextField*)[self.view viewWithTag:ACTPDRCONTParts];
    UITextField *text2 = (UITextField*)[self.view viewWithTag:ACTPDRCONTRI];
    UILabel *lbl1 = (UILabel*)[self.view viewWithTag:ACTPDRCONTGrand];
    
    NSString *jsonspdrstr = [NSString stringWithFormat:@"{\"PDRTotal\":\"%@\",\"parts\":\"%@\",\"r_n_i\":\"%@\",\"grand_total\":\"%@\"}",[ACTAPP_DELEGATE emptyStr:lbl.text],[ACTAPP_DELEGATE emptyStr:text1.text],[ACTAPP_DELEGATE emptyStr:text2.text],[ACTAPP_DELEGATE emptyStr:lbl1.text]];
    
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.releaseEstimate = jsonspdrstr;
    [ACTAPP_DELEGATE setdate:updateVINDB.releaseEstimate forkey:ACT_PDRCONTID];
    [updateVINDB save];
    
    [super viewWillDisappear:YES];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    PDFViewController *top =[[PDFViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:top animated:YES];

    //[top release];
    
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    PDRViewController *front =[[PDRViewController alloc]initWithNibName:@"PDRViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
   // [front release];
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
	customField.placeholder = NSLocalizedString(str,nil);
    customField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    customField.textColor = [UIColor blackColor];
    customField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    customField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   	customField.keyboardType = UIKeyboardTypeNumberPad;
	return customField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(![string isEqualToString:@""])
    {
        if(textField == parttxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            
            if([parttxt.text length]+[string length]>6) return NO;
            else return YES;
        }
        if(textField == secondtxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([secondtxt.text length]+[string length]>10) return NO;
            else return YES;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   
    [self total];
    return YES;
}
-(NSString *) formatIdentificationNumber:(NSString *)string
{
    NSCharacterSet * invalidNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"àáâäæãåçćčèéêëęėîïìíįłñńôöòóõœøßśšûüùúŵŷÿźžż°§¿’‘€$£¥₩\n_!@#$%^&*[](){}'\".,<>:;|\\/?+=\t~`"];
    NSString  * result  = @"";
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString  * scannerResult;
    
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd])
    {
        if([scanner scanUpToCharactersFromSet:invalidNumberSet intoString:&scannerResult])
        {
            result = [result stringByAppendingString:scannerResult];
        }else
        {
            if(![scanner isAtEnd])
            {
                [scanner setScanLocation:[scanner scanLocation]+1];
            }
        }
    }
    
    return result;
} 

-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to go to Home page? You will lose any unsaved data." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag =300;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //  NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == 300 && buttonIndex == 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
}
-(void) Takepic
{
    CameraViewController *camera = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
    [self.navigationController pushViewController:camera animated:YES];
    [camera release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}

@end
