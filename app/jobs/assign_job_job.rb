class AssignJobJob < ApplicationJob
  queue_as :default

  def perform(book_id, library_id)
    @book = book_id
    @library = library_id
    UserMailer.assign(@book,@library).deliver_later
  end
end
