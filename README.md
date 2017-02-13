# Project 1 - Flix

![flix logo](https://cloud.githubusercontent.com/assets/11231583/22633912/392c6784-ebf3-11e6-833e-f5aa665cef58.png)

Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User can view movie details by tapping on a cell.
- [X] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [X] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [X] All images fade in as they are loading.
- [X] Customize the UI.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the navigation bar.

The following **additional** features are implemented:

- [X] Present View with details of selected movie
- [X] Generates Genre's from JSON Data
- [X] Cocoapods: CircularSpinner, and FloatRating View
- [X] Get Movie Release Date from JSON Data
- [X] Scroll view offset via button
- [X] Collection View Cell effect
- [X] Trailer from JSON Data: video key to Web View

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Web View formatting

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

### Sprint 1
![flixgif](https://cloud.githubusercontent.com/assets/11231583/22634228/c7942424-ebf5-11e6-9042-0fce21e1d08b.gif)

### Sprint 2
![flixgif2](https://cloud.githubusercontent.com/assets/11231583/22871068/7d63d026-f17b-11e6-8254-4b5627b6d581.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- ~~I had some difficulties with selecting Collection View Cell, you need to touch the screen a certain way to select the cell as of now.~~
- UPDATE: Fixed, gesture recognizer was cancelling effect of selection.

## License

    Copyright [2017] [Steven Hurtado]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
