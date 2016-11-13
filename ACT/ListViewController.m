//
//  ListViewController.m
//  ACT
//
//  Created by Innoppl Technologies on 01/08/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import "ListViewController.h"
#import "Vehicle_releaseViewController.h"
#import "NotesViewController.h"
#import "KeyViewController.h"
#import "SaveData.h"
#import "VINDB.h"
#import "ScanViewController.h"
#import "JSON.h"
#import "PDFViewController.h"
#import "PDRViewController.h"
#import "formSubmitViewController.h"


@implementation ListViewController
@synthesize vinnumber;
NSMutableArray *arrayofrow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
    UIImageView *bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bgview.frame = CGRectMake(0, 0, 1024, 768);
    [self.view addSubview:bgview];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 840, 500) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    //tableview.rowHeight = 70.0f;
    [self.view addSubview:tableview];
    
    UILabel *serialNo = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 70)];
    serialNo.text = @"S.No";
    serialNo.textColor = [UIColor whiteColor];
    serialNo.font = [UIFont fontWithName:@"Bodoni 72" size:28.0f];
    serialNo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:serialNo];
    
    UILabel *vinlbl = [[UILabel alloc] initWithFrame:CGRectMake(330, 50, 100, 70)];
    vinlbl.text = @"VIN";
    vinlbl.textColor = [UIColor whiteColor];
    vinlbl.font = [UIFont fontWithName:@"Bodoni 72" size:28.0f];
    vinlbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:vinlbl];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.tag = 200;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    [keybtn addTarget:self action:@selector(presskeypad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(scanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingbtn];
    
    submitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     submitbtn.enabled = NO;
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
    submitbtn.frame = CGRectMake(860, 500, 125, 42);
    [submitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];

    
    [self.view bringSubviewToFront:tableview];
    [self isEmpty];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void) scanButtonTapped
{
    if(arrayofrow.count < 10)
    {
        reader =  [ZBarReaderViewController new];
        // reader.readerView.frame = CGRectMake(0, 200, 1000, 400);
        reader.readerDelegate = self;
        if(UIInterfaceOrientationLandscapeRight)
        {
            reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationLandscapeRight);
        }
        else if(UIInterfaceOrientationLandscapeLeft)
        {
            reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationLandscapeLeft);
        }
        
        UIView *backgrdimage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        backgrdimage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgrdimage.contentMode = UIViewContentModeScaleToFill;
        //backgrdimage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"act_cam (1).png"]]; 
        [reader setCameraOverlayView:backgrdimage];
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_bg.png"]];
        bgImg.frame = backgrdimage.frame;
        bgImg.contentMode = UIViewContentModeScaleToFill;
        [backgrdimage addSubview:bgImg];
        // [reader.tabBarController.tabBar setHidden:YES ];
        
        ZBarImageScanner *scanner = reader.scanner;
        // TODO: (optional) additional reader configuration here
        
        // EXAMPLE: disable rarely used I2/5 to improve performance
        [scanner setSymbology: ZBAR_EAN13
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        
        // present and release the controller
        // reader.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController:reader animated: YES];
        [reader release];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have reached the limit." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release]; 
        
     }
}
- (void) imagePickerController: (UIImagePickerController*) reader  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
	ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
	
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    
    //  [ACTAPP_DELEGATE setUserDefault:ACTVIN setObject:symbol.data];
    
    if(! [SaveData saveDatainArray:symbol.data forKey:ACT_SAVEVIN])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This VIN is already exist." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES];
        ListViewController *release = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        release.vinnumber  = symbol.data;  
        [self.navigationController pushViewController:release animated:YES];  
        
    }
}

-(void) willAddDismissView:(BOOL)isNavigate
{
    
}

-(void) presskeypad
{
    if(arrayofrow.count < 10)
    {
        KeyViewController *key = [[KeyViewController alloc] initWithNibName:@"KeyViewController" bundle:nil];
        key.delegate = self;
        [self presentModalViewController:key animated:YES];         
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have reached the limit." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release]; 
    }
}
-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to go to Home page? You will lose any unsaved data." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag =300;
    [alert show];
    [alert release];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == 300 && buttonIndex == 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
    if(alertView.tag ==1000)
    {
        if(buttonIndex == 0)
        {
            [self performSelector:@selector(deleteRow:) withObject:remove];
        }
    }
  }
-(void)submit
{
    formSubmitViewController *submitForm = [[formSubmitViewController alloc] initWithStyle:UITableViewStyleGrouped ];
    submitForm.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:submitForm];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navi animated:YES];
}
-(void) didSubmit:(NSString*)status statusCode:(int)code
{
    if (code == 1) {
    submitbtn.enabled = NO;
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
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
    return [arrayofrow count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellidentifier"];
    cell.userInteractionEnabled =YES;
    if (cell != nil) {
        cell = nil;
    }
    if (cell==nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellidentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor blueColor];
    }
  
        if(arrayofrow>0)
         {
             VINDB *vindb = [arrayofrow objectAtIndex:indexPath.row];
             
             vin = [[UILabel alloc] init];
             vin.text = vindb.vinNumber;
             vin.frame = CGRectMake(180, 10, 330, 50);
             vin.tag = 100;
             vin.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbox.png"]];
             vin.textAlignment = UITextAlignmentCenter; 
             vin.font = [UIFont fontWithName:@"Bodoni 72" size:20.0f];
             vin.textColor = [UIColor colorWithRed:16.0/256 green:68.0/256.0 blue:105.0/256.0 alpha:1.0];
             [cell addSubview:vin];
             
             chkbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
             chkbtn1.tag = indexPath.row;
             chkbtn1.frame = CGRectMake(650, 10, 125, 42);
             [chkbtn1 setBackgroundImage:[UIImage imageNamed:@"checkin.png"] forState:UIControlStateNormal];
             [chkbtn1 addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
             [cell addSubview:chkbtn1];
             
             if(vindb.isSaved == 1)
             {
                 UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5.png"]];
                 checkmark.frame = CGRectMake(780, 10, 40, 40);
                 [cell addSubview:checkmark];            
             }
             else if(vindb.isSaved == 2)
             {
                 chkbtn1.enabled = NO;
             }
             
             deletebtn = [UIButton buttonWithType:UIButtonTypeCustom];
             deletebtn.frame = CGRectMake(120, 15, 39 , 39);
             deletebtn.tag = indexPath.row;
             [deletebtn setBackgroundImage:[UIImage imageNamed:@"delete(1).png"] forState:UIControlStateNormal];
             [deletebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
             [deletebtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
             [cell addSubview:deletebtn];
                         
             UILabel *serial = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 30, 30)];
             serial.backgroundColor = [UIColor clearColor];
             serial.textColor = [UIColor whiteColor];
             serial.font = [UIFont fontWithName:@"Bodoni 72" size:24.0f];
             serial.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
             [cell addSubview:serial];
         }  
        return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([SaveData isSubmitEnable])
        submitbtn.enabled = YES;
    else
        submitbtn.enabled = NO;
    
    NSString *base = [NSString stringWithFormat:@"/var/mobile/Applications/FC8C4965-EB38-427A-AECB-88BB7DE9F3C2/Documents/Photo/"];
    NSFileManager *fileMg = [NSFileManager defaultManager];
    NSLog(@"base path %@",[fileMg contentsOfDirectoryAtPath:base error:nil]);
    
    for (NSString *vin in [fileMg contentsOfDirectoryAtPath:base error:nil])
    {
        NSLog(@"files %@",[fileMg contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",base,vin] error:nil]);
    }
    
    
    
    [arrayofrow removeAllObjects];
    arrayofrow = [[NSMutableArray alloc] initWithArray:[VINDB allObjects]];
    [tableview reloadData];
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)checkbtn:(UIButton*)btn
{
    VINDB *vindb = [arrayofrow objectAtIndex:btn.tag];
    [ACTAPP_DELEGATE setUserDefault:ACTVIN setObject:vindb.vinNumber];
     [[ACTAPP_DELEGATE carimagearray] removeAllObjects];
    if(vindb.isSaved ==0)
    {
       
        Vehicle_releaseViewController *vehil = [[Vehicle_releaseViewController alloc] initWithNibName:@"Vehicle_releaseViewController" bundle:nil];
        vehil.vinnumber = vindb.vinNumber;
        [self.navigationController pushViewController:vehil animated:YES];

    }
    else
    {
        [self pdfpage];
    }
}
-(void) delete:(UIButton *)btn

{
  //  NSLog(@"rmove %d",btn.tag);
    remove = btn;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to delete?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 1000;
    [alert show];
    [alert release];
}
-(void)deleteRow:(UIButton*)btn
{
    // NSLog(@"btn.tag %d",btn.tag);
    VINDB *vindb = [arrayofrow objectAtIndex:btn.tag];
     // NSLog(@"savedata %@",vindb.vinNumber);
    [vindb deleteObject];
    [arrayofrow removeObjectAtIndex:btn.tag];
    [tableview reloadData];
    [self isEmpty];
    
}
-(void) isEmpty
{
    if([arrayofrow count] == 0)
    {
        submitbtn.enabled = NO;
    }
}
-(void) pdfpage
{
        int Page = [[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey] intValue];
        if(Page == 0)
        {
            PDRViewController *pdr = [[PDRViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:pdr animated:YES];
        }
        else
        {
            PDFViewController *pdf = [[PDFViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:pdf animated:YES];
        }
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
	//customField.placeholder = NSLocalizedString(str, nil);
	customField.keyboardType = UIKeyboardTypeDefault;
    customField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    customField.textColor = [UIColor blackColor];
    customField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    customField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
	return customField;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
