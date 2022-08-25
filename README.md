<h1>About the app</h1>

iOS project realized with **Swift**, **UIkit**, **Anchorage**, **Clean Architecture**, **UICollectionViewDiffableDataSource** and **MVVM + Coordinators patterns**.<br>
<h4><a href="https://user-images.githubusercontent.com/6122888/184453708-9849332b-98a6-43b6-8f45-a175a9d9cac0.mov" target="_blank">Download video demo</a><br></h4>
<p float="center">

<img src="https://user-images.githubusercontent.com/6122888/184452017-91700efe-2ed2-4411-aabd-fe8f0d1153d4.png" width="270" height="550">
<img src="https://user-images.githubusercontent.com/6122888/184452355-e52d47a0-5510-4c17-845a-5a7398b9e431.png" width="270" height="550">
<img src="https://user-images.githubusercontent.com/6122888/184452365-e3174a97-15a0-4c9c-816a-b92437d955ee.png" width="270" height="550">
<img src="https://user-images.githubusercontent.com/6122888/184452368-61c1a7f9-6a84-4075-a771-8aea9fda9baa.png" width="270" height="550">
<img src="https://user-images.githubusercontent.com/6122888/184452371-4f94f8c8-5280-44ed-9fe0-62a828bfb043.png" width="270" height="550">
<img src="https://user-images.githubusercontent.com/6122888/184452372-8fe92205-fc9e-438b-b035-eb5051888a92.png" width="270" height="550">

  
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
