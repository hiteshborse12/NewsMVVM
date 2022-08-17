# NewsMVVM
Fetching top headlines for a country, specific category, and showing in the table view by MVVM architecture

## Requirements
- iOS 13+
- Cocoapods

## Screenshot
![Screenshot](https://user-images.githubusercontent.com/6498031/185146492-33ff6833-2cb3-4944-9344-236a3dac3aeb.png)

## Run
To run the News project, clone the repo, and run ```pod install``` from the project directory first.

## Usage
### Initialization 
You can use your own API key(NetworkConstants file).
```swift
static let apiKey = ""
```
Generate own API Key : https://newsapi.org/register

## Used
- Pods
    - Alamofire
    - SDWebImage
    - Nimble(For unit testing)
    - PromiseKit
- News org api: https://newsapi.org/docs

## Author
Hitesh Borse
