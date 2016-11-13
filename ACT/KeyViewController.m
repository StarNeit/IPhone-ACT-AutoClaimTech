//
//  KeyViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyViewController.h"
#import "ZBarSDK.h"
#import "SaveData.h"
#import "ListViewController.h"


@interface KeyViewController ()

@end

@implementation KeyViewController
@synthesize delegate;


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
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.tag = 200;
    keybtn.enabled = NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    [keybtn addTarget:self action:@selector(presskeypad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homebtn.enabled = NO;
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(presskeypad:) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled =NO;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingbtn];

    vintxt = [self customTextfield:@"Enter VIN" textName:@"Enter VIN" initFrame:CGRectMake(100, 200, 800, 100)];
    [self.view addSubview:vintxt];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillDisappear:(BOOL)animated
{
    vintxt.text = nil;
    [super viewWillDisappear:YES];
}

-(void)home
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)presskeypad:(UIButton*)sender
{
    [self dismissModalViewControllerAnimated:YES];
  //  [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}

-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame
{
	UITextField *customField = [[UITextField alloc] initWithFrame:frame];
	customField.delegate = self;
	customField.borderStyle = UITextBorderStyleRoundedRect;
	customField.clearButtonMode = UITextFieldViewModeWhileEditing;
	customField.clearsOnBeginEditing = NO;
	customField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
	customField.autocorrectionType = UITextAutocorrectionTypeNo;
	customField.enablesReturnKeyAutomatically = YES;
	customField.returnKeyType = UIReturnKeyGo;
	customField.placeholder = NSLocalizedString(str, nil);
	customField.keyboardType = UIKeyboardTypeDefault;
    customField.font = [UIFont fontWithName:@"Arial" size:34.0f];
    customField.textColor = [UIColor colorWithRed:52.0/256 green:112.0/256.0 blue:168.0/256.0 alpha:1.0];
    customField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    customField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   return customField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	//[textField resignFirstResponder];
    
    if([vintxt.text length] != 17)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"VIN should be 17 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else {
        if(! [SaveData saveDatainArray:vintxt.text forKey:ACT_SAVEVIN])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This VIN is already exist." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        else
        {
            [[self delegate] willAddDismissView:YES];  
            [self dismissModalViewControllerAnimated:YES];
        }
        return YES;

    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (![string isEqualToString:@""]) 
    {
    NSString *vincheck = @"[A-Z0-9]"; // Expression to validate vin 
    NSPredicate *regExpred =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", vincheck];
    BOOL myStringCheck = [regExpred evaluateWithObject:string];
    
        if ([textField.text length]+[string length] > 17) {
            return NO;
        }else
        {
            if (myStringCheck) 
                return YES;
            else
                return NO;
        }

    }else
    {
        return YES;
    }
    
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
