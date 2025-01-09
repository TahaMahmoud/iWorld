# <img src="/Screenshots/AppIcon.png" width="200" height="250"> iWorld

## <a name="intro"></a> Intro
iWorld is an iOS application designed to demonstrate clean architecture principles practically. This app showcases various functionalities, and this documentation provides a detailed insight into its technical intricacies and design choices.

# Table of contents
- [Intro](#intro)
- [Quick Start](#quick-start)
    - [Prerequisites](#quick-start-prerequisites)
- [App Features](#features)
- [Used In the App](#used-in-app)
- [Design System](#design-system)
    - [Idea](#design-system-idea)
    - [Core](#design-system-core)
    - [Components](#design-system-components)
- [Core Layers](#core-layers)
    - [Core](#core-layers-core)
    - [Networking](#core-layers-network)
    - [Logger](#core-layers-logger)
    - [DataPersistence](#core-layers-data)
- [App Architecture](#app-architecture)
- [I/O MVVM](#io-mvvm)
- [Unit Testing](#unit-testing)
- [Screenshots](#screenshots)
- [TODO](#todo)
- [Author](#author)

# <a name="quick-start"></a> Quick Start
This Quick Start guide will get you up with the app.
## <a name="quick-start-prerequisites"></a> Prerequisites
- Xcode 16.0.
- iOS 16.0.

# <a name="features"></a> App Features
- Home [Highlight, Saved, and Featured Countries].
- Countries List:
    - Search.
    - Filter By Region.
- Country Details:
    - Country Info.
    - Country Borders.
- Favourites List.
- Highlight Country.
- Remove From Highlighted countries.
- Add To Favourites.
- Remove From Saved.
- Show country on Map.
- Offline Experience.
- Location-based Experience.
- Empty States.

# <a name="used-in-app"></a> Used In the App
- SwiftUI
- Combine
- [Factory](https://github.com/hmlongco/Factory): Dependency Injection third party.
- Coordinator, Repository, Builder, Factory, Singleton patterns ...etc.
- Navigation Path: iOS16-based Routing sultion.
- SwiftLint

# <a name="design-system"></a> Design System
## <a name="design-system-idea"></a> The Idea
The reusability of the design is one of the most important concerns while we are building a scalable application that not only serves just a single application but also can serve multiple applications inside the organization, So, I created a Swift Package named "Design System", This package contains the common UI handling that can be shared with more than one app for more reusability.

The idea behind the built design system is to have a file for each application that contains the design system values per this application/theme, 
So, We have a base struct for the design system, Each application/theme will have its values.

Initially, We have only the `colors` inside the design system, But we should handle all the variable tokens such as `Typography`, `Padding`, `Sizing`, `Colors`, ...etc.

## <a name="design-system-core"></a> Core
The design system has a class for configuring the app theme,
So, Each app can do something like this:
```
import DesignSystem

DesignSystem.shared.setupTheme(theme: .iWorld)
```

This package contains Extensions, iWorldDesignSystem, Resources[Fonts/Assets], and Components.

## <a name="design-system-components"></a> Components
After the design analysis, I divided the design system components into two parts: 

- Basic Components: [Buttons, ...etc]
- Product Components: The reusable views inside the app to be used in more than one screen [ EmptyState, CountryItem, ...etc]

# <a name="core-layers"></a> Core layers
I also built a Swift package for the core layers, This package consists of libraries for the core layers inside the app, Such as: 

## <a name="core-layers-core"></a> Core 
[Extensions, Utilities, Mappers, Typealias]
## <a name="core-layers-network"></a> Networking 
URLSession-based Network layer, Remote Response Handler, Local Response Handler, Error Handler, ...etc
## <a name="core-layers-logger"></a> Logger
Initially, We had only the `System Logger` engine that `debug print` the log messages, But it's open for extension and adding new engines.
## <a name="core-layers-data"></a> Data Persistence
This layer is built to persist many types of data with **save, update, and remove** options, Initially it is built with only the **UserDefaults** to achieve the PoC, I know that this use case can't be persisted inside the UserDefaults, But for the sake of time I depended on the **DataManagerProtocol** to handle it later, And later I'll add the **CoreData, Realm, and SwiftData** managers.

# <a name="app-architecture"></a> App Architecture
This app is built using the  [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) guidelines and I separated the **Domain** and **Data** in separate Swift Packages to be reused inside the application, Giving us the required scalability level away from the presentation layer,
And, the **Presentation** layer is on the app side and separated by **module/feature/screen**

## Domain layer
The Domain layer consists of the **UseCases, RepoProtocols, And the Entities**
It also has the actual **UseCase Implementation**.

## Data layer
The Data layer consists of **DataSources, Endpoints, ReposImplementation, DTOs**. 

## Presentation Layer
The Presentation layer is an app-side containing the Modules, Features, and screens.
The presentation layer is built using the **I/O MVVM** presentation architecture.

## How the App. & Layers communicating?
As we are separating the **domain and data** layers from the application and presentation layer, We need to handle the communication between the layers and the application side, We have the CoreData library that enables the application side to setup the data with the configuration and inject the dependencies that the data package need to run, We have the AppConfig and the APIConfig for this mission.

# <a name="io-mvvm"></a> I/O MVVM
iWorld uses `I/O MVVM` (Input/Output Model-View-ViewModel) architecture. This is a clean architecture that emphasis separation of concerns and ease of maintainability.

- The `I/O` refers to how the ViewModels are designed. All view models in the package are communicated to through their *inputs* and *outputs*. No other way is allowed (beside the view model initializer). The `I/O` part of the view model utilizes Apple's `Combine` framework. Inputs are events sent to the view model (for example a dismiss trigger, show details trigger). Outputs are published properties that are consumed *probably* by the views and view controllers. An example of a view model's input is shown below:

  Notice that the inputs are all created during initialization, and the outputs cannot be set outside the view model (they publish *information* to the view model consumers).

- The `Model` part represents the data structs used throughout the app. The main model in our package is, of course, `Country` and you can find it in `Domain/Entities`.

- The `View` part represents the different views provides by the packages. I use only `SwiftUI` for the views which works more than hoped for.

- The `ViewModel` as explained above provides business logic related to user inputs and the system outputs (information) shown to the user. The `ViewModel` also publishes routing requirements at some point, and it does so through its `route` publisher. This is the last piece of the puzzle. But how that works, though? 🤔 

# <a name="unit-testing"></a> Unit Testing
I covered the **UseCases** and **Repositories** with success and failure test cases.
I'll update this project with the other test cases such as DataSources, ViewModels, and so on.

# <a name="screenshots"></a> Screenshots
| Launch Screen | Onboarding     | Home (Single Highlight)     | Home (Multi Highlights)     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/Launch.png" width="200" height="400">        | <img src="/Screenshots/Onboarding.png" width="200" height="400">       | <img src="/Screenshots/Home_SingleHighlighted.png" width="200" height="400">       | <img src="/Screenshots/Home_MultiHighlighted.png" width="200" height="400">       |

| Home (Location Disabled) | Saved Countries    | List     | List (Search)     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/Home_Location_Disabled.png" width="200" height="400">        | <img src="/Screenshots/Saved_Countries.png" width="200" height="400">       | <img src="/Screenshots/List.png" width="200" height="400">       | <img src="/Screenshots/List_Search.png" width="200" height="400">       |

| List (Filter) | Highlights (Limit)     |   List (Empty)   | Country Details     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/List_Filter.png" width="200" height="400">        | <img src="/Screenshots/List_Limit.png" width="200" height="400">       | <img src="/Screenshots/List_Empty.png" width="200" height="400">       | <img src="/Screenshots/Country_Details.png" width="200" height="400">       |


# <a name="todo"></a> TODO:-
- [ ] Add CoreData, Realm, and SwiftData manager into the DataPersistece library.
- [ ] Add Unit Tests for the Data Sources.
- [ ] Add Unit Tests for the ViewModels.
- [ ] Enhance the design system.
- [ ] Finalize the File Template to auto-generate the modules.
- [ ] Support Dark Mode / Light Mode.
- [ ] Add UI Tests.
- [ ] Integrate Tuist.
- [ ] Integrate FastLan.
- [ ] Add PR Template.
- [ ] Localization.

# <a name="author"></a> Author
Created by 
- Taha Mahmoud [LinkedIn](https://www.linkedin.com/in/engtahamahmoud/)

Please don't hesitate to ask any clarifying questions about the project if you have any.
