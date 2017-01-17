//
//  ViewController.m
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/16/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import "NSArray+Random.h" //for random object in NSArray
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI]; //add ui
    
    self.categories = [[NSArray alloc] initWithObjects:@"dev",@"movie",@"food",@"celebrity",@"science",@"political",@"sport",@"animal",@"music",@"history",@"travel",@"career",@"money",@"fashion", nil];
    
    self.url = @"https://api.chucknorris.io/jokes/random";
    
    //[self getDataFrom:[self randomURL]]; //get a joke randomly from random list of provided categories
    [self getDataFrom:self.url];
}//viewDidLoad

-(void) addUI {
    [self.view setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1.0]];
    //joke label/container
    [self.jokeLbl setClipsToBounds:YES];
    [self.jokeLbl setBackgroundColor:[UIColor whiteColor]];
    [self.jokeLbl.layer setCornerRadius:8.0];
    
    
    //addjoke button
    [self.jokeBtn setClipsToBounds:YES];
    [self.jokeBtn.layer setCornerRadius:8.0];
    [self.jokeBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.jokeBtn.layer setBorderWidth:1.0];
    [self.jokeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


//url connection
-(NSURLSession *) getURLSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once( &onceToken,
                  ^{
                      NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:config];
                  });
    return session;
}

- (void) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]]; //pass the GET url through here
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@", result);
            self.jokeLbl.text = [self parseJSONIntoJoke:data]; //set joke text
        });//first block
    }];//second block
    
    [task resume];
}

-(NSString *) parseJSONIntoJoke:(NSData *) data {
    
    NSError *jsonError;
    NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    return [parsedJSONArray valueForKey:@"value"];
}


-(NSString *) randomURL {
    NSMutableString *randomUrl = [[NSMutableString alloc] initWithString:@"https://api.chucknorris.io/jokes/random?category={"];
    [randomUrl appendString:[self.categories randomObject]];
    [randomUrl appendString:@"}"];
    return randomUrl;
}

- (IBAction)btnPressed:(id)sender {
    //TODO: check if joke is the same
    //[self getDataFrom:[self randomURL]];
    [self getDataFrom:self.url]; //get a joke randomly from random list of provided categories
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
