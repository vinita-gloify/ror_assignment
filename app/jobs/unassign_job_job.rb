class UnassignJobJob < ApplicationJob
  queue_as :default

  def perform(book_id, library_id)
    @book = book_id
    @library = library_id
    UserMailer.unassign(@book,@library).deliver_now
  end
end
