//
//  connectionRequest.h
//  ACT
//
//  Created by Lakshmanan V on 8/19/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "formTableData.h"
#import "LANetworkConnect.h"

@protocol connectionFormDelegate <NSObject>

@optional
-(void) getStatus:(formTableData*)data;
-(void) updateStatus:(formTableData*)data removeIndex:(BOOL)check;
-(void) connectionError:(formTableData*)data isSchedule:(BOOL)status;
-(void) transactionDone:(NSString*)msg;
-(void) dismissView;
@end


@interface connectionRequest : NSObject
{
    formTableData *dataForm;
    id<connectionFormDelegate>delegate;
    ASIFormDataRequest *request;
    
}
@property (nonatomic,retain) formTableData *dataForm;
@property (retain) id delegate;


-(void) formRequest;
-(void) scheduledTransactions;
-(void) checkNetworkStatus;
-(void) addRequest:(VINDB*)vin;

-(BOOL) isFilePath:(NSString*)path;
@end
