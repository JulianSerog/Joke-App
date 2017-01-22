//
//  FavoritesVC.m
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/21/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import "FavoritesVC.h"
#import "UIColor+CustomColors.h"

@interface FavoritesVC ()

@property(strong, nonatomic) NSUserDefaults *defaults;
@property(strong, nonatomic) NSMutableArray *savedJokes;

@end

@implementation FavoritesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init defaults
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    //get jokes from local storage
    [self getJokes];
    
    //set delegates and data source
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    //addUI
    [self addUI];
}//viewDidLoad

-(void) viewDidAppear:(BOOL)animated {
    [self getJokes];
    [self.tableView reloadData];
}//viewDidAppear

//used to retrieve jokes, called everytime view is loaded/appeared
-(void) getJokes {
    if ([self.defaults objectForKey:@"savedChuckNorrisJokes"] != nil) {
        self.savedJokes = [[self.defaults objectForKey:@"savedChuckNorrisJokes"] mutableCopy];
        [self.savedJokes addObject:@"helloworld"];
    } else {
        self.savedJokes = [[NSMutableArray alloc] init];
        [self.defaults setObject:self.savedJokes forKey:@"savedChuckNorrisJokes"];
    }//if/else
}//getJokes

//adds ui to view
-(void) addUI {
    [self.view setBackgroundColor:[UIColor customLightBlue]]; //set view of background
    //table view
    [self.tableView setBackgroundColor:[UIColor customLightBlue]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}//addUI


//MARK: table view methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.textLabel setText:[self.savedJokes objectAtIndex:indexPath.row]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedJokes.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
