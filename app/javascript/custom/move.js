document.addEventListener('DOMContentLoaded', () => {
  // Get references to chess piece images
  const chessPieces = document.querySelectorAll('.chess_piece');
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');


  // Define event listeners for drag and drop
  chessPieces.forEach((piece) => {
    piece.addEventListener('dragstart', (event) => {
      // Set data to be transferred during the drag
      event.dataTransfer.setData('text/plain', event.target.id);
    });
  });

  const squares = document.querySelectorAll('.square');

  squares.forEach((square) => {
    square.addEventListener('dragover', (event) => {
      console.log('start of dragover')
      // Allow drop
      event.preventDefault();
    });

    square.addEventListener('drop', (event) => {
      // Prevent default behavior
      event.preventDefault();
      console.log('start of drop')

      // Get the dragged piece's ID from the data transfer
      const pieceId = event.dataTransfer.getData('text/plain');

      // Get the square's data attribute (e.g., 'a1')
      const squareId = square.id;

      // Send a patch request to your Rails application
      sendPatchRequest(pieceId, squareId);
      square.removeEventListener('drop', (event))
    });
  });

  // Function to send a patch request
  function sendPatchRequest(pieceId, squareId) {
    // Use XMLHttpRequest or fetch to send a patch request
    // Example using fetch:
    fetch(`/game/${window.gameId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken, // Include CSRF token if needed
      },
      body: JSON.stringify({
        pieceId: pieceId,
        squareId: squareId,
      }),
    })
  }
})