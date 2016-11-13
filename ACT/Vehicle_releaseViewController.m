//
//  Vehicle_releaseViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 02/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vehicle_releaseViewController.h"
#import "ReleaseViewController.h"
#import "JSON.h"
#import "config.h"
#import "NotesViewController.h"
#import "SaveData.h"
#import "VINDB.h"
@interface Vehicle_releaseViewController ()

@end

@implementation Vehicle_releaseViewController
@synthesize vinnumber;
@synthesize techname;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSArray *yeararray;
NSArray *windarray;

- (void)viewDidLoad
{

    [self.navigationController setNavigationBarHidden:YES];
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    // right swipe controller
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
 
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    //     bg.backgroundColor = [UIColor blueColor];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 1024, 550) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    //tableview.rowHeight = 70.0f;
    [self.view addSubview:tableview];
    
    UIImageView *releaselabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rel_text.png"]];
    releaselabel.frame = CGRectMake(40, 10, 201, 25);
    [tableview addSubview:releaselabel];

    yeararray = [[NSArray alloc] initWithObjects:@"1980",@"1981",@"1982",@"1983",@"1984",@"1985",@"1986",@"1987",@"1988",@"1989",@"1990",@"1991",@"1992",@"1993",@"1994",@"1995",@"1996",@"1997",@"1998",@"1999",@"2000",@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030",@"2031",@"2032",@"2033",@"2034",@"2035",@"2036",@"2037",@"2038",@"2039",@"2040", nil];
    windarray = [[NSArray alloc] initWithObjects:@"Yes",@"No", nil];        
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];

    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.tag = 200;
     keybtn.enabled =NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
     [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    //[keybtn addTarget:self action:@selector(presskeypad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
     camerabtn.enabled =NO;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];

    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(scanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
    
    UIImageView *vehicle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vehicleinfo_bg.png"]];
    vehicle.frame = CGRectMake(170, 50, 690, 479);
    [tableview addSubview:vehicle];
    
    maketxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(300, 165, 180, 30)];
    maketxt.tag = ACTVEHICLEMake;
//    maketxt.backgroundColor = [UIColor blueColor];
    [tableview addSubview:maketxt];
    
    modeltxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(300, 230, 180, 30)];
    modeltxt.tag = ACTVEHICLEModel;
    [tableview addSubview:modeltxt];
    
    yeartext = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(310, 270, 180, 30)];
    yeartext.tag = ACTVEHICLEYear;
    yeartext.keyboardType = UIKeyboardTypeNumberPad;
  
    
  yearbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yearbtn.tag = ACTVEHICLEYear;
    yearbtn.frame = CGRectMake(300, 290, 180, 30);
    yearbtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    yearbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [yearbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    yearbtn.backgroundColor = [UIColor clearColor];
    [yearbtn addTarget:self action:@selector(pickerView:) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:yearbtn];
    
    colortxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(300, 360, 180, 30)];
    colortxt.tag = ACTVEHICLEColor;
    [tableview addSubview:colortxt];
    
    zipCode = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(300, 425, 180, 30)];
    zipCode.tag = ACTZIPCODE;
    [tableview addSubview:zipCode];
     zipCode.keyboardType = UIKeyboardTypeNumberPad;
    
    mileagetxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(590, 165, 180, 30)];
    mileagetxt.keyboardType = UIKeyboardTypeNumberPad;
    mileagetxt.tag = ACTVEHICLEMiliage;
    [tableview addSubview:mileagetxt];
   // claimtxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(575, 260, 180, 30)];
    claimtxt = [[UILabel alloc] initWithFrame:CGRectMake(590, 230, 180, 30)];
    claimtxt.backgroundColor = [UIColor clearColor];
    claimtxt.text = [ACTAPP_DELEGATE getUserDefault:ACTVIN];
    claimtxt.tag = ACTVEHICLEClaim;
    [tableview addSubview:claimtxt];
    
    materialtxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(590, 295, 180, 30)];
    materialtxt.tag = ACTVEHICLEContaminant;
    [tableview addSubview:materialtxt];
    windbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    windbtn.tag = ACTVEHICLEWindShield;
    windbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    windbtn.frame = CGRectMake(590, 360, 180, 30);
    windbtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    windbtn.titleLabel.textAlignment = UITextAlignmentLeft;
    [windbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    windbtn.backgroundColor = [UIColor clearColor];
    [windbtn addTarget:self action:@selector(pickerView:) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:windbtn];

    pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 350, 400)];
    [pickerview setTintColor:[UIColor blackColor]];
    pickerview.showsSelectionIndicator = YES;
    pickerview.delegate = self;
    pickerview.dataSource = self;
    
    claimNumberTxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(590, 425, 180, 30)];
    claimNumberTxt.tag = ACTVEHICLEClaimNumber;
//    [claimNumberTxt setBackgroundColor:[UIColor blueColor]];
    [tableview addSubview:claimNumberTxt];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    NSString *jsonStr = [ACTAPP_DELEGATE getdate:ACT_RELEASEFORM_VECHICLE];
    NSDictionary *dict = [jsonStr JSONValue];
    
    if ( dict ) {
        NSDictionary *dict = [jsonStr JSONValue];
        claimNumberTxt.text = [dict objectForKey:@"claim_num"];
        maketxt.text = [dict objectForKey:@"make"];
        modeltxt.text = [dict objectForKey:@"model"];
        yeartext.text = [dict objectForKey:@"year"];
        mileagetxt.text = [dict objectForKey:@"mileage"];
        claimtxt.text = [dict objectForKey:@"vin_num"];
        colortxt.text = [dict objectForKey:@"color"];
        materialtxt.text = [dict objectForKey:@"contaminant"];
         zipCode.text = [dict objectForKey:@"zipcode"];
        [windbtn setTitle:[dict objectForKey:@"windshield"] forState:UIControlStateNormal];
    }
    [self callWebService];
    [super viewWillAppear:YES];
}
-(void) viewWillDisappear:(BOOL)animated
{
    UITextField *txt1 = (UITextField*)[self.view viewWithTag:ACTVEHICLEMake];
    UITextField *txt = (UITextField*)[self.view viewWithTag:ACTVEHICLEModel];
    UIButton *txt2 = (UIButton*)[self.view viewWithTag:ACTVEHICLEYear];
   // UIButton *txt2 = (UIButton*)[self.view viewWithTag:ACTVEHICLEYear];
    UITextField *txt3 = (UITextField*)[self.view viewWithTag:ACTVEHICLEColor];
    UITextField *txt4 = (UITextField*)[self.view viewWithTag:ACTVEHICLEMiliage];
    UILabel *txt5 = (UILabel*)[self.view viewWithTag:ACTVEHICLEClaim];
    UITextField *txt6 = (UITextField*)[self.view viewWithTag:ACTVEHICLEContaminant];
    UIButton *txt7 = (UIButton*)[self.view viewWithTag:ACTVEHICLEWindShield];
     UITextField *txtZipcode = (UITextField*)[self.view viewWithTag:ACTZIPCODE];
    UITextField *txtClaim_Num = (UITextField*)[self.view viewWithTag:ACTVEHICLEClaimNumber];
    if ([txtClaim_Num.text isEqualToString:@""])
    {
        txtClaim_Num.text = @"N/A";
    }
    NSString *jsonStr = [NSString stringWithFormat:@"{\"make\":\"%@\",\"model\":\"%@\",\"year\":\"%@\",\"color\":\"%@\",\"mileage\":\"%@\", \"vin_num\":\"%@\",\"contaminant\":\"%@\",\"windshield\":\"%@\",\"zip_code\":\"%@\", \"claim_num\":\"%@\"}",
                         [ACTAPP_DELEGATE emptyStr:txt1.text],
                         [ACTAPP_DELEGATE emptyStr:txt.text],
                         [ACTAPP_DELEGATE emptyStr:txt2.titleLabel.text],
                         [ACTAPP_DELEGATE emptyStr:txt3.text],
                         [ACTAPP_DELEGATE emptyStr:txt4.text],
                         [ACTAPP_DELEGATE emptyStr:txt5.text],
                         [ACTAPP_DELEGATE emptyStr:txt6.text],
                         [ACTAPP_DELEGATE emptyStr:txt7.titleLabel.text],
                         [ACTAPP_DELEGATE emptyStr:txtZipcode.text],
                         [ACTAPP_DELEGATE emptyStr:txtClaim_Num.text]];
    NSLog(@"JSON %@",jsonStr);
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.vehicleJson = jsonStr;
    [ACTAPP_DELEGATE setdate:updateVINDB.vehicleJson forkey:ACT_RELEASEFORM_VECHICLE];
    [updateVINDB save];
    [super viewWillDisappear:YES];
}
- (void) callWebService
{
    NSURL *url = [NSURL URLWithString:ACT_VINDetails];
    ASIFormDataRequest *request  = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addPostValue:[NSString stringWithFormat:@"{\"vin\":\"%@\"}",vinnumber] forKey:@"data"];
    //[request setTimeOutSeconds:60];
    [request setDelegate:self];
    request.shouldPresentCredentialsBeforeChallenge = YES;
    [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
    [request setDidFinishSelector:@selector(finish:)];
    [request setDidFailSelector :@selector(failure:)];    
    [request startSynchronous];
}
-(void)finish:(ASIFormDataRequest*)response
{
    
    if([response responseStatusCode] ==200)
    {
        NSArray *arr =  [[response responseString] JSONValue];
        NSLog(@"REPONSE %@",arr);
        maketxt.text = [[arr objectAtIndex:0] objectForKey:@"make"];
        modeltxt.text = [[arr objectAtIndex:0] objectForKey:@"model"];
        yeartext.text = [[arr objectAtIndex:0] objectForKey:@"year"];
        [yearbtn setTitle:[[arr objectAtIndex:0] objectForKey:@"year"] forState:UIControlStateNormal];
    }
}
-(void)failure:(ASIFormDataRequest*)response
{
    
}
-(void)Notes
{
    NotesViewController *notes1 = [[NotesViewController alloc] init];
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:notes1];
    navigate.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navigate animated:YES ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    // NSInteger section = indexPath.section;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellidentifier"];
    if (cell != nil) {
        cell = nil;
    }
    if (cell==nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellidentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
   NSMutableString *errormsg = [[NSMutableString alloc] init];
    if([maketxt.text length]==0)
         [errormsg appendFormat:@"Please fill the make field\n"];
    if([modeltxt.text length]==0)
         [errormsg appendFormat:@"Please fill the model field\n"];
    if([zipCode.text length]==0)
        [errormsg appendFormat:@"Please fill the zipcode field\n"];
    if([yearbtn.titleLabel.text length]==0)
         [errormsg appendFormat:@"Please fill the year field\n"];
    if([colortxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the color field\n"];
    if([mileagetxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the mileage field\n"];
    if([claimtxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the vin field \n"];
    if([materialtxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the contaminant material field\n"];
    if([windbtn.currentTitle length] == 0)
        [errormsg appendFormat:@"please fill the windshield or front edge pitted\n"];
    if(![errormsg isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errormsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{   
  
        ReleaseViewController *release =[[ReleaseViewController alloc]initWithNibName:@"ReleaseViewController" bundle:nil];
        release.zipcode = zipCode.text;
       [self.navigationController pushViewController:release animated:YES];
      // [release release];
    }
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
  /*  ScanViewController *scan =[[ScanViewController alloc]initWithNibName:@"ScanViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];*/
   // [scan release];
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
-(void)setting
{
    [self.navigationController setNavigationBarHidden:YES];
   ReleaseViewController *custrelease = [[ReleaseViewController alloc] initWithNibName:@"ReleaseViewController" bundle:nil];
    [self.navigationController pushViewController:custrelease animated:YES];  
}
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame
{
    UITextField *customField = [[UITextField alloc] initWithFrame:frame];
	customField.delegate = self;
	customField.adjustsFontSizeToFitWidth = NO;
	customField.borderStyle = UITextBorderStyleNone;
	customField.clearButtonMode = UITextFieldViewModeWhileEditing;
	customField.clearsOnBeginEditing = NO;
	customField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	customField.autocorrectionType = UITextAutocorrectionTypeNo;
	customField.enablesReturnKeyAutomatically = YES;
	customField.returnKeyType = UIReturnKeyDefault;
	customField.placeholder = NSLocalizedString(str, nil);
	customField.keyboardType = UIKeyboardTypeDefault;
    customField.font = [UIFont fontWithName:@"Arial" size:14.0f];
    customField.textColor = [UIColor blackColor];
    customField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    customField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

	return customField;
}
-(void) pickerView:(id)sender
{
 
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
    
           UIViewController *pickView = [[UIViewController alloc] init];
           UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 330)];
           popoverView.backgroundColor = [UIColor clearColor];
           [popoverView addSubview:toolbar];
           [popoverView addSubview:pickerview];
           pickView.view = popoverView;

      
    if(sender == yearbtn)
    {
        pickerview.tag = 100;
        pickView.contentSizeForViewInPopover = CGSizeMake(100, 260);
        [pickerview reloadAllComponents];
        if (!yearbtn.titleLabel.text) {
            [yearbtn setTitle:[yeararray objectAtIndex:0] forState:UIControlStateNormal];
        }else
        {
            int count=0;
            for(NSString *str in yeararray)
            {
                NSRange r = [[str lowercaseString] rangeOfString:[yearbtn.titleLabel.text lowercaseString]];
                if(r.location != NSNotFound)
                {
                    [pickerview selectRow:count inComponent:0 animated:NO];
                }
                count++;
            }
        }
        
    }
    else if(sender == windbtn)
    {
        pickerview.tag = 200;
        pickView.contentSizeForViewInPopover = CGSizeMake(100, 220);
        [pickerview reloadAllComponents];
        if (!windbtn.titleLabel.text) {
            [windbtn setTitle:[windarray objectAtIndex:1] forState:UIControlStateNormal];
            [pickerview selectRow:1 inComponent:0 animated:NO];
        }else
        {
            int count=0;
            for(NSString *str in windarray)
            {  
                NSRange r = [[str lowercaseString] rangeOfString:[windbtn.titleLabel.text lowercaseString]];
                if(r.location != NSNotFound)
                {
                    [pickerview selectRow:count inComponent:0 animated:NO];
                }
                count++;
            }
            
        }
        
    }        
      [pickerview reloadAllComponents];
        //create a popover controller
        popoverController = [[UIPopoverController alloc]
                             initWithContentViewController:pickView];
        popoverController.delegate = self;
         
    CGRect frameVal = CGRectMake([sender frame].origin.x-50, [sender frame].origin.y+10, 250, 50);
	[popoverController presentPopoverFromRect:frameVal inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]   ;  

    //release the popover content
        [pickView release];
        [popoverView release]; 
        
} 
-(void) close
{
    [popoverController dismissPopoverAnimated:YES];
}
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    ACTReleaseNil(popoverController);
}

#pragma mark UIPickerViewDelegate methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag == 100)
    {
        return [yeararray count];
    }
     else if(pickerView.tag == 200)
    {
       return [windarray count];
    }
    return 1;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(thePickerView.tag == 100)
    {
        NSString *categoryType  = [yeararray objectAtIndex:row];
        [yearbtn setTitle:categoryType forState:UIControlStateNormal];
    }
    else if(thePickerView.tag == 200)
    {
        NSString *windtype = [windarray objectAtIndex:row];
        [windbtn setTitle:windtype forState:UIControlStateNormal];
    }
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(thePickerView.tag == 100)
    {
        return [yeararray objectAtIndex:row];
    }
    else if(thePickerView.tag == 200)
    {
        return  [windarray objectAtIndex:row];
    }
    return @"";
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
        
       // [errormsg appendFormat:@"Color field with a limit of 15 characters\n"];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
       
    if(![string isEqualToString:@""])
    {
        if(textField == colortxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([colortxt.text length]+[string length]>15) return NO;
            else return YES;
        }
        
        if(textField == materialtxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([materialtxt.text length]+[string length]>15) return NO;
            else return YES;
        }
        if(textField == maketxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) 
                return NO;
        }
        if(textField == modeltxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) 
                return NO;
        }
        
        if(textField == yeartext)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) 
                return NO;
        }
        if(textField == mileagetxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) 
                return NO;
        }
    }
      return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
   
    if (textField == maketxt) {
        [maketxt resignFirstResponder];
        [modeltxt becomeFirstResponder];
    } if (textField == modeltxt) {
        [modeltxt resignFirstResponder];
        [yeartext becomeFirstResponder];
    }if (textField == yeartext) {
            [yeartext resignFirstResponder];
            [colortxt becomeFirstResponder];

    } if (textField == colortxt) {
        [colortxt resignFirstResponder];
        [mileagetxt becomeFirstResponder];
    } if (textField == mileagetxt) {
        [mileagetxt resignFirstResponder];
        [materialtxt becomeFirstResponder];
    
    }if (textField == materialtxt){
        [materialtxt resignFirstResponder];
        [windbtn becomeFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == maketxt) {
        [tableview setContentOffset:CGPointMake(0, 50)];
    }if(textField == modeltxt){
        [tableview setContentOffset:CGPointMake(0, 100) animated:YES];
    }if(textField == colortxt){
        [tableview setContentOffset:CGPointMake(0, 150) animated:YES];}
    if(textField == zipCode){
        [tableview setContentOffset:CGPointMake(0, 200) animated:YES];}
    if(textField == mileagetxt){
        [tableview setContentOffset:CGPointMake(0, 50) animated:YES];
    }if(textField == materialtxt){
        [tableview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
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
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    ACTReleaseNil(windarray);
    ACTReleaseNil(yeararray);
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}

@end
