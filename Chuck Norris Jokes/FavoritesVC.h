//
//  FavoritesVC.h
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/21/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesVC : UIViewController  <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
