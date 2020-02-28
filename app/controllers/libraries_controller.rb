class LibrariesController < ApplicationController

    before_filter :check_if_admin

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
       @unassigned_books = Book.where(library_id: nil)
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
    
    def assign_book
        @library = Library.find(params[:id])
        @book = Book.find(params[:book_id])
        #@book.library_id = @library.id
        respond_to do |format|
            if @book.update(library_id: @library.id)
              UserMailer.assign(@book,@library).deliver_later
              format.html { redirect_to @library }
              format.json { render json: @book, status: :created}
            else
              format.html { 
                flash.now[:notice]="Save proccess coudn't be completed!" 
                render :show
              }
              format.json { render json: @book.errors, status: :unprocessable_entity}
            end
          end
    end

    private
   
    def library_params
        params.require(:library).permit(:name, :opening_time, :closing_time)
    end 

    def check_if_admin
        if signed_in?
          redirect_to root_path unless current_user.role == 'admin'
        else
          redirect_to root_path
        end
      end
   
end
