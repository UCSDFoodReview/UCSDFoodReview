# UCSDFoodReview
Group Project for Codepath's Spring 22 iOS Course

Original App Design Project - README Template
===

# UCSD Food Review

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
[iOS app that allows UCSD students to rate different dining halls and their selection of food. Users will be able to post images of their food along with their 
 review.]

### App Evaluation
- **Category: Food / Lifestylezz**
- **Mobile: Focused mainly towards mobile use. Harder to submit reviews with photos on a computer.**
- **Story: Allows students to see reviews of different food choices at each dining hall so they can choose better meals.**
- **Market: Mainly targeted towards UCSD students, as they purchase food from the dining halls the most often.**
- **Habit: This app coule be used as often as a user wants, primarily for reviewing food or discovering new food.**
- **Scope: First we could start with just reviews of UCSD dining halls. Next, we could review restaurants on campus not affiliated with HDH. Then, we could review other aspects of the UCSD campus such as study places, hangout spots, sunset views, etc...**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can register or login to post reviews. 
* User can select betwen different dining halls and the view food options from each dining hall. 
* Rating system out of five stars for each dining hall and food item.
* Food page includes description and price, average rating of food.
* Users can upvote/downvote reviews and reply
* User can view profile in settings

**Optional Nice-to-have Stories**

* Photos of food
* User can change account settings/preferences in the settings panel
* Map of campus with dining hall locations marked
* User can view posts without registering
* User can post anonymously 

### 2. Screen Archetypes

* Login/Register - User signs up or logs into their account
   * If user has not registered, prompt the user to sign up to comment and post
   * Login state saved even if app closed and reopened
* Home/Dining Hall Screen 
   * Screen that shows all the dining hall options with their ratings
   * Can scroll up and down to see different dining halls
   * Can tap on a dining hall to go to food selection screen
   * Icon to switch to profile screen
* Food selection screen
   * Shows all the different options from the dining halls in a table cell with price, rating, and food tags
   * Can click on each cell to open food description screen
* Food description screen
   * Shows description of food, rating, price, food tags (ie dairy free, vegan), images, and reviews
   * Button to create review and and uploading pictures
   * Allow users to click and view other profiles
   * Each review can be upvoted or downvoted, reviews are prioritized by votes
* Profile Screen
   * User can see statistics about their account (ie. number of posts, upvotes, etc.)
   * User can see a feed of their posts.
   * User can click a button to go to the settings screen
* Settings Screen
   * User can change their email/password
   * Dark/Light mode
   * Logout button

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home/Food
* Profile
* Settings*

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is availble
   * Login/Register -> Homepage/Food
* Clicking on dining hall -> Click on specific Food -> Brings you to reviews of that dish
   * Click on another user's profile picture to view their profile screen
* Profile nagivation bar button leads to user's profile page
   * Possibly settings option inside profile page?

## Wireframes
![IMG_3984](https://user-images.githubusercontent.com/65835856/155865925-d97f84bf-b999-443a-b02c-58beabf2a5ff.jpg)


### [BONUS] Digital Wireframes & Mockups
<img src="https://imgur.com/sYWFjST.jpg" width=400><br>

### [BONUS] Interactive Prototype

## Schema 
### Models

#### User Object

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userID       | String   | Unique id for the userObj|
   | profilePic       | File   | Image for the user profile picture|
   | username       | String   | Username for the user|
   | password       | String   | Password for the user login|
   | userReviews (optional)     | List or Array   | A list or array of user review objects|
   | numOfKarma (optional)      | Number   | Total "upvotes and downvotes" that the user recieved|

#### Review Object

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | author        | Pointer to User| Has all the data from user: take username and profile picture|
   | review       | String   | Review of the food item |
   | reviewCount | Number   | Number of reviews that has been posted |
   | ratings | Number   | Average star ratings |
   | totalKarma    | Number   | Number of likes - dislikes |
   | foodReviewed    | Pointer to Food | Has all data from food: take food name |
   | createdAt (optional)    | DateTime | date when post is created (default field) |
   

#### Dining Hall Object

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | diningHallName  | String| Name of dining hall |
   | foodList         | List or Array    | List or array of food objects|
   | hallDescription         | String    | Short description of dining hall. Potentially include location|
   | location (optional)       | (depends on implementation)    | most likely need an api call.|
   

#### Food Object

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | foodName        | String | Name of food |
   | foodDescription (optional)  | String     | Description of food |
   | foodImage (optional) | File   | Image of food |
   | averageRating    | Number   | Average rating of the food |
   | reviews     | List or Array | List of pointers of all the reviews for that food |

### Networking
#### List of network requests by screen
   - Login Screen
     - (Create/POST) Create new user
     - (Read/GET) Read and login an existing user
   - Dining Hall Screen
      - (Read/GET) Query all Dining Halls
         ```swift
         let query = PFQuery(className:"DiningHall")
         query.order(byDescending: "diningHallName")
         query.findObjectsInBackground { (diningHalls: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let diningHalls = diningHalls {
               print("Successfully retrieved \(diningHalls.count) dining halls.")
           // TODO: Do something with posts...
            }
         }
         ```
   - Food Screen
     - (Read/GET) Query all the reviews of that food from that dining hall
     - (Update/PUT) Changes karma of each post (optional)
   - Review Screen
     - (Create/POST) Create a new review
     - (Update/PUT) Update the ratings after a review
   - Profile Screen
     - (Update/PUT) Change their password
     - (Update/PUT) Change their profile picture
     - (Read/GET) Show total karma (optional)
