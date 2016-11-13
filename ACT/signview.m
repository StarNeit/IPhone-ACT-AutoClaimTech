//
//  signview.m
//  PersonalInformation
//
//  Created by Innoppl Technologies on 01/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "signview.h"

@implementation signview

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if ((self = [super initWithFrame:frame])) {
     
        
        [self setBackgroundColor:[UIColor whiteColor]];
         
           }
    return self;
}
//- (id) initWithImage: (UIImageView *) anImage 
//{
//    
//    if ((self = [super initWithImage:anImage])) 
//    {
//        self.userInteractionEnabled = YES;
//    }
//    return self;
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     mouseMoved = 0;
    //NSLog(@"touch");
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
//	
//	if ([touch tapCount] == 2) {
//		self.image = nil;
//		return;
//	}
    
	lastPoint = [touch locationInView:self];
	lastPoint.y -= 5;
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	//NSLog(@"touchesMoved");
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self];
	currentPoint.y -= 5;
	
	
	UIGraphicsBeginImageContext(self.frame.size);
	[self.image drawInRect:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
	//CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
   // CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.8, 1.0);
    CGContextSetGrayStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 1.0);

	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
    
	mouseMoved++;
    
    
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
//	if ([touch tapCount] == 2) {
//		self.image = nil;
//		return;
//	}
//	if(!mouseSwiped) {
		UIGraphicsBeginImageContext(self.frame.size);
		[self.image drawInRect:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
		//CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
     CGContextSetGrayStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		self.image = UIGraphicsGetImageFromCurrentImageContext();

		UIGraphicsEndImageContext();
}


    
   /* UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *pngData = UIImagePNGRepresentation(img);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    
    NSLog(@"path %@",filePath);
    [pngData writeToFile:filePath atomically:YES];*/


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@"hi");
}


@end
