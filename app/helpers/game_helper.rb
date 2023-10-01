module GameHelper
	def piece_img(board, square)
		if board[square] == 'P'
			image_tag 'pieces/wpawn.svg', alt: 'White Pawn', class: 'chess_piece'
		elsif board[square] == 'R'
			image_tag 'pieces/wrook.svg', alt: 'White Rook', class: 'chess_piece'
		elsif board[square] == 'N'
			image_tag 'pieces/wknight.svg', alt: 'White Knight', class: 'chess_piece'
		elsif board[square] == 'B'
			image_tag 'pieces/wbishop.svg', alt: 'White Bishop', class: 'chess_piece'
		elsif board[square] == 'Q'
			image_tag 'pieces/wqueen.svg', alt: 'White Queen', class: 'chess_piece'
		elsif board[square] == 'K'
			image_tag 'pieces/wking.svg', alt: 'White King', class: 'chess_piece'
		elsif board[square] == 'p'
			image_tag 'pieces/bpawn.svg', alt: 'Black Pawn', class: 'chess_piece'
		elsif board[square] == 'r'
			image_tag 'pieces/brook.svg', alt: 'Black Rook', class: 'chess_piece'
		elsif board[square] == 'n'
			image_tag 'pieces/bknight.svg', alt: 'Black Knight', class: 'chess_piece'
		elsif board[square] == 'b'
			image_tag 'pieces/bbishop.svg', alt: 'Black Bishop', class: 'chess_piece'
		elsif board[square] == 'q'
			image_tag 'pieces/bqueen.svg', alt: 'Black Queen', class: 'chess_piece'
		elsif board[square] == 'k'
			image_tag 'pieces/bking.svg', alt: 'Black King', class: 'chess_piece'
		else
			nil
		end 
	end
end
