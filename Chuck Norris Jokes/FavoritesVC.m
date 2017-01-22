//
//  FavoritesVC.m
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/21/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import "FavoritesVC.h"
#import "UIColor+CustomColors.h"
#import "CustomTableCell.h"

@interface FavoritesVC ()

@property(strong, nonatomic) NSUserDefaults *defaults;
@property(strong, nonatomic) NSMutableArray *savedJokes;
@property(strong, nonatomic) UILabel *noSavedJokesLbl;

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
    [self checkForJokes];
}//viewDidAppear

//used to retrieve jokes, called everytime view is loaded/appeared
-(void) getJokes {
    if ([self.defaults objectForKey:@"savedChuckNorrisJokes"] != nil) {
        self.savedJokes = [[self.defaults objectForKey:@"savedChuckNorrisJokes"] mutableCopy];
    } else {
        self.savedJokes = [[NSMutableArray alloc] init];
        [self.defaults setObject:self.savedJokes forKey:@"savedChuckNorrisJokes"];
    }//if/else
}//getJokes

//adds ui to view
-(void) addUI {
    [self.view setBackgroundColor:[UIColor customLightBlue]]; //set view of background
    
    //no saved notes lbl
    self.noSavedJokesLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.4, self.view.frame.size.width, self.view.frame.size.height * 0.2)];
    self.noSavedJokesLbl.text = @"No currently have no saved jokes!";
    [self.noSavedJokesLbl setTextAlignment:NSTextAlignmentCenter];
    [self.noSavedJokesLbl setTextColor:[UIColor whiteColor]];
    [self checkForJokes];
    
    //table view
    [self.tableView setBackgroundColor:[UIColor customLightBlue]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}//addUI

-(void) checkForJokes {
    if (self.savedJokes.count == 0) {
        [self.view addSubview:self.noSavedJokesLbl];
    } else {
        [self.noSavedJokesLbl removeFromSuperview];
    }
}

//TODO: add swipe left gestures to delete cells


/*
-(void) removeCell{
    
}
*/

//MARK: table view methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableCell *cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cusTableCell"];
    
    /*
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(removeCell)];
    [swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    */
    [cell.jokeLbl setText:[self.savedJokes objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.savedJokes removeObjectAtIndex:indexPath.row];
        [self.defaults setObject:self.savedJokes forKey:@"savedChuckNorrisJokes"];
        [self.tableView reloadData];
        [self checkForJokes];
    }//if
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //sub view
    UIView *jokeView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.2, self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.6)];
    [jokeView setBackgroundColor:[UIColor whiteColor]];
    [jokeView.layer setCornerRadius:8.0];
    [jokeView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [jokeView.layer setBorderWidth:1.0];
    //label for sub view
    UILabel *innerViewLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, jokeView.frame.size.width, jokeView.frame.size.height)];
    [innerViewLbl setTextAlignment:NSTextAlignmentCenter];
    innerViewLbl.text = self.savedJokes[indexPath.row];
    [innerViewLbl setNumberOfLines:13];
    
    [jokeView addSubview:innerViewLbl];
    
    [self.view addSubview:jokeView];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedJokes.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
