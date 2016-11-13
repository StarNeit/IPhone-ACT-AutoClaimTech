//
//  KeypadViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeypadViewController.h"
#import "Vehicle_releaseViewController.h"
#import "ASIFormDataRequest.h"

@interface KeypadViewController ()

@end

@implementation KeypadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSMutableArray *array;

- (void)viewDidLoad
{
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.tag = 200;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
     [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    [keybtn addTarget:self action:@selector(presskeypad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    [enterbtn addTarget:self action:@selector(Enter) forControlEvents:UIControlEventTouchUpInside];
    [gobtn addTarget:self action:@selector(Go) forControlEvents:UIControlEventTouchUpInside];
    [gobtn1 addTarget:self action:@selector(Go) forControlEvents:UIControlEventTouchUpInside];
    
    array = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil]];
    
    for (int i = 100; i<133; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        [btn addTarget:self action:@selector(keyaction:) forControlEvents:UIControlEventTouchUpInside];
    }

    [super viewDidLoad];
}
-(void)presskeypad:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    /*[self.navigationController setNavigationBarHidden:YES];
     KeypadViewController *key = [[KeypadViewController alloc] initWithNibName:@"KeypadViewController" bundle:nil];
     [self.navigationController pushViewController:key animated:YES];*/
    /* if([sender tag] == 200){
     [self.view addSubview:keypad];
     keypad.hidden =NO;
     sender.tag = 201;
     }
     else if([sender tag] == 201){
     keypad.hidden = YES;
     sender.tag = 200;
     }*/
    
}
-(void)Go

{
    [self callWebService];
   
      
}
- (void) callWebService
{
   
   /* NSString *postData = @"/&pinNum=1011/"@"/&processName";
   HTTP *connectServer = [[HTTP alloc] init];
   connectServer.delegate = self;
    [connectServer post:@"http://184.173.236.40/~innoppl/act_app/index.php/technician/processSel/format/json" postData:postData];*/
    
     NSURL *url = [NSURL URLWithString:@"http://184.173.236.40/~innoppl/act_app/index.php/technician/processSel/format/json"];
ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
[request setRequestMethod:@"POST"];
[request setDelegate:self];
[request addPostValue:@"1011" forKey:@"pinNum"];
[request addPostValue:@"1011" forKey:@"processName"];
[request setDidFinishSelector:@selector(finish:)];
[request setDidFailSelector :@selector(failure:)];    
[request startSynchronous];

}
-(void)finish:(ASIFormDataRequest*)response
{
    NSLog(@"res %@",[response responseString]);
    [self.navigationController setNavigationBarHidden:YES];
    Vehicle_releaseViewController *release = [[Vehicle_releaseViewController alloc] initWithNibName:@"Vehicle_releaseViewController" bundle:nil];
    release.vinnumber  = vintxt.text;  
    [self.navigationController pushViewController:release animated:YES];  

    }
-(void)failure:(ASIFormDataRequest*)response
{
    
}


-(void)keyaction:(UIButton *)btn
{
    vintxt.text = [NSString stringWithFormat:@"%@%@",vintxt.text,[array objectAtIndex:btn.tag-100]];
    //[self.view addSubview:keypad];
    
    NSLog(@"keyvalue %@",[array objectAtIndex:btn.tag-100]);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation!=UIInterfaceOrientationPortrait);
}

@end
