# NYTimes
Fetches most viewed articles from NYTimes.

# Design Architecture

The app uses VIPER architecture as a design pattern to manage and strcuture code. 
VIPER is a flavor of CLEAN.

So, What is VIPER architecture?

VIPER is a backronym for View, Interactor, Presenter, Entity, and Router.

This architecture is based on Single Responsibility Principle which leads to a clean architecture.
View: The responsibility of the view is to send the user actions to the presenter and shows whatever the presenter tells it.
Interactor: This is the backbone of an application as it contains the business logic.
Presenter: Its responsibility is to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it. It also asks the router/wireframe for navigation.
Entity: It contains basic model objects used by the Interactor.
Router: It has all navigation logic for describing which screens are to be shown when. It is normally written as a wireframe.


# Run Unit Test

Unit tests have been provided for major chunks of the application i.e API Client, NYTimesRequestInterceptorTest, ArticleTest, APITest.
Simply press "Command" + "U" or select Test from Product menu to run all the tests.

# Run Application

To run the application simply press "Command" + "R" or select Run from Product menu.


# Generating Code Coverage Reports

Running unit test using CMD+U button in Xcode, will generate Code Coverage reports into the default derived data directory located at ~/Library/Developer/Xcode/DerivedData and reports generated at Logs/Test directory.


# App Structure

App has been divided into Scenes and there are two scenes in the application:

1. **ArticleList** (VIPER)
2. **ArticleDetail** (VIPER)


# Networking

For network calls no third party library has been used. A Client is written which uses Apples default Networking framework.
The HttpClient fully supports Dependency Injection(DI), a very core concept of VIPER. DI has many advantages as it provides easy way to Mocking of API requests.

# Interceptors

The concept of Interceptors has been used to modify a any request on the fly. You can merge multiple interceptors and create complex requests easily without modifying in Network client. The good thing is that interceptors are added on individual requests so you have the flexibility to decide which interceptor should adedd.

There are mainly two types of Interceptors used in app:

  1 . Request Adapter
  2.  Response Parser

  # 1 . Request Adapter:
  The purpose of this class is to modify any request on the runtime. Adapter used in app is **NYTimesAPIKeyInterceptor** which adds the Api-key to the request by 
  keeping all details encapsulated in the Adapter. The other purpose could adding access token to the requests when user is authorized. Best used for **Auth 2.0**. 
  
  Unit test has been written for it NYTimesRequestInterceptorTest.
  
  # 2. Response Parser
  The purpose is to behave as a funnel when response is received and do any modification before sending it down to the caller.
  


# Image Downloading

For Downloading image no third party has been used and it efficiently uses URLsession to download from specified destination. Simple to use extension has been provided on UIImageview which makes it very convenient to download images. 





