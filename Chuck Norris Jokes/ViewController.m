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
    
    self.url = @"https://api.icndb.com/jokes/random?exclude=explicit";
    
    //[self getDataFrom:[self randomURL]]; //get a joke randomly from random list of provided categories
    [self getDataFrom:self.url];
}//viewDidLoad

-(void) addUI {
    //view background color
    [self.view setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    //view label
    [self.viewLbl setTextColor:[UIColor whiteColor]];
    
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
    
    
    //spinner
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}


//url connection
-(NSURLSession *) getURLSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    [self.spinner setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
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
            //NSLog(@"DATA: %@", data);
            
            
            
            //if data is not null, display joke, if it is null display an error message
            [self.spinner stopAnimating];
            [self.spinner removeFromSuperview];
            
            if (data != nil) {
                [self.jokeLbl setTextColor:[UIColor blackColor]];
                self.jokeLbl.text = [self parseJSONIntoJoke:data]; //set joke text
            } else {
                [self.jokeLbl setTextColor:[UIColor redColor]];
                self.jokeLbl.text = @"Please connect to internet for Chuck Norris jokes";
            }//else
        });//first block
    }];//second block
    
    [task resume];
}

-(NSString *) parseJSONIntoJoke:(NSData *) data {
    
    NSError *err;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    NSMutableString *joke = json[@"value"][@"joke"];
    //NSLog(@"JOKE: %@", joke);
    
    //string manipulation
    NSString *singleQuote = @"?";
    NSString *quote = @"&quot;";
    
    
    
    if ([joke containsString:quote]) {
        NSLog(@"JOKE CONTAINS QUOTE");
        joke = [[joke stringByReplacingOccurrencesOfString:quote withString:@"\""] mutableCopy];
    } else if([joke containsString:singleQuote]) {
        NSLog(@"JOKE CONTAINS SINGLE QUOTE");
        joke = [[joke stringByReplacingOccurrencesOfString:singleQuote withString:@"\'"] mutableCopy];
    }
    
    return joke;
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
