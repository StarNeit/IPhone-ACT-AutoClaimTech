//
//  NotesViewController.m
//  ACT
//
//  Created by Innoppl Technologies on 19/07/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import "NotesViewController.h"

@implementation NotesViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    textview = [[UITextView alloc] initWithFrame:self.view.frame];
    textview.backgroundColor = [UIColor whiteColor];
    textview.textColor = [UIColor blackColor];
    textview.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [textview setTextContainerInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.view addSubview:textview];
    
    /*
     * This is the CANCEL button setup
     *
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"cancel_btn.png"] forState: UIControlStateNormal];
    [button addTarget:self  action:@selector(action:) forControlEvents:UIControlEventTouchUpInside ];
    [button setFrame:CGRectMake(0, 0, 64, 31)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3,5,64,31)];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMt" size:13]];
    [label setText:@"Cancel"];
    label.textAlignment = UITextAlignmentCenter;
    [label setTextColor:[UIColor clearColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [button addSubview:label];
    UIBarButtonItem *CancelBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    CancelBtn.tag = 100;
    self.navigationItem.leftBarButtonItem = CancelBtn;
    
    /*
     * This is the DONE button setup
     *
     */
    
    UIButton *button_b = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_b setImage:[UIImage imageNamed:@"done_btn.png"] forState: UIControlStateNormal];
    [button_b addTarget:self  action:@selector(action:) forControlEvents:UIControlEventTouchUpInside ];
    [button_b setFrame:CGRectMake(0, 0, 64, 31)];
    UILabel *label_b = [[UILabel alloc]initWithFrame:CGRectMake(3,5,64,31)];
    [label_b setFont:[UIFont fontWithName:@"Arial-BoldMt" size:13]];
    [label_b setText:@"Done"];
    label_b.textAlignment = UITextAlignmentCenter;
    [label_b setTextColor:[UIColor clearColor]];
    [label_b setBackgroundColor:[UIColor clearColor]];
    [button_b addSubview:label_b];
    UIBarButtonItem *DoneBtn = [[UIBarButtonItem alloc] initWithCustomView:button_b];
    
    DoneBtn.tag = 200;

    self.navigationItem.rightBarButtonItem = DoneBtn;
    
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *txt =  [ACTAPP_DELEGATE getUserDefault:ACT_Notes];
    if(txt)
    {
        textview.text = txt;
    }
    [super viewWillAppear:YES];
}

-(void)action:(UIBarButtonItem*)btn
{
    if(btn.tag == 200) [ACTAPP_DELEGATE setUserDefault:ACT_Notes setObject:textview.text];

    [self dismissModalViewControllerAnimated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc
{
    ACTReleaseNil(textview);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
