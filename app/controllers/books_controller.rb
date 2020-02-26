class BooksController < ApplicationController
    def index
        @books = Book.all
    end
      
    def new
        @book = Book.new
        @authors = User.where(role: 1)
    end 
   
    def create
        user_id = current_user.id
        @user=User.find(user_id)
        @book = Book.new(book_params.merge(user_id: current_user.id))

       

        if @book.save
           redirect_to @book
        else
           render 'new'
        end 
    end
   
    def show
       @book = Book.find(params[:id])
    end 
      
    def edit
       @book = Book.find(params[:id])
    end 
   
    def update
        @book = Book.find(params[:id])
        if @book.update(params[:book].permit(:title, :published_at, :language))
           redirect_to @book
        else
           render 'edit'
        end   
    end 
   
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end    
   
    private
   
    def book_params
        params.require(:book).permit(:title, :published_at, :language)
    end    
end
