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
        puts "6 - Exit"
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
    end
    
    def read_csv
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
          when "e"
          when "m"
            system "clear"
            main_menu
          else
            system "clear"
            puts "#{selection} is invalid"
            entry_submenu(entry)
        end
    end
end