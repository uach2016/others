require 'date'

class Charge
  def initialize
     @@charges = Array.new
  end 
  def add_charge charge
    @@charges << charge
  end
end

class Reminder < Charge
   def initialize rules
    @rules = rules
  end

  def on date, estates
  @reminders = Array.new
  
    estates.each do |estate|
      @@charges.each do |charge|
        if charge[:estate_code] == estate
          upcoming_dates = upcoming charge, date
            if  upcoming_dates.length > 0
              @reminders << {:estate => estate, :due_date => charge[:due_date]}
            end
        end
      end
    end
    count_reminders
  end
  
  def upcoming charge, date
    due_dates = Array.new
    
    @rules.each do |rule|
      if (rule[:period] == charge[:period]) && (rule[:time] == charge[:due_date])
        due_dates << charge[:due_date]
      end
    end
    due_dates
  end
  
  def count_reminders
    if @reminders.length > 0 
      frame
    else
      puts 'No reminders yet'
    end
  end
  def frame
    puts "+---------------+---------------------------------------+"
    puts "|Date           |Reminders                              |"           
    puts "+---------------+---------------------------------------+"
    show
  end
  def show 
    @reminders.each do |reminder|
        puts "|#{Date.today}""     |#{reminder[:estate] }  due date: #{reminder[:due_date]}            |" 
        puts "+---------------+---------------------------------------+"
    end
  end
end
  
charge1 = {
          :estate_code => "0066S", 
          :period => "Quarterly",
          :due_date => Date.new(2017, 1, 17)
        }
charge2 = {
          :estate_code => "0123S", 
          :period => "Twice a year",
          :due_date => Date.new(2017, 2, 17)
        }
charge3 = {
          :estate_code => "0250S", 
          :period => "Quarterly",
          :due_date => Date.new(2017, 1, 17)
        }

charge = Charge.new
charge.add_charge charge1
charge.add_charge charge2
charge.add_charge charge3
date = Date.today
estates = ['0066S', '0123S', '0250S']
rules =
    [
      { :period => 'Quarterly',    :time => date.next_month },
      { :period => 'Twice a year', :time =>  date.next_month.next_month}
    ]
    
reminder = Reminder.new(rules)
reminders = reminder.on(date, estates)