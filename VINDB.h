//
//  VINDB.h
//  ACT
//
//  Created by Lakshmanan V on 8/6/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "SQLitePersistentObject.h"
#import <Foundation/Foundation.h>

@interface VINDB : SQLitePersistentObject
{
    NSString *vinNumber;
    
    NSString *vehicleJson;
    NSString *customerJson;
    NSString *presigndate;
    NSUInteger isInspection;
    NSString *finaldate;
    NSString *releasePdr;
    NSString *releaseEstimate;
    NSString *releaseoverpdr;
    NSString *jsondata;
    
    
    NSString *pdfpath;
    NSUInteger isSaved;
    NSUInteger isSubmit;
    
    
    /* save Image */
    NSString *baseImgPath;
    NSString *rightCarView;
    NSString *leftCarView;
    NSString *topCarView;
    NSString *frontCarView;
    NSString *rearCarView;
    NSString *signatureview;
    NSString *finalsignature;
    NSUInteger damageCarImgCount;
    
    
    
}
@property(nonatomic,retain) NSString *vinNumber;
@property(nonatomic,retain) NSString *vehicleJson;
@property(nonatomic,retain) NSString *customerJson;
@property(nonatomic,retain) NSString *presigndate;
@property(nonatomic,retain) NSString *finaldate;
@property(nonatomic,retain) NSString *releasePdr;
@property(nonatomic,retain) NSString *releaseEstimate;
@property(nonatomic,retain) NSString *releaseoverpdr;
@property(nonatomic,retain) NSString *jsondata;
@property(nonatomic,retain) NSString *pdfpath;
@property(nonatomic,retain) NSString *baseImgPath;
@property(nonatomic,retain) NSString *rightCarView;
@property(nonatomic,retain) NSString *leftCarView;
@property(nonatomic,retain) NSString *topCarView;
@property(nonatomic,retain) NSString *frontCarView;
@property(nonatomic,retain) NSString *rearCarView;
@property(nonatomic,retain) NSString *signatureview;
@property(nonatomic,retain) NSString *finalsignature;


@property(nonatomic) NSUInteger isInspection;
@property(nonatomic) NSUInteger isSubmit;
@property(nonatomic) NSUInteger damageCarImgCount;
@property(nonatomic) NSUInteger isSaved;



@end
