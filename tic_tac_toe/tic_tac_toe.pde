// Tic-Tac-Toe in Processing
// Canvas: 500x500
// Computer: X (always starts)
// User: O (circles)
// Input: number keys '0'–'8'

char[] board = new char[9]; // ' ', 'X', 'O'
boolean gameOver = false;

void setup() {
  size(500, 500);
  resetBoard();
  println("Tic-Tac-Toe");
  println("Canvas: 500x500");
  println("Computer is 'X' and always starts.");
  println("You are 'O' (circles).");
  println("Use keys 0–8 to choose a square:");
  println("0 1 2");
  println("3 4 5");
  println("6 7 8");
  println("Computer will now take the first move.");
  computerMove();  // computer starts
}

void draw() {
  background(255);
  drawGrid();
  drawMarks();
}

// Draw the tic-tac-toe grid
void drawGrid() {
  stroke(0);
  strokeWeight(4);
  float cellSize = width / 3.0;

  // Vertical lines
  line(cellSize, 0, cellSize, height);
  line(2 * cellSize, 0, 2 * cellSize, height);

  // Horizontal lines
  line(0, cellSize, width, cellSize);
  line(0, 2 * cellSize, width, 2 * cellSize);
}

// Draw X's and O's
void drawMarks() {
  float cellSize = width / 3.0;
  for (int i = 0; i < 9; i++) {
    int row = i / 3;
    int col = i % 3;
    float cx = col * cellSize + cellSize / 2;
    float cy = row * cellSize + cellSize / 2;
    float margin = cellSize * 0.3;

    if (board[i] == 'X') {
      stroke(0);
      strokeWeight(6);
      line(cx - margin, cy - margin, cx + margin, cy + margin);
      line(cx + margin, cy - margin, cx - margin, cy + margin);
    } else if (board[i] == 'O') {
      noFill();
      stroke(0);
      strokeWeight(6);
      ellipse(cx, cy, margin * 2, margin * 2);
    }
  }
}

// Reset the board to empty
void resetBoard() {
  for (int i = 0; i < 9; i++) {
    board[i] = ' ';
  }
  gameOver = false;
}

// Handle key presses
void keyPressed() {
  if (gameOver) {
    println("The game has ended. Please restart the sketch to play again.");
    return;
  }

  // Only numeric keys 0–8 are valid move keys
  if (key >= '0' && key <= '8') {
    int index = key - '0';

    if (board[index] != ' ') {
      println("That square is already taken. Choose another square (0–8).");
      return;
    }

    // User move: place 'O'
    board[index] = 'O';
    println("You played in square " + index + ".");

    // Check if user wins
    char winner = checkWinner();
    if (winner == 'O') {
      println("You (O) have won the game!");
      gameOver = true;
      return;
    }

    // Check for draw before computer moves
    if (isBoardFull()) {
      println("No one has won. The board is full.");
      gameOver = true;
      return;
    }

    // Computer's turn
    computerMove();

    // Check game state after computer move
    winner = checkWinner();
    if (winner == 'X') {
      println("Computer (X) has won the game!");
      gameOver = true;
      return;
    } else if (isBoardFull()) {
      println("No one has won. The board is full.");
      gameOver = true;
      return;
    } else {
      // After the user takes their turn, and if neither has won:
      println("The game is still in play.");
    }

  } else {
    // Any non 0–8 key
    println("Incorrect key pressed. Use keys 0–8 to choose a square.");
  }
}

// Simple computer move: first available square
void computerMove() {
  if (gameOver) return;

  for (int i = 0; i < 9; i++) {
    if (board[i] == ' ') {
      board[i] = 'X';
      println("Computer played in square " + i + ".");
      break;
    }
  }
}

// Check for winner: returns 'X', 'O', or ' ' for none
char checkWinner() {
  int[][] lines = {
    {0, 1, 2},
    {3, 4, 5},
    {6, 7, 8},
    {0, 3, 6},
    {1, 4, 7},
    {2, 5, 8},
    {0, 4, 8},
    {2, 4, 6}
  };

  for (int i = 0; i < lines.length; i++) {
    int a = lines[i][0];
    int b = lines[i][1];
    int c = lines[i][2];
    if (board[a] != ' ' && board[a] == board[b] && board[b] == board[c]) {
      return board[a];
    }
  }
  return ' ';
}

// Check if all squares are filled
boolean isBoardFull() {
  for (int i = 0; i < 9; i++) {
    if (board[i] == ' ') return false;
  }
  return true;
}
