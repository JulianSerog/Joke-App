//
//  CustomTableCellTableViewCell.h
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/21/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property(strong, nonatomic) UIView *container;
@property(strong, nonatomic) UILabel *jokeLbl;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)layoutSubviews;


@end
