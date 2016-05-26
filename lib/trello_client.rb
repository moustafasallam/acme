require 'trello'

class TrelloClient

	def initialize
		Trello.configure do |config|
  		config.developer_public_key = 'ab91c136982c62d4115d0bc46552576d'
  		config.member_token = 'ee41f90fd1281d589c8c820ca183165c4f11500341a5dd264ab1e70685aa4901'
		end
		self.board
	end

	def board
		board_name = 'acme'
		board_desc = 'AcMe'

		@board = Trello::Board.all.select {|b| b.name.downcase == board_name}.first

		if @board.blank?
		  @board = Trello::Board.create(
		    name: board_name,
		    description: board_desc
		  )
		end
	end

	def list(job_posting)
		@list = @board.lists.select {|l| l.name.downcase == job_posting.title}.first
		if @list.blank?
			@list =	Trello::List.create(name: job_posting.title, board_id: @board.id)
		end
	end

	def create_card(candidate)
		Trello::Card.create(name: candidate.name, url: candidate.email,  desc: candidate.cover_letter, board_id: @board.id, list_id: @list.id)
	end

end