from flask import Flask, request
from flask_cors import CORS
import chess
import chess.engine

app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
  return 'Hello, World!'

# POST /nextmove
# chessboard state as payload
@app.route('/nextmove', methods=['POST'])
def getNextMove():
  # init engine
  engine = chess.engine.SimpleEngine.popen_uci("bin/stockfish")
  
  # get the payload
  req_data = request.data
  print(req_data.decode('utf-8'))

  board = chess.Board(req_data.decode('utf-8'))
  result = engine.play(board, chess.engine.Limit(time=0.100))
  
  engine.quit()
  return result.move.uci()

if __name__ = '__main__':
  app.run()