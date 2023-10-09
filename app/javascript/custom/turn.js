// document.addEventListener('turbo:render', function () {
//   	const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
//   	// Wait for the page to fully load
//     const turnElement = document.querySelector('.turn.active');
//     // Check if the element with class 'turn active' exists
//     if (turnElement) {
//       const text = turnElement.textContent.trim();

//       // Check if the text is equal to 'AI'
//       if (text === 'AI') {
//         // Send a PATCH request using fetch
//         console.log('here')
//         fetch(`/games/${window.gameId}/ai`, {
//           method: 'PATCH',
//           headers: {
//             'X-CSRF-Token': csrfToken, // Include CSRF token if needed
//           },         
//         }).then((response) => {
//   			// Check the response status code
//   			if (response.status === 200) {
//     		// The request was successful
//     		// Update the page here
//   			} else {
//     			// The request failed
//     			// Handle the error here
//   			}
// 			})
// 			.catch((error) => {
//   				// Handle the error here
// 			});
//       }
//     }
// });


