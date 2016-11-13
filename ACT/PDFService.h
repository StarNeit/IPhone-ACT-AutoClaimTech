//
//  PDFService.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hpdf.h"

@class PDFService;


#pragma mark -
#pragma mark PDFServiceDelegate 


@protocol PDFServiceDelegate
- (void)service:(PDFService *)service
didFailedCreatingPDFFile:(NSString *)filePath
        errorNo:(HPDF_STATUS)errorNo
       detailNo:(HPDF_STATUS)detailNo;
@end


#pragma mark -
#pragma mark PDFService


@interface PDFService : NSObject {
    id <PDFServiceDelegate> delegate;
}

+ (PDFService *)instance;
- (void)createPDFFile:(NSString *)filePath fullDict:(NSMutableDictionary*)dict;

@property (nonatomic, assign) id<PDFServiceDelegate> delegate;

@end


#pragma mark -
#pragma mark C functions and structures


typedef struct _PDFService_userData {
    HPDF_Doc pdf;
    PDFService *service;
    NSString *filePath;
} PDFService_userData;

void PDFService_errorHandler(HPDF_STATUS   error_no,
                             HPDF_STATUS   detail_no,
                             void         *user_data);

