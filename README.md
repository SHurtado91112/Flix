# Project 1 - Flix

![flix logo](https://cloud.githubusercontent.com/assets/11231583/22633912/392c6784-ebf3-11e6-833e-f5aa665cef58.png)

Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [X] All images fade in as they are loading.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] Present View with details of selected movie
- [X] Generates Genre's from JSON Data
- [X] Cocoapods: CircularSpinner, and FloatRating View

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Resetting content & settings; I would like to explore the behavior of doing this and how it could affect the applications.
2. Different ways to show presentable data; present views, popovers

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![flixgif](https://cloud.githubusercontent.com/assets/11231583/22634228/c7942424-ebf5-11e6-9042-0fce21e1d08b.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- I had some difficulties with selecting Collection View Cell, you need to touch the screen a certain way to select the cell as of now.

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
