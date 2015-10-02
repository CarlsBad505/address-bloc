require_relative '../models/address_book'

class MenuController
    attr_accessor :address_book
    
    def initialize
      @address_book = AddressBook.new
    end
    
    def main_menu
        puts "Main Menu - #{@address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - View entry by number"
        puts "3 - Create an entry"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "6 - Delete all entries"
        puts "7 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i
        puts "You picked #{selection}"
        
        case selection
        when 1
          system "clear"
          view_all_entries
          main_menu
        when 2
          system "clear"
          view_by_num
          main_menu
        when 3
          system "clear"
          create_entry
          main_menu
        when 4
          system "clear"
          search_entry
          main_menu
        when 5
          system "clear"
          read_csv
          main_menu
        when 6
          system "clear"
          nuke
          puts "All entries deleted"
          main menu
        when 7
          puts "Goodbye!"
          exit(0)
        else
          system "clear"
          puts "Sorry, that is not a valid entry"
          main_menu
        end
    end
    
    def view_all_entries
        @address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
          entry_submenu(entry)
        end
        system "clear"
        puts "End of Entries"
    end
    
    def view_by_num
        system "clear"
        print "Enter your entry number: "
        selection = gets.chomp.to_i
        
        if selection <= @address_book.entries.size
          puts @address_book.entries[selection]
          puts "Push enter to return to main menu"
          gets.chomp
          system "clear"
        elsif selection > @address_book.entries.size
          puts "Entry was not found, please try again"
        end
        view_by_num
    end
    
    def create_entry
        system "clear"
        puts "Add New Entry"
        
        print "Name: "
        name = gets.chomp
        print "Phone Number: "
        phone_number = gets.chomp
        print "Email: "
        email = gets.chomp
        
        @address_book.add_entry(name, phone_number, email)
        system "clear"
        puts "New Entry Created!"
    end
    
    def search_entry
      print "Search by Name: "
      name = gets.chomp
      match = @address_book.binary_search(name)
      if match
        puts match.to_s # <---- Get rid of to_s and see what happens
        search_submenu
      else
        puts "No match found for #{name}"
      end
    end
    
    def read_csv
      print "Enter CSV file to be imported: "
      file_name = gets.chomp
       if file_name.empty?
         system "clear"
         puts "No CSV File"
         main_menu
       end
       
       begin
         entry_count = @address.import_from_csv(file_name).count
         system "clear"
         puts "#{entry_count} entries have been added from #{file_name}"
       rescue
         puts "#{file_name} is invalid, please try again."
         read_csv
       end
    end
    
    def nuke
      @address_book.entries.delete.all
    end
    
    def entry_submenu(entry)
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        selection = gets.chomp
        
        case selection
          when "n"
          when "d"
            delete_entry(entry)
            main menu
          when "e"
            edit_entry(entry)
            entry_submenu(entry)
          when "m"
            system "clear"
            main_menu
          else
            system "clear"
            puts "#{selection} is invalid"
            entry_submenu(entry)
        end
    end
    
    def delete_entry(entry)
      @address_book.entries.delete(entry)
      puts "#{entry} has been deleted"
    end
    
    def edit_entry(entry)
      print "Updated Name: "
      name = gets.chomp
      print "Updated Phone Number: "
      phone_number = gets.chomp
      print "Updated Email: "
      email = gets.chomp
      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"
      puts "Updated Entry:"
      puts entry
    end
    
    def search_submenu(entry)
      puts "\nd - delete entry"
      puts "e - edit entry"
      puts "m - return to main menu"
      selection = gets.chomp
      
      case selection
        when "d"
          system "clear"
          delete_entry(entry)
          main_menu
        when "e"
          edit_entry(entry)
          system "clear"
          main_menu
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is invalid, please try again"
          puts entry
          search_submenu(entry)
      end
    end
end