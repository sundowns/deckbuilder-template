# Deckbuilder Template

A reusable skeleton project for card/deck-based games in Godot. Intended to be agnostic of any actual game, just a starting point for other projects.

This project was made in Godot 4.2beta4 with the Mobile renderer, but really its largely version agnostic. Use what makes sense for you.

Implements a few basic features including:

- Extensible `Card` and `Deck` resource types
- A `CardDealerSystem`, responsible for loading decks and drawing cards
- Barebones UI to select and drag cards around the screen

### Controls

- [`Mouse`] Select/Drag cards
- [`Q`] Draw a card
- [`E`] Print current draw pile (to console)
- [`R`] Reset draw pile
- [`S`] Shuffle draw pile
