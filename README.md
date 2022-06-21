# Minimal - Coda_Clients_API_Integration
Challenge made in Flutter

## ===== Dev Instructions =====

1. Clone the repo
2. In the command line run
     ```
     flutter pub get.
     ```
3. Open an emulator. Youcan use either flutter's, android studio's or your own cellphone connected to the pc
4. In the command line run, 
    ```
    flutter run
    ```
5. The application will build and install in your emulator or device. Remember if you have more than one connected the user interface will ask you to choose one.
6. Enjoy it!

## ===== User Instructions =====

1. Clone the repo
2. Install the apk provided in the distribution folder in your cellphone.
3. The application is under the name "Coda-Minimal" so you can find it in your cellphone.
4. Enjoy!

## ===== Inside the app, main functionalities =====

Once the app is up and running you will get to the login page directly where it will display the login and password fields to be completed. You need to have a user and password already provided.
 
Once logged in in the top-left you will see a search bar where you can search for an specific client you are looking for. If there are no matches maybe you can try with another client.

In the top-right you will also find an "Add new" button which  will allow you to add a new client. 

Clicking on the 3 dots at the right center of a client card it will display 2 options for you, "Edit" and "Delete". Pressing on "Delete" a confirmation pop-up will appear. If you want to edit a client's firstname, lastname or email just press on the "Edit" option.

## ===== Good practices =====
Here I'm listing all the good practices used in this project in order to facilitate an example for developers on how to implement certain functionalities in a Flutter application. If they helped you with your own project do not forget to upvote(star) the repo, will mean a lot to me!  

1. BLOC pattern
2. Flutter_modular to manage routing. This also gives you the ability to apply beautiful transitions.
3. Use of Lint. Helps you pointing out those MUST programing rules for your code to look awesome. 
4. Testing.
5. DI using get_it package
6. API integration
7. Constants usage to avoid magic strings
8. Clean aruitecture by Uncle Bob