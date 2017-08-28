require 'sinatra'
require_relative 'contact.rb'

# *----HOME PAGE---*
get '/' do
  erb :index
end

# *----PAGE THAT SHOWS ALL CONTACTS IN CRM---*
get '/contacts' do
  @contacts = [
    {id: 2, first_name: "Mallory", last_name: "Morris", email: "second@email.com", note: "N/A"},
    {id: 3, first_name: "Stanton", last_name: "Roberts", email: "third@email.com", note: "N/A"},
    {id: 4, first_name: "Daniel", last_name: "Costa", email: "fourth@email.com", note: "N/A"},
    {id: 5, first_name: "Sarah", last_name: "Costa", email: "email@email.com", note: "N/A"},
  ]

  erb :contacts
end

# *----PAGE TO ADD A NEW CONTACT---*
get "/contacts/new" do
  erb :new
end


# *----SEE EACH CONTACT SEPARATELY ON ITS OWN PAGE---*
get "/contacts/:id" do
  @contact = Contact.find_by({id: params[:id].to_i})
# params[:id] contains the id from the URL

    erb :show_contact
end

# *----SEE EACH CONTACT SEPARATELY ON ITS OWN PAGE---*
get "/contacts/:id/edit" do
  @contact = Contact.find_by({id: params[:id].to_i})

  erb :edit_contact
end


# *----THIS POST WILL ADD A NEW CONTACT INTO OUR CRM AND WILL THEN REDIRCT TO THE /CONTACTS PAGE----*
post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )
  redirect to('/contacts')
end


#*----ABOUT PAGE---*
get "/about" do
  erb :about
end


after do
  ActiveRecord::Base.connection.close
end
