# Stockfish Chess Engine API

## Welcome stranger!

To troll people on [Chess](https://www.chess.com/), simply download the [chrome browser extension](https://chrome.google.com/webstore/detail/chess-extension/ieaoeokfilgofofpdcehmgokenlnbdaa)!

This is a side project that I do for fun. Have fun!

Please note that I do not encourage cheating in any form. It's for educational and experimental purposes.

## Endpoint

All endpoint will go to https://chess.apurn.com/

### GET /

This endpoint should return the string "Hello, World!". This is a way to test if the engine is up and running on the server. If this endpoint produces an error or timeout, I've probably taken down the service, Sorry!

### POST /nextmove

This endpoint is the main and only entry to the chess engine. Simply send the board [FEN board notation](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation) state as a raw text body to https://chess.apurn.com/nextmove, and the engine will return the best next move.

Example body: `rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1`

## Contributions
Feel free to fork this project and make it your own. Hit me up at appurnam@ucsd.edu for any questions or if you just want to play chess!
