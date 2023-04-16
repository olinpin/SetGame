![Set Game app Icon](https://github.com/olinpin/SetGame/blob/main/resources/AppIcon.png?raw=true)



### Set Game
This is an implementation of the Set card game in Swift using SwiftUI. The game is a matching game where players try to find sets of three cards that share the same properties (color, symbol, number, and shading) or differ in all of these properties. The game ends when there are no more sets on the table.
## Usage
To play the game, simply run the application on a compatible device or simulator. The game will begin immediately, and you can start selecting cards by tapping on them. If a set is found, the cards will be replaced by new ones, and the score will be updated accordingly. If there are no more sets, the game will end.
## Implementation
The game is implemented using the `SetGame` model object, which contains the game logic and state. The game is displayed using the `SetGameView`, which renders the cards on the table and handles user input. The `CardView` is a subview of `SetGameView` that renders individual cards.
## Customization
The game can be customized by changing the values of the constants in `SetGame.swift`, which control the number of cards, the number of properties, and the range of possible values for each property.
## Requirements
This application requires Xcode 12 or later and runs on iOS 14 or later.
