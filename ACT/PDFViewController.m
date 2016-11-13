//
//  PDFViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PDFViewController.h"
//#import "PDFService.h"
#import "CreatePDF.h"
#import "signViewController.h"
#import "JSON.h"
#import "config.h"
#import "VINDB.h"
#import "SaveData.h"
#import "formSubmitViewController.h"
#import "ListViewController.h"
#import "Over_ViewController.h"
#import "ViewController.h"
@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - View lifecycle
NSString *path;
- (void)viewDidLoad
{

     VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    NSString *base = [NSString stringWithFormat:@"/var/mobile/Applications/5076B0DE-4DB0-4245-901C-4BC686F943C8/Documents/Photo/"];

    NSFileManager *fileMg = [NSFileManager defaultManager];
    NSLog(@"base path %@",[fileMg contentsOfDirectoryAtPath:base error:nil]);

   
    for (VINDB *vin in [VINDB allObjects])
    {
        NSString *imgPath = vin.baseImgPath;
        NSLog(@"vin %@ files %@",vin.vinNumber, [fileMg contentsOfDirectoryAtPath:imgPath error:nil]);
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:updatedimg.baseImgPath error:nil];
                            
    [self.navigationController setNavigationBarHidden:YES];
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    path = [[NSString alloc] initWithFormat:@"%@",[[arrayPaths objectAtIndex:0] stringByAppendingPathComponent:@"test.pdf"]];
    NSString *documentsPath = [arrayPaths objectAtIndex:0]; //Get the docs directory
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 700, 748)];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HOMEBACKGROUND.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"Home_button.png"] forState:UIControlStateNormal];
    homebtn.frame = CGRectMake(800, 140, 125, 42);
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    signbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signbtn setBackgroundImage:[UIImage imageNamed:@"sign.png"] forState:UIControlStateNormal];
    signbtn.frame = CGRectMake(800, 210, 125, 42);
    [signbtn addTarget:self action:@selector(signView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signbtn];
    
    printbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    printbtn.enabled = NO;
    [printbtn setBackgroundImage:[UIImage imageNamed:@"print.png"] forState:UIControlStateNormal];
    printbtn.frame = CGRectMake(800, 280, 125, 42);   
    [printbtn addTarget:self action:@selector(printTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printbtn];

    submitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
   //s submitbtn.enabled = NO;
    [submitbtn setBackgroundImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
    submitbtn.frame = CGRectMake(800, 350, 125, 42);
    [submitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];
    
    savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.enabled = NO;
    [savebtn setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    savebtn.frame = CGRectMake(800, 420, 125, 42);
    [savebtn addTarget:self action:@selector(saveJsonData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    
    sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharebtn.enabled = NO;
    [sharebtn setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    sharebtn.frame = CGRectMake(800, 490, 125, 42);
    [sharebtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebtn];
    
    isprint = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Callpdf:) name:@"pdfgenerate" object:nil];
    
    [self.view addSubview:web];
    
    if ([SaveData isSubmitEnable]) 
        submitbtn.enabled = YES;
    else
        submitbtn.enabled = NO;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(createPDFFile) withObject:nil afterDelay:0.2];
     [self performSelector:@selector(loadPDFFile) withObject:nil afterDelay:0.5];
}
-(void)printTapped
{
    Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
    
    if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
        
    {
        NSData *myData = [NSData dataWithContentsOfFile:path];
        UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
        print.delegate = self;
        UIPrintInfo *printInfo = [NSClassFromString(@"UIPrintInfo") printInfo];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printInfo.outputType = UIPrintInfoOutputGeneral;
        print.printInfo = printInfo;
        print.printingItem = myData;
        print.showsPageRange = YES;
        UIViewPrintFormatter *viewFormatter = [self.view viewPrintFormatter];
        viewFormatter.startPage = 0;
        print.printFormatter = viewFormatter;
        
        UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {};         
        //[print presentAnimated:YES completionHandler:completionHandler];      
        [print presentFromRect:printbtn.frame inView:self.view animated:YES completionHandler:completionHandler];
    }
}
- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
    
}
- (void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController{
}
-(void) share
{
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    if (email==nil) {
        return;
    }
    email.mailComposeDelegate = self;
    NSData *emaildata = [NSData dataWithContentsOfFile:path];
    NSString *vinStr = [NSString stringWithFormat:@"%@.pdf",[ACTAPP_DELEGATE getUserDefault:ACTVIN]];
    [email addAttachmentData:emaildata mimeType:@"application/pdf" fileName:vinStr];
    [email setMailComposeDelegate:self];
    [self presentModalViewController:email animated:YES];
    [email release];

}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[self dismissModalViewControllerAnimated:YES];
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
            [self alertview:@"Cancelled"];
			break;
		case MFMailComposeResultSaved:
            [self alertview:@"Saved"];
			break;
		case MFMailComposeResultSent:
            [self alertview:@"Email sent successfully."];
			break;
		case MFMailComposeResultFailed:
            [self alertview:@"Failed"];
			break;
		default:
            [self alertview:@"Not sent"];
			break;
	}
	
}
-(void) alertview:(NSString*)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}


-(BOOL) isFilePath:(NSString*)path
{
    NSFileManager *filemng = [NSFileManager defaultManager];
    BOOL isDir = YES;
    // NSError *error;
    if([filemng fileExistsAtPath:path isDirectory:&isDir]) return YES;
    else return NO;
}

-(void) saveJsonData
{
    VINDB *saveJson = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    NSString *json1 = saveJson.vehicleJson;
    NSString *json2 = saveJson.customerJson;
    NSString *json3 = saveJson.releasePdr;
    NSString *json4 = saveJson.releaseEstimate;
    NSString *overstr = saveJson.releaseoverpdr;
    
    NSRange rangelost = NSMakeRange(0, [json3 length]-1);
    NSRange rangefirst = NSMakeRange(1, [json3 length]-1);    
    NSRange rangeval = NSIntersectionRange(rangefirst, rangelost);
    
    NSString *str1 =[ACTAPP_DELEGATE emptyStr:[json3 substringWithRange:rangeval]];
    if (json4) {
        json4 = [NSString stringWithFormat:@"\"releasePdrSum\":[%@]",json4];
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSArray *val;
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:ACTLoginDetails];
    NSString *techid = [[val objectAtIndex:0] objectForKey:@"tech_id"];
    
    NSString *signdate1;
    int isPage = [[ACTAPP_DELEGATE getUserDefault:ACTPageSign] intValue];
    
    int inspection;
    if (isPage == 1) {
      //  signdate1 = [ACTAPP_DELEGATE emptyStr:saveJson.presigndate];
        inspection = 1;
    }
    else
    {
        //signdate1 = [ACTAPP_DELEGATE emptyStr:saveJson.presigndate];
        inspection = 0;
    }

    signdate1 = [ACTAPP_DELEGATE emptyStr:saveJson.presigndate];
    NSString *techstr = [ACTAPP_DELEGATE emptyStr:techid];
    NSString *typestr = [ACTAPP_DELEGATE emptyStr:[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey]];
    NSString *signdate3 = [ACTAPP_DELEGATE emptyStr:saveJson.finaldate];
    NSString *str2 = [ACTAPP_DELEGATE emptyStr:json4];
    
    NSString *json5 = @"";
    if ([str1 length] != 0) {
        json5 = [NSString stringWithFormat:@",%@,%@",str1,str2];
    }
    
    if (overstr) {
        overstr = [NSString stringWithFormat:@",\"releasePdrOversize\":[%@]",overstr];
    }else
        overstr = @"";
    
    NSString *jsonstr = [NSString stringWithFormat:@"{\"custom_pic_count\":\"%d\",\"tech_id\":\"%@\",\"type\":\"%@\",\"releaseVehicle\":[%@],\"releaseCustomer\":[%@],\"pre_sign_date\":\"%@\",\"inspection_accepted\":\"%d\",\"final_sign_date\":\"%@\"%@ %@}",saveJson.damageCarImgCount,techstr,typestr,json1,json2,signdate1,inspection,signdate3,overstr,json5];
   // NSLog(@"finalstr %@",jsonstr);
    
    BOOL Isjson = [jsonstr JSONValue];
   
    if (Isjson) {
        saveJson.jsondata = jsonstr;
        saveJson.isSaved = 2;
        [saveJson save];
        savebtn.enabled = NO;
        
        if ([SaveData isSubmitEnable])
            submitbtn.enabled = YES;
        else
            submitbtn.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Job was successfully saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 200;
        [alert show];
        [alert release];
        
    }
}

-(void) didSubmit:(NSString*)status statusCode:(int)code
{
    if (code == 1) {
        submitbtn.enabled = NO;
        for(UIViewController *view in self.navigationController.viewControllers)
        {
            if ([view isKindOfClass:[ViewController class]]) 
            {
                [self.navigationController popToViewController:view animated:YES];
                
            }
        }
    }
}
-(void) networkError:(NSError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    alert = nil;
}
-(void)submit
{
    
    formSubmitViewController *submitForm = [[formSubmitViewController alloc] initWithStyle:UITableViewStyleGrouped ];
    submitForm.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:submitForm];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navi animated:YES];
    return;
}
-(void)finish:(ASIHTTPRequest*)response
{
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    if([response responseStatusCode]==200)
    {
        UIAlertView *sucess = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Job was uploaded successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        sucess.tag = 100;
        [sucess show];
        [sucess release];
    }
}
-(void)failure:(ASIHTTPRequest*)response
{
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    UIActionSheet *stat = [[UIActionSheet alloc] 
						   initWithTitle:[NSString stringWithFormat:@"Unable to connect to the server, please ensure you are connected to the internet."] 
						   delegate:self 
						   cancelButtonTitle:@"Ok"
						   destructiveButtonTitle:nil
						   otherButtonTitles:nil];
    [stat showInView:self.view];
    [stat release];
}

-(void)Callpdf:(NSNotification*)sender
{
    [self createPDFFile];
    [self loadPDFFile];
}

-(void) signView {
    
    signViewController *viewcontroller = [[signViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
    [self presentModalViewController:navigation animated:YES];    
}

-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to go to Home page? You will lose any unsaved data" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag =300;
    [alert show];
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == 300 && buttonIndex == 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];        
    }
    if(alertView.tag == 100)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    if(alertView.tag == 200)
    {
        if (![SaveData isSubmitEnable]) 
        {
            for(UIViewController *view in self.navigationController.viewControllers)
            {
                if ([view isKindOfClass:[ListViewController class]]) 
                {
                    [self.navigationController popToViewController:view animated:YES];

                }
                
            }
        }
    }
}
- (void)createPDFFile
{
    
    pdf = [[CreatePDF alloc] init] ;
    
    VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    
    if(updatedimg.finalsignature)
    {
        signbtn.enabled = NO;
        printbtn.enabled = YES;
        sharebtn.enabled = YES;
        savebtn.enabled = YES;
    }
     else
    {
        signbtn.enabled = YES;
        printbtn.enabled = NO;
        sharebtn.enabled = NO;
        savebtn.enabled = NO;
    }

}
- (void)loadPDFFile
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    
}
#pragma mark -
#pragma mark delegate method

/*
- (void)service:(PdfGenerationDemoViewController *)service
didFailedCreatingPDFFile:(NSString *)filePath
        errorNo:(HPDF_STATUS)errorNo
       detailNo:(HPDF_STATUS)detailNo
{
    NSString *message = [NSString stringWithFormat:@"Couldn't create a PDF file at %@\n errorNo:0x%04x detalNo:0x%04x",
                         filePath,
                         errorNo,
                         detailNo];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"PDF creation error"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc
{
    ACTReleaseNil(pdf);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
@end

