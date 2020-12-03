# Overview

This app has two screens:
- A list of Marvel characters
- A detail of the character selected in the previous screen


# Architecture

## VIPER

Despite having only 2 screens, it uses **VIPER** as an architecture pattern since it will allow us great scalability and better handling of unit tests among other advantages. VIPER architecture used in this project has some minor modifications:
- The entity that owns the Router instance is the View Controller. Although it could be in the presenter, it has been decided to place it in the View Controller in order to save an extra step when notifying a screen change (from the VC we would need to go through the presenter to carry out the navigation). Both variants can be found according to the developer.
- A worker is responsible for performing requests to the API. The interactor will be able to communicate with its corresponding worker to process the data.

## Folders
This proyect has four main folders:
- Extensions: contains the created extensions.
- Services: connections with the API. Use **Combine** framework for easier handling.
- Modules: with two subfolders, one per each screen, contains the classes required by VIPER.
- Models: application models.
