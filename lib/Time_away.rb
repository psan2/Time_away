require 'time'

def help
  puts "This tool will help you plan your upcoming holiday and vacation time by tracking how much time off you will have accrued at a selected time in the future.\n
  You can enter:\n
  help - to show this message\n
  exit - to exit the program\n
  new - to enter new time off\n
  show - to view your currently scheduled time off\n
  config - to view and modify the current settings, like payday cadence and PTO allotment\n
  plan - to check if you'll have enough PTO to take time off
  "
end

def get_user_input
  input = gets.chomp
  return input
end

def create_vacation_calendar
  calendar = {}
  puts "Please enter the start date of your vacation as dd/mm/yyyy:"
  start = Time.strptime(get_user_input,"%d/%m/%Y")
end
