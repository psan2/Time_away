require 'time'
require 'pry'

def help
  puts "This tool will help you plan your upcoming holiday and vacation time by tracking how much time off you will have accrued at a selected time in the future.\n
  You can enter:\n
  help - to show this message\n
  exit - to exit the program\n
  new - to enter new time off\n
  show - to view your currently scheduled time off\n
  config - to view and modify the current settings, like payday cadence and PTO allotment\n
  check - to check if you'll have enough PTO to take time off
  "
end

def get_user_input
  input = gets.chomp.to_s
  return input
end

def add_time_off
  puts "What would you like to name your vacation?"
  name = get_user_input
  puts "Please enter the start date of your vacation as dd/mm/yyyy:"
  start = Date.strptime(get_user_input,"%d/%m/%Y")
  puts "Please enter the end date of your vacation as dd/mm/yyyy:"
  finish = Date.strptime(get_user_input,"%d/%m/%Y")
  if (finish-start).to_i <= 1
    $vacation_cal[start.yday] = {
      name: name,
      date: start,
      holiday: false,
      pto_hours: -8
    }
  else
    temp=*(start.yday..finish.yday)
    temp.each do |day|
      $vacation_cal[day] = {
        name: name,
        date: Date.strptime(day.to_s,"%j"),
        holiday: false,
        pto_hours: -8
      }
      if $vacation_cal[day][:date].saturday? || $vacation_cal[day][:date].sunday?
        $vacation_cal[day][:pto_hours] = 0
      end
    end
  end
end

def generate_initial_calendar
  calendar = {}
  #initialize hash with UK holidays 2019
  calendar[Date.parse("1 January 2019").yday] = {
    name: "New Year's Day",
    date:Date.parse("1 January 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("19 April 2019").yday] = {
    name: "Good Friday",
    date:Date.parse("19 April 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("22 April 2019").yday] = {
    name: "Easter Monday",
    date:Date.parse("22 April 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("6 May 2019").yday] = {
    name: "Bank holiday",
    date:Date.parse("6 May 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("27 May 2019").yday] = {
    name: "Bank holiday",
    date:Date.parse("27 May 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("26 August 2019").yday] = {
    name: "Bank holiday",
    date:Date.parse("26 August 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("25 December 2019").yday] = {
    name: "Christmas Day",
    date:Date.parse("25 December 2019"),
    holiday: true,
    pto_hours: 0
  }

  calendar[Date.parse("26 December 2019").yday] = {
    name: "Boxing Day",
    date:Date.parse("26 December 2019"),
    holiday: true,
    pto_hours: 0
  }
  return calendar
end

def show_calendar
  $vacation_cal.sort.each do |day_of_year, holidays_info|
    puts "#{holidays_info[:name]}: #{holidays_info[:date].strftime("%d %b %Y")} | PTO Hours: " + (holidays_info[:pto_hours] <= 0 ? "#{holidays_info[:pto_hours].abs.to_s} spent" : "#{holidays_info[:pto_hours].abs.to_s} accrued")
  end
end

def listen
  input = ""
  until input == "exit"
    puts "Please enter a command:"
    input = get_user_input
    case input
    when "help"
      help
    when "new"
      add_time_off
    when "show"
      show_calendar
    when "config"
      #open configuration document
    when "check"
      #run check_pto_bank
    when "save"
      #save current vacation to file
    when "exit"
      break
    else
      puts "Please enter a valid command, or enter help to see your options."
    end
  end
  puts "Thank you, goodbye."
end

def runner
  $vacation_cal = generate_initial_calendar
  help
  listen
end

runner
