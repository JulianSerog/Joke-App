//
//  ViewController.h
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/16/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *viewLbl;
@property (weak, nonatomic) IBOutlet UILabel *jokeLbl;

@property (weak, nonatomic) IBOutlet UIButton *jokeBtn;

@property(strong,nonatomic) NSArray *categories;
@property(strong, nonatomic) NSString *url;

@end

