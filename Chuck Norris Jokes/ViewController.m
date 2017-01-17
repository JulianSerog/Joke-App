//
//  ViewController.m
//  Chuck Norris Jokes
//
//  Created by Esa Serog on 1/16/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"OBJECT: %@", [self getDataFrom:@"https://api.chucknorris.io/jokes/random"]);
    self.url = @"https://api.chucknorris.io/jokes/random";
    [self getDataFrom:self.url];
    
}

-(void) addUI {
    
    
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

- (IBAction)jokeBtnPressed:(id)sender {
    //TODO: check if joke is the same
    [self getDataFrom:self.url];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
