//
//  formSubmitViewController.h
//  ACT
//
//  Created by Innoppl Technologies on 15/08/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
#import "connectionRequest.h"
@protocol submitFormDelegate <NSObject>

@optional
-(void) didSubmit:(NSString*)status statusCode:(int)code;
-(void) networkError:(NSError*)error;

@end


@interface formSubmitViewController : UITableViewController
{
    id <submitFormDelegate> delegate;
    NSMutableArray *submitData;
    ASINetworkQueue *networkQueue;
    UIProgressView *progressView;
    UIView *headerView;
    UILabel *headerText;
    connectionRequest *form;
    
}

@property (retain) id delegate;


-(UILabel*) customlbl:(CGRect)frame addCell:(UITableViewCell*)cell;


-(void) initDownload;
-(BOOL) isFilePath:(NSString*)path;
@end
