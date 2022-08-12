<h1>About the app</h1>

iOS project realized with **Swift**, **UIkit**, **Anchorage**, **Clean Architecture** and **MVVM + Coordinators patterns**.<br>
<h4><a href="https://user-images.githubusercontent.com/6122888/178473870-25b8bb45-85a9-4044-b445-02caddca11e2.mov" target="_blank">Download video demo</a><br></h4>
<p float="center">
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 19 58](https://user-images.githubusercontent.com/6122888/184451962-18878e38-c05d-4aa5-bdf4-d5607100e9dd.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 19 05](https://user-images.githubusercontent.com/6122888/184451926-27ffe1a7-b31c-4db8-b348-c6b0d83dba8f.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 19 18](https://user-images.githubusercontent.com/6122888/184451941-04bd7cc5-5dd0-4ce9-9fa6-a2288e565979.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 19 25](https://user-images.githubusercontent.com/6122888/184451944-2f22657e-600a-4b24-870f-ddf83138634b.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 19 44](https://user-images.githubusercontent.com/6122888/184451951-20c3951a-584a-4224-abbf-3c3852c0fc39.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-13 at 00 20 32](https://user-images.githubusercontent.com/6122888/184451983-1a375006-2e03-4cf6-bcf6-2990bb8b89b0.png)


</p>


## Architecture

The app is built with <a href="https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3" target="_blank">Clean Architecture</a> and use the <a href="https://it.wikipedia.org/wiki/Model-view-viewmodel" target="_blank">MVVM pattern</a> for the presentation layer.
<br>The app also use the <a href="https://betterprogramming.pub/leverage-the-coordinator-design-pattern-in-swift-5-cd5bb9e78e12" target="_blank">Coordinators</a> pattern to handle the navigation between controllers.
<br>A Main Container resolves the <a href="https://en.wikipedia.org/wiki/Dependency_injection">DI</a> between Data sources, Repositories and UseCases.
<br>The app implements the flow (View + ViewController + ViewModel) -> UseCase -> Repository -> DataSource. 
<br>The ViewModel informs the view-controller using a state. 
<br>The app use the library <a href="https://github.com/Rightpoint/Anchorage" target="_blank">Anchorage</a> to improve and fasts the UI build process. 

## Folder Structure

* **App** (AppDelegate and LaunchScreen)
* **Data** (network manager)
* **Core** (main container and helper/common classes)
* **Domain** (entities models, data models, usecases and repositories)
* **Views** (viewmodels, viewcontrollers, views and assemblers)
* **Navigation** (coordinators)

[product-screenshot]: images/devices.jpeg
