class LibrariesController < ApplicationController
    def index
        @libraries = Library.all
    end
      
    def new
        @library = Library.new
    end 
   
    def create
        @library = Library.new(library_params)

        if @library.save
           redirect_to @library
        else
           render 'new'
        end 
    end
   
    def show
       @library = Library.find(params[:id])
       @books = @library.books
    end 
      
    def edit
       @library = Library.find(params[:id])
    end 
   
    def update
        @library = Library.find(params[:id])
        if @library.update(params[:library].permit(:name, :opening_time, :closing_time))
           redirect_to @library
        else
           render 'edit'
        end   
    end 
   
    def destroy
        @library = Library.find(params[:id])
        @library.destroy
        redirect_to libraries_path
    end    

    def unassign
       @book = Book.find(:id)
       @book.update(library_id: nil)
       redirect_to 
    end    

    private
   
    def library_params
        params.require(:library).permit(:name, :opening_time, :closing_time)
    end 
   
end
