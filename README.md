# WalletBud

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Tracks expenses of an individual to better manage their cashflow. The app can ideally enable users to meet their financial goals.

### App Evaluation
- **Category:** Finance / Expense Tracker
- **Mobile:** Being a native iOS app, this app would allow users to take advantage of push notifications and the camera.
- **Story:** This app would encourage and empower users to understand and take control of their spending habits. As such, this app would assist users in creating and following smarter financial planning.
- **Market:** Anyone seeking to view and manage how they are spending money of their finances can use this app. Everyone has finances to take care of so this app can tap into a large potential user base.
- **Habit:** The app could be used everytime a user makes a transaction. 
- **Scope:** At the initial stage, we would start with keeping track of the expenses that user enters and visualize the results based on preset budget allowing users to self analyze where the user should control their expenditure. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account
* User can login to their account and stay signed in
* User can add a transaction with a pre-defined hash tag
* User can set up a monthly budget
* User can edit their monthly budget to be applied to the current month or following months.

**Optional Nice-to-have Stories**

* User can search transactions based on hashtags or text
* User can add new hashtags for their budget
* User can linked their bank account/credit cards that automatically pulls all the transactions to the app.
* User can enter recurring transactions automatically that applies to a user defined frequency (weekly, biweekly or monthly) and also a user defined duration. These transactions could include utilities, tuitions etc. 

### 2. Screen Archetypes

* Login Screen
   * User can login 
* Registration Screen
   * User can create a new account
   * Upon closing the app, the user stays signed in 
* Overview Screen
    * For the first instance, user is asked to set up their budget and/or add transactions.
    * User can view remaining expenses budget and recent transactions
* Transactions Screen
    * User can add transaction and assign a hashtag with it.
    * User can see details about the transaction
    * User can delete a transaction
* Budget Screen
    * User sets up their budget based on the predefined hashtag and assign a maximum limit to each category (aka hashtag)
* Settings Screen
  * User can change their username and/or password
  * User can adjust other user details such as their name
  * User can set up their notification preferences
  * User can allow iPhone authentication method (such as FaceID or TouchID) to sign into the app.
  * User can sign out
 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Overview Screen
* Transactions Screen
* Budget Screen

**Flow Navigation** (Screen to Screen)

* Login
   => Overview
* Registration
   => Overview
* Overview
   => Transactions
   => Budget
* Transactions
   => Overview
   => Budget
* Budget
   => Overview
   => Transactions

## Wireframes
<img src="WalletBud-initial-wireframe.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="WalletBud-digital-wireframe.png" width=1000>

### [BONUS] Interactive Prototype
<img src="WalletBud-prototype-walkthrough.gif" width=200>

## Schema 
### Models
#### Users

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | UserId      | String   | unique user id (default field) |
   | UserName        | String | User name for login |
   | Email         | String     | user email |
   | Password       | String   | user password |
   | Date of Birth | DateTime   | user date of birth |
   | First Name    | String   | user's first name |
   | Last Name     | String | user's last name |
   | Notification | Boolean | user's preference on notification |
   | FaceID    | Boolean | user's preference on using faceId for signin |
   
   
#### HashTags

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user defined hashtag per user (default field) |
   | User        | Pointer to User | user who created the hashtag  |
   | Hashtag         |    String  | Title of the hashtag |
   
   
#### Transactions

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user transaction (default field) |
   | User        | Pointer to User | user who created the transaction |
   | Hashtag         | Pointer to HashTag     | hashtag defining user's transaction |
   | Amount       | Number   | transaction amount |
   | Transaction Vendor | String   | Vendor where the transaction occured |
   | Transaction date    | DateTime   | Date when transaction occured |

#### Budgets

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the budget (default field) |
   | User        | Pointer to User | user who created the budget |
   | Hashtag         | Pointer to HashTag     | hashtag that define the type of budget |
   | Budget Amount       | Number   | budget amount for the hashtag |
   | Month Year | DateTime   | Month and year for which the budget is for |


   
   

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
