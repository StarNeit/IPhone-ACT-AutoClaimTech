//
//  SaveData.h
//  ACT
//
//  Created by Lakshmanan V on 8/3/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveData : NSObject
{
    
    
}


/*-------- Saving VIN Info ----------*/
+ (BOOL) saveDatainArray:(NSString*)str forKey:(NSString*)key;
+ (NSArray*) getDatainArray:(NSString*)key;
+ (void) clearVIN:(NSString*)key;
+(BOOL)ChkVIN:(NSString*)str;


/*-------- Saving Car images ----------*/
+ (void) saveCarImg:(UIImage*)img forKey:(NSString*)key filename:(NSString*)name;
+ (UIImage*)getCarImg:(NSString*)key;

+(NSString*) createPath:(NSString*)str;
+(NSString*) saveimages:(UIImage*)img folderpath:(NSString*)path filename:(NSString*)name;



/*-------- Saving Car images ----------*/
+(NSString*) saveData:(NSString*)str forkey:(NSString*)key filename:(NSString*)name;


+ (void) removeVINByKey:(NSString*)key;
+(BOOL) isSubmitEnable;




@end
