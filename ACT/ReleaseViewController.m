//
//  ReleaseViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReleaseViewController.h"
#import "Over_ViewController.h"
#import "JSON.h"
#import "config.h"
#import "NotesViewController.h"

@interface ReleaseViewController ()

@end

@implementation ReleaseViewController


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
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 1024, 550) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    //tableview.rowHeight = 70.0f;
    [self.view addSubview:tableview];
    
    UIImageView *releaselabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rel_text.png"]];
    releaselabel.frame = CGRectMake(40, 40, 201, 25);
    [tableview addSubview:releaselabel];
    
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
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
     camerabtn.enabled =NO;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
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

    UIImageView *customer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"form.png"]];
     customer.frame = CGRectMake(170, 100, 688, 437);
    [tableview addSubview:customer];
    
    custtxt = [self customTextfield:@"" textName:@"Customer" initFrame:CGRectMake(300, 195, 180, 30)];
    custtxt.tag = ACTCUSTOMERCustomer;
    [tableview addSubview:custtxt];
    
    datebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    datebtn.tag = ACTCUSTOMERDate;
    datebtn.frame = CGRectMake(300, 260, 180, 30);
    datebtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    datebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [datebtn addTarget:self action:@selector(datepicker) forControlEvents:UIControlEventTouchUpInside];
    [datebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [tableview addSubview:datebtn];

   protxt = [self customTextfield:@"" textName:@"Project" initFrame:CGRectMake(300, 325, 180, 30)];
    protxt.tag = ACTCUSTOMERProject;
    [tableview addSubview:protxt];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSArray *val;
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:ACTLoginDetails];
    
   // techtxt = [self customTextfield:@"" textName:@"" initFrame:CGRectMake(290, 390, 180, 30)];
    techtxt = [[UILabel alloc] initWithFrame:CGRectMake(300, 390, 180, 30)];
    techtxt.tag = ACTCUSTOMERTechinician;
    NSString *fulName = [NSString stringWithFormat:@"%@ %@",[[val objectAtIndex:0] objectForKey:@"first_name"],[[val objectAtIndex:0] objectForKey:@"last_name"]];
    techtxt.text = fulName;
    techtxt.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [tableview addSubview:techtxt];
    
    
    citytxt = [self customTextfield:@"" textName:@"City" initFrame:CGRectMake(300, 455, 180, 30)];
    citytxt.tag = ACTCUSTOMERCITY;
    citytxt.enabled = NO;
    [tableview addSubview:citytxt];
    
    
    add1txt = [self customTextfield:@"" textName:@"Address 1" initFrame:CGRectMake(585, 195, 180, 30)];
    add1txt.tag = ACTCUSTOMERAddress1;
    [tableview addSubview:add1txt];
    
    add2txt = [self customTextfield:@"" textName:@"Address 2" initFrame:CGRectMake(585, 260, 180, 30)];
    add2txt.tag = ACTCUSTOMERAddress2;
    [tableview addSubview:add2txt];
    
    scensetxt = [self customTextfield:@"" textName:@"License number" initFrame:CGRectMake(585, 325, 180, 30)];
    scensetxt.tag = ACTCUSTOMERScense;
    scensetxt.keyboardType = UIKeyboardTypeDefault;
    scensetxt.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [tableview addSubview:scensetxt];
    
    phonetxt = [self customTextfield:@"" textName:@"Phone number" initFrame:CGRectMake(585, 390, 180, 30)];
    phonetxt.tag = ACTCUSTOMERPhone;
    phonetxt.keyboardType = UIKeyboardTypeNumberPad;
    [tableview addSubview:phonetxt];
    
    statetxt = [self customTextfield:@"" textName:@"State" initFrame:CGRectMake(585, 455, 90, 30)];
    statetxt.tag = ACTCUSTOMERSTATE;
    statetxt.keyboardType = UIKeyboardTypeDefault;
    statetxt.enabled = NO;
    [tableview addSubview:statetxt];

    zipcodetxt = [self customTextfield:@"" textName:@"Zip" initFrame:CGRectMake(700, 455, 70, 30)];
    zipcodetxt.tag = ACTCUSTOMERXIP;
    zipcodetxt.keyboardType = UIKeyboardTypeNumberPad;
    zipcodetxt.enabled = NO;
    [tableview addSubview:zipcodetxt];
    NSDateFormatter *datefr = [[NSDateFormatter alloc]init];
    [datefr setDateFormat:@"MM/dd/YYYY"];
    NSString *date = [datefr stringFromDate:[NSDate date]];
    [datebtn setTitle:date forState:UIControlStateNormal];
    [yearbtn setTitle:date forState:UIControlStateNormal];
    [ACTAPP_DELEGATE setdate:date forkey:ACTCUSTOMERINFODate];
    [self callWebService];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //add2txt.enabled = YES;
    add2txt.enablesReturnKeyAutomatically = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == custtxt) {
        [custtxt resignFirstResponder];
        [datebtn becomeFirstResponder];
    } if (textField == protxt) {
        [protxt resignFirstResponder];
        [add1txt becomeFirstResponder];
    
    } if (textField == add1txt) {
        [add1txt resignFirstResponder];
        [add2txt becomeFirstResponder];
    }if (textField == add2txt) {
        [add2txt resignFirstResponder];
        add2txt.enablesReturnKeyAutomatically = YES;
        [scensetxt becomeFirstResponder];
    }if (textField == scensetxt){
        [scensetxt resignFirstResponder];
        [phonetxt becomeFirstResponder];
    }if(textField == phonetxt){
        [citytxt resignFirstResponder];
        //[tableview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if(textField == citytxt){
        [statetxt becomeFirstResponder];
        //[tableview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if(textField == statetxt){
        [zipcodetxt resignFirstResponder];
        [tableview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == custtxt) {
        [tableview setContentOffset:CGPointMake(0, 50)];
    }if(textField == protxt){
        [tableview setContentOffset:CGPointMake(0, 150) animated:YES];
    
    }if(textField == add1txt){
        [tableview setContentOffset:CGPointMake(0, 50) animated:YES];
    }if(textField == add2txt){
        add2txt.enablesReturnKeyAutomatically = YES;
       // [tableview setContentOffset:CGPointMake(0, 100) animated:YES];
    }if(textField == scensetxt){
        [tableview setContentOffset:CGPointMake(0, 150) animated:YES];
    }if(textField == phonetxt){
        [tableview setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    if(textField == citytxt || textField == statetxt || textField == zipcodetxt){
        [tableview setContentOffset:CGPointMake(0, 250) animated:YES];
    }
    return YES;	
}
-(void) viewWillAppear:(BOOL)animated
{
    [self numberformat:phonetxt.text];
    [phonetxt addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    
    NSString *jsonStr = [ACTAPP_DELEGATE getdate:ACT_RELEASEFORM_CUSTOMER];
    NSDictionary *dict = [jsonStr JSONValue];
    NSLog(@"DIC %@",dict);
    if (dict) {
        NSDictionary *dict = [jsonStr JSONValue];
        custtxt.text = [dict objectForKey:@"cust_name"];
        [datebtn setTitle:[dict objectForKey:@"date"] forState:UIControlStateNormal];
        protxt.text = [dict objectForKey:@"project"];
        techtxt.text = [dict objectForKey:@"tech_id"];
        add1txt.text = [dict objectForKey:@"address_one"];
        add2txt.text = [dict objectForKey:@"address_two"];
        scensetxt.text = [dict objectForKey:@"license_num"];
        phonetxt.text = [dict objectForKey:@"phone_num"];
    }
    [self callWebService];
    
    [super viewWillAppear:YES];
}

- (void) callWebService
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://autoclaimtechnology.com/zipcode.php?zipcode=%@",_zipcode]];
    ASIFormDataRequest *request  = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    //[request addPostValue:[NSString stringWithFormat:@"{\"zip_code\":\"%@\"}",@"5900"] forKey:@"data"];
    //[request setTimeOutSeconds:60];
    [request setDelegate:self];
    request.shouldPresentCredentialsBeforeChallenge = YES;
   // [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
    [request setDidFinishSelector:@selector(finish:)];
    [request setDidFailSelector :@selector(failure:)];
    [request startSynchronous];
}
-(void)finish:(ASIFormDataRequest*)response
{
     NSLog(@"REPONSE %@",response);
    NSArray *arr =  [[response responseString] JSONValue];
    if (arr.count>0) {
         citytxt.text = [[arr objectAtIndex:0] objectForKey:@"city"];
         statetxt.text = [[arr objectAtIndex:0] objectForKey:@"state"];
         zipcodetxt.text = [[arr objectAtIndex:0] objectForKey:@"zipcode"];
    }
   
}
-(void)failure:(ASIFormDataRequest*)response
{
    NSLog(@"REPONSE %@",response);
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    UITextField *txt = (UITextField*)[self.view viewWithTag:ACTCUSTOMERCustomer];
    UIButton *txt2 = (UIButton*)[self.view viewWithTag:ACTCUSTOMERDate];
    UITextField *txt1 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERProject];
    UILabel *txt3 = (UILabel*)[self.view viewWithTag:ACTCUSTOMERTechinician];
    UITextField *txt4 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERAddress1];
    UITextField *txt5 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERAddress2];
    UITextField *txt6 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERScense];
    UITextField *txt7 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERPhone];
      UITextField *txt8 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERCITY];
      UITextField *txt9 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERSTATE];
      UITextField *txt10 = (UITextField*)[self.view viewWithTag:ACTCUSTOMERXIP];
    
    NSString *jsonStr = [NSString stringWithFormat:@"{\"cust_name\": \"%@\", \"date\":\"%@\", \"project\" :\"%@\", \"tech_id\": \"%@\", \"address_one\" : \"%@\", \"address_two\": \"%@\",\"license_num\": \"%@\",\"phone_num\": \"%@\",\"city\": \"%@\",\"state\": \"%@\",\"zip_code\": \"%@\"}",
                         [ACTAPP_DELEGATE emptyStr:txt.text],
                         [ACTAPP_DELEGATE emptyStr:txt2.titleLabel.text],
                         [ACTAPP_DELEGATE emptyStr:txt1.text],
                         [ACTAPP_DELEGATE emptyStr:txt3.text],
                         [ACTAPP_DELEGATE emptyStr:txt4.text],
                         [ACTAPP_DELEGATE emptyStr:txt5.text],
                         [ACTAPP_DELEGATE emptyStr:txt6.text],
                         [ACTAPP_DELEGATE emptyStr:txt7.text],
                         [ACTAPP_DELEGATE emptyStr:txt8.text],
                         [ACTAPP_DELEGATE emptyStr:txt9.text],
                         [ACTAPP_DELEGATE emptyStr:txt10.text]];
    
    
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.customerJson = jsonStr;
    [ACTAPP_DELEGATE setdate:updateVINDB.customerJson forkey:ACT_RELEASEFORM_CUSTOMER];
    [updateVINDB save];
        [super viewWillDisappear:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
       
    if(![string isEqualToString:@""])
    {
        if(textField == custtxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([custtxt.text length]+[string length]>20)
                return NO;
            else return YES;
        }
        if(textField == protxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([protxt.text length]+[string length]>20)
                return NO;
            else return YES;
        }
        if(textField == add1txt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([add1txt.text length]+[string length]>30)
                return NO;
            else return YES;
        }
        if(textField == add2txt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([add2txt.text length]+[string length]>30)
                return NO;
            else return YES;
        }
        if(textField == scensetxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([scensetxt.text length]+[string length]>10)
                return NO;
            else return YES;
        }
        if(textField == phonetxt)
        {
            if ([[self formatIdentificationNumber:string] isEqualToString:@""] && ![string isEqualToString:@""]) {
                return NO;
            }	
            if([phonetxt.text length]+[string length]>14)
                return NO;
            else return YES;
        }
    }
        
    return YES;
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
   NSMutableString *errormsg = [[NSMutableString alloc] init];
    if([custtxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the customer field\n"];
      
    if([datebtn.currentTitle length] == 0)
        [errormsg appendFormat:@"Please fill the date field\n"];
    if([protxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the project field\n"];
      
        if([add1txt.text length] == 0)
        [errormsg appendFormat:@"Please fill the address1 field\n"];
      
    if([scensetxt.text length] == 0)
        [errormsg appendFormat:@"Please fill the liscense field\n"];
       if([phonetxt.text length] == 0)
        [errormsg appendFormat:@"please fill the phone field\n"];
    if([citytxt.text length] == 0)
        [errormsg appendFormat:@"please fill the city field\n"];
    if([statetxt.text length] == 0)
        [errormsg appendFormat:@"please fill the state field\n"];
    if([zipcodetxt.text length] == 0)
        [errormsg appendFormat:@"please fill the zipcode field\n"];
        if(![errormsg isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errormsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{ 
       CarLeftViewController *sign =[[CarLeftViewController alloc]initWithNibName:@"CarLeftViewController" bundle:nil];
        [self.navigationController pushViewController:sign animated:YES];
        //[sign release];
   }
}
int textlength;
-(IBAction)changeText:(UITextField*)textfield
{
    NSString *str=textfield.text;
    if(str.length == 3 && str.length > textlength ){
        textfield.text=[NSString stringWithFormat:@"(%@)-",str];
    }
    else if(str.length ==9 && str.length > textlength)
    {
        NSString *su=[textfield.text substringFromIndex:6];
        NSString *fs=[textfield.text substringToIndex:6];
        textfield.text=[NSString stringWithFormat:@"%@%@-",fs,su];
    }
    
    textlength=str.length;
}
-(NSString *) numberformat:(NSString *) num
{
    NSCharacterSet *numberset = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    NSString  * result  = @"";
    NSScanner * scanner = [NSScanner scannerWithString:num];
    NSString  * scannerResult;
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd])
    {
        if([scanner scanUpToCharactersFromSet:numberset intoString:&scannerResult])
        {
            result = [result stringByAppendingString:scannerResult];
        }
        else
        {
            if(![scanner isAtEnd])
            {
                [scanner setScanLocation:[scanner scanLocation]+1];
            }
        }
    }
    
    return result;
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

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    Vehicle_releaseViewController *velh =[[Vehicle_releaseViewController alloc]initWithNibName:@"Vehicle_releaseViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
    //[velh release];
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

-(void)datepicker
{
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 300)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.date = [NSDate date];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ok)];
    NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
    
         UIViewController *pickView = [[UIViewController alloc] init];
        UIView* popoverView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, 330, 330)];
        popoverView.backgroundColor = [UIColor clearColor];
        [popoverView addSubview:toolbar];
        [popoverView addSubview:datepicker];
        
        pickView.view = popoverView;
        pickView.contentSizeForViewInPopover = CGSizeMake(330, 260);
        
               popoverController = [[UIPopoverController alloc]
                             initWithContentViewController:pickView];
        popoverController.delegate = self;
        
      
        [popoverController presentPopoverFromRect:CGRectMake(290, 160, 120, 120) inView:tableview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]   ;                              //release the popover content
        [pickView release];
        [popoverView release]; 
    [barbtn release];
        
   }
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    ACTReleaseNil(popoverController);
}

-(void) ok
{
   
    NSDateFormatter *datefr = [[NSDateFormatter alloc]init];
    [datefr setDateFormat:@"MM/dd/YYYY"];
    NSString *date = [datefr stringFromDate:datepicker.date];
    [datebtn setTitle:date forState:UIControlStateNormal];
    [yearbtn setTitle:date forState:UIControlStateNormal];
    [ACTAPP_DELEGATE setdate:date forkey:ACTCUSTOMERINFODate];
    [datefr release];
    [popoverController dismissPopoverAnimated:YES];
 }
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame
{
    UITextField *customField = [[UITextField alloc] initWithFrame:frame];
	//customField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame totallines:(int)lines
{
	UILabel *customLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
	//customLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = str;
    customLabel.numberOfLines = lines;
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.font=[UIFont fontWithName:@"Arial"size:16.0];
    customLabel.textColor=[UIColor blackColor];
    
	return customLabel;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
