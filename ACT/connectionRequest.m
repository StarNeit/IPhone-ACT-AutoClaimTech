//
//  connectionRequest.m
//  ACT
//
//  Created by Lakshmanan V on 8/19/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "connectionRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "SaveData.h"
#import "VINDB.h"
@implementation connectionRequest
@synthesize dataForm;
@synthesize delegate;

- init {
	if ((self = [super init])) {
 		
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}


- (void)setDelegate:(id)val
{
	delegate = val;
}

- (id)delegate
{
	return delegate;
}

-(void) formRequest
{
    formTableData *data = [[formTableData alloc] init];   
    data.title = ACT_LOGSTEP1;
    [[self delegate] getStatus:data];
    [self performSelector:@selector(checkNetworkStatus) withObject:nil afterDelay:1.0f];
}

-(void) checkNetworkStatus
{
    NSDictionary *statusDict = [LANetworkConnect checkNetworkStatus];
    
    int code = [[statusDict objectForKey:@"code"] intValue];
    if (code == 0) {
        formTableData *data = [[formTableData alloc] init];   
        data.title = [statusDict objectForKey:@"msg"];
        data.statusIcon = ACT_LOGERROR_ICON;
        [[self delegate] connectionError:data isSchedule:YES];
        return;
    }else
    {
        formTableData *data = [[formTableData alloc] init];   
        data.title = [statusDict objectForKey:@"msg"];
        data.statusIcon = ACT_LOGOK_ICON;
        [[self delegate] getStatus:data];
    }
    
    [self performSelector:@selector(scheduledTransactions) withObject:nil afterDelay:1.0f];
}

-(void) scheduledTransactions
{
    formTableData *data = [[formTableData alloc] init];   
    if ([[VINDB allObjects] count] == 1) data.title = ACT_LOGSTEP2([[VINDB allObjects] count]);
    else data.title = ACT_LOGSTEPS2([[VINDB allObjects] count]);
    [[self delegate] getStatus:data];
    
    for (VINDB *vin in [VINDB allObjects]) 
    {
       // NSLog(@"vin No %@ json %@ issave %d",vin.vinNumber,vin.jsondata,vin.isSaved); 
    }
    [self performSelector:@selector(submitForm) withObject:nil afterDelay:1.0f];
}
-(void) submitForm
{    
    int count = 0;
    for (VINDB *vin in [VINDB allObjects]) 
    {
        if (count == 0) 
        {
            formTableData *data = [[formTableData alloc] init]; 
            data.title = [NSString stringWithFormat:@"Uploading VIN : %@",vin.vinNumber];
            data.isProgress = 1;
            [[self delegate] getStatus:data];
            
            [self performSelector:@selector(addRequest:) withObject:vin afterDelay:0.8];

        }
        count ++;
    }
}
-(void) addRequest:(VINDB*)vin
{
   // NSLog(@"vin %@",vin.jsondata);
    
    //NSString *string = @"http://192.168.1.25/crm/index.php/webservice/insertTable";
    NSString *path = @"";
    request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:ACT_Sumbit]];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request setTimeOutSeconds:160.0f];
    [request setPostValue:vin.jsondata forKey:@"data"];
    NSLog(@"vin.jsondata %@",vin.jsondata);
    [request setUserInfo:[NSDictionary dictionaryWithObject:vin forKey:@"VIN"]];
    request.shouldPresentCredentialsBeforeChallenge = YES;
    [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
    [request setDidFinishSelector:@selector(finish:)];
    [request setDidFailSelector :@selector(failure:)]; 
    
    path = vin.signatureview;
    if ([self isFilePath:path]) [request setFile:path forKey:@"pre_sign"];
    
    path = vin.rightCarView;
    if([self isFilePath:path])  [request setFile:path forKey:@"right_view"];
    
    path = vin.leftCarView;
    if([self isFilePath:path])  [request setFile:path  forKey:@"left_view"];    
    
    path = vin.frontCarView;
    if([self isFilePath:path])  [request setFile:path forKey:@"front_view"];
    
    path = vin.rearCarView;
    if([self isFilePath:path])  [request setFile:path  forKey:@"rear_view"];
    
    path = vin.topCarView;
    if([self isFilePath:path])  [request setFile:path  forKey:@"top_view"];
    
    path = vin.finalsignature;
    if([self isFilePath:path])  [request setFile:path  forKey:@"final_sign"];
    
    for (int i=1; i<vin.damageCarImgCount+1; i++) 
    {
        NSString *image1 =  [NSString stringWithFormat:@"%@/custom_pic_%d.jpg",vin.baseImgPath,i];
        if([self isFilePath:image1])
            [request setFile:image1 forKey:[NSString stringWithFormat:@"custom_pic_%d",i]];
        else 
            NSLog(@"not found %@",image1);
    }
    [request startAsynchronous];
}


- (void)finish:(ASIFormDataRequest *)response
{
    NSLog(@"res %@",[response responseString]);
    NSLog(@"vin No %@",[[[response userInfo] objectForKey:@"VIN"] vinNumber]);
    NSDictionary *dic = [[response responseString] JSONValue] ;
   
        //if([response responseStatusCode] == 200)
        if([[dic objectForKey:@"status"] intValue] == 1)
        {
            VINDB *vinDB = [[response userInfo] objectForKey:@"VIN"];
            formTableData *data = [[formTableData alloc] init];   
            data.title = [NSString stringWithFormat:@"%@ successfully uploaded",vinDB.vinNumber];
            data.statusIcon = ACT_LOGOK_ICON;
            [[self delegate] updateStatus:data removeIndex:YES];

            [SaveData removeVINByKey:vinDB.vinNumber];
            
            if ([[VINDB allObjects] count] > 0) {
                [self performSelector:@selector(submitForm) withObject:nil afterDelay:5.0];
            }else
            {
                [[self delegate] transactionDone:@"yes"];
            }
    }else
    {
        formTableData *data = [[formTableData alloc] init];
        data.title = @"error";
        data.statusIcon = ACT_LOGERROR_ICON;
        data.description = [dic objectForKey:@"message"];
        [[self delegate] connectionError:data isSchedule:NO];
    }
}

- (void)failure:(ASIFormDataRequest *)response
{
    NSError *err = [response error];
    NSLog(@"err %@",[err localizedDescription]);
    formTableData *data = [[formTableData alloc] init];   
    data.title = [err localizedDescription];
    data.statusIcon = ACT_LOGERROR_ICON;
    [[self delegate] connectionError:data isSchedule:YES];
}

-(BOOL) isFilePath:(NSString*)path
{
    NSFileManager *filemng = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if([filemng fileExistsAtPath:path isDirectory:&isDir]) return YES;
    else return NO;
}


@end
