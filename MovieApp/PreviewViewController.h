//
//  ListViewController.h
//  MovieApp
//
//  Created by Peter Gikera on 22/07/2016.
//  Copyright © 2016 @iLabAfrica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"
#import "Movie.h"
#import "PreviewFilm.h"
#import "BaseController.h"
#import "AppDelegate.h"

@interface PreviewViewController : BaseController

@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property(nonatomic,retain) Film *film;
@property(nonatomic,retain) PreviewFilm *filmPreview;
@property (nonatomic, strong) Movie *filmSaved;



//data persistent with core data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


-(void)fetchData:(NSString *)urlParameter;
-(void) designUI:(PreviewFilm *) preview;
- (IBAction)bookmarkFilm:(id)sender;

@end
