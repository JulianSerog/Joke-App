//
//  CustomTableCellTableViewCell.m
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/21/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import "CustomTableCell.h"
#import "UIColor+CustomColors.h"

@implementation CustomTableCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    //set properties
    [self setBackgroundColor:[UIColor customLightBlue]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    //container
    self.container = [[UILabel alloc] init];
    [self.container setBackgroundColor:[UIColor whiteColor]];
    self.container.layer.cornerRadius = 8.0;
    [self.container.layer setMasksToBounds:YES];
    [self addSubview:self.container];
    
    //label
    self.jokeLbl = [[UILabel alloc] init];
    [self.jokeLbl setTextColor:[UIColor blackColor]];
    [self.container addSubview:self.jokeLbl];
    
    return self;
}//initWithStyle


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.container setFrame:CGRectMake(self.frame.size.width * 0.025, self.frame.size.height * 0.05, self.frame.size.width * 0.95, self.frame.size.height * 0.9)];
    [self.jokeLbl setFrame:CGRectMake(5, 5, self.container.frame.size.width - 10, self.container.frame.size.height - 10)];
}//layoutSubviews
@end
