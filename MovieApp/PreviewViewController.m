//
//  ListViewController.m
//  MovieApp
//
//  Created by Peter Gikera on 22/07/2016.
//  Copyright © 2016 @iLabAfrica. All rights reserved.
//

#import "PreviewViewController.h"
#import "PreviewDataService.h"


@interface PreviewViewController ()

@end

@implementation PreviewViewController
@synthesize film=_film, filmPreview=_filmPreview, filmSaved = _filmSaved;

@synthesize imgPoster=_imgPoster, lblTitle=_lblTitle, lblDescription=_lblDescription;


- (void)viewDidLoad {
    [super viewDidLoad];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSString *imdbID;
    if (_film != nil) {
        
        imdbID = _film.imdbID;

    }else{
        imdbID = _filmSaved.imdbID;

    }
    
    NSString *urlParameter = [@"i=" stringByAppendingString:imdbID];
    
    [self fetchData:urlParameter];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fetchData:(NSString *)urlParameter{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        PreviewDataService *service = [[PreviewDataService alloc] init];
        
        _filmPreview = [service getFilmPreviewFromAPI:urlParameter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self designUI:_filmPreview];
            [self.view reloadInputViews];
        });
    });
    

}

-(void) designUI:(PreviewFilm *)preview{
    _lblTitle.text = [@"Title: " stringByAppendingString:preview.title];
    [_lblDescription setText:preview.plot];
    
    _imgPoster.image = [UIImage imageNamed:@"movie1"];

    // download the image asynchronously
    if (![preview.poster  isEqual: @"N/A"]) {
        [self downloadImageWithURL:[NSURL URLWithString:preview.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                _imgPoster.image = image;
                
            }
        }];
    }
    

    
}

- (IBAction)bookmarkFilm:(id)sender {
    // Add Entry to PhoneBook Data base and reset all fields
    //  1
    Movie * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:self.managedObjectContext];
    
    //  2
    
    newEntry.title = self.film.title;
    newEntry.imdbID = self.film.imdbID;
    newEntry.type = self.film.type;
    newEntry.poster = self.film.poster;
    
    
    //  3
    NSError *error;
    Boolean isSaved = [self.managedObjectContext save:&error];
    if (!isSaved) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }else{
        
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Bookmark Film" message:@"Film saved successfully..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}



@end
