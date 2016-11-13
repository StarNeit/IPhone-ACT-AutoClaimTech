//
//  CellView.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellView.h"

@implementation CellView

@synthesize btn1, btn2, btn3,label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      //  btn1.tag = 100;
        btn1.backgroundColor = [UIColor clearColor];
        btn1.frame = CGRectMake(100, 20, 220, 50);
        btn1.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn1];
        
        btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       // btn2.tag = 200;
        btn2.backgroundColor = [UIColor clearColor];
        btn2.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        btn2.frame = CGRectMake(400, 20, 120, 50);
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn2];
        
        btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn3.backgroundColor = [UIColor clearColor];
        btn3.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
       // btn3.tag = 300;
        btn3.frame = CGRectMake(610, 20, 120, 50);
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn3];
        
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"Arial" size:18.0f];
        label.textColor = [UIColor blackColor];
        label.text = @"($)";
        label.textAlignment = UITextAlignmentCenter;
        label.frame = CGRectMake(800,20,120,50);
        [self.contentView addSubview:label];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
