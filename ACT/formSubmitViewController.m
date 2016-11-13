//
//  formSubmitViewController.m
//  ACT
//
//  Created by Innoppl Technologies on 15/08/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import "formSubmitViewController.h"
#import "VINDB.h"
#import "SaveData.h"
#import "formTableData.h"

@implementation formSubmitViewController
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];

    submitData = [[NSMutableArray alloc] initWithArray:[VINDB allObjects]];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"price_bg.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 62, 27);
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [btn setTitle:@"Submit" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submitForm:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"price_bg_GREY4.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 0, 62, 27);
    btn1.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [btn1 setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = submit;
    
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(70, 120, 190, 10);
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 130)];
    headerView.backgroundColor = [UIColor clearColor];
    
    headerText = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, self.tableView.frame.size.width-100, 50)];
    headerText.font=[UIFont fontWithName:@"Arial"size:14.0];
    headerText.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
    headerText.numberOfLines = 2;

    [headerView addSubview:progressView];

}

-(void) cancel:(UIBarButtonItem*)btn
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) submitForm:(UIBarButtonItem*)btn
{
    btn.enabled = NO;
    headerText.text = @"Uploading please wait...";
   // self.tableView.tableHeaderView = headerView;
    
    [submitData removeAllObjects];
    [self.tableView reloadData];
    
    form = [[connectionRequest alloc] init];
    form.delegate = self;
    [form formRequest];

}
-(void) getStatus:(formTableData*)data
{
    [submitData addObject:data];
    [self.tableView reloadData];
}

-(void) updateStatus:(formTableData*)data removeIndex:(BOOL)check
{
    if (check) [submitData removeLastObject];
    [submitData addObject:data];
    [self.tableView reloadData];
}
-(void) connectionError:(formTableData*)data isSchedule:(BOOL)status
{
    [submitData addObject:data];
    [self.tableView reloadData];
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error alert : %@",data.title] message:ACT_NWERROR_Reschedule delegate:self cancelButtonTitle:@"Reschedule" otherButtonTitles:@"No,Thanks", nil];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error alert : %@",data.title] message:data.description delegate:self cancelButtonTitle:@"Reschedule" otherButtonTitles:@"No,Thanks", nil];
    alert.tag = 10;
    [alert show];
    [alert release];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog(@"index %d",buttonIndex);
    if(alertView.tag == 10)
    {
        if (buttonIndex == 0) {
            // schedule notification
            [ACTAPP_DELEGATE setUserDefault:ACT_RESCHEDULE setObject:@"yes"];
        }
        
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:1.0f];
    }
    if(alertView.tag == 20)
    {
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:0.0f];
        [self.delegate didSubmit:@"Job was successfully submitted." statusCode:1];

    }
}
-(void) transactionDone:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:ACT_NWJOBDONE_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 20;
    [alert show];
    [alert release];
}
-(void) dismissView
{
    
     [self dismissModalViewControllerAnimated:YES];
}

/*
- (void)submitComplete:(ASINetworkQueue *)queue
{
    //NSLog(@"Max: %f, Value: %f",);
}

- (void)submitFailed:(ASINetworkQueue *)queue
{
    NSLog(@"error %@", [queue debugDescription]);
}


-(void) finish:(ASIHTTPRequest*)request
{
    self.title = [NSString stringWithFormat:@"Uploading %d/%d",[networkQueue requestsCount],[submitData count]];
    VINDB *vinDB = [[request userInfo] objectForKey:@"VIN"];
   
    [SaveData removeVINByKey:vinDB.vinNumber];
    if ([networkQueue requestsCount] == 1)
    {
        [self.delegate didSubmit:@"Job was successfully submitted." statusCode:1];
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void) failure:(ASIHTTPRequest*)error
{
    NSError *err = [error error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:[err localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    alert = nil;
}*/

-(BOOL) isFilePath:(NSString*)path
{
    NSFileManager *filemng = [NSFileManager defaultManager];
    BOOL isDir = YES;
    // NSError *error;
    if([filemng fileExistsAtPath:path isDirectory:&isDir]) return YES;
    else return NO;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
	return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [submitData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell != nil) cell = nil;
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UILabel *title = [self customlbl:CGRectMake(22,4, 330, 35) addCell:cell];

       
    id vinClass = [submitData objectAtIndex:indexPath.row];
    
    if ([vinClass isKindOfClass:[VINDB class]]) {
        
        UILabel *status = [self customlbl:CGRectMake(345,6, 130, 35) addCell:cell];
        status.text = @"Waiting for upload";
        status.textColor = [UIColor lightGrayColor];
        [status setFont:ACT_LOGFONT(13.0)];
        
        VINDB *vinDB = [submitData objectAtIndex:indexPath.row];
        title.text = vinDB.vinNumber;
    }else
    {
        formTableData *log = [submitData objectAtIndex:indexPath.row];
        title.text = log.title;
        
        if (log.isProgress) {
           UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray
                                                    ];
            activityView.frame = CGRectMake(420.0f, 5.0f, 37.0f, 37.0f);
            [cell.contentView addSubview:activityView];
            [activityView startAnimating];
        }
        if (log.statusIcon) {
            UIImageView *bg = [[UIImageView alloc] initWithImage:log.statusIcon];
            bg.frame = CGRectMake(420.0f, 5, 24, 24);
            [cell.contentView addSubview:bg];
        }
        
    }
     [title release];
    // Configure the cell...
    
    return cell;
}

-(UILabel*) customlbl:(CGRect)frame addCell:(UITableViewCell*)cell
{
    UILabel *lbl=[[UILabel alloc] initWithFrame:frame];
    lbl.textColor=[UIColor blackColor];
    lbl.numberOfLines = 2;
    lbl.backgroundColor = [UIColor clearColor];
    [lbl setFont:ACT_LOGFONT(16.0)];
    [cell.contentView addSubview:lbl];
    return lbl;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
