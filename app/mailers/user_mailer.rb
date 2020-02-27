class UserMailer < ApplicationMailer

    def welcome_author(user,password)
        @user_name = user.name
        @user_password = password
        @user_email = user.email
        mail(to: user.email, subject: "Your account created")
    end

    def assign(book,library)
        @user = book.user
        @book = book
        @library = library
        mail(to: @user.email, subject: "Your book assigned to library")
    end

    def unassign(book,library)
        @user = book.user
        @book = book
        @library = library
        mail(to: @user.email, subject: "Your book unassigned from library")
    end
end
