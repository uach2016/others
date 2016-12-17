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
  @date = date
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
    frame
  end

  def get_upcoming_date date, num_month
    upcoming_date = date << num_month
  end
  
  def upcoming charge, date
    due_dates = Array.new
    
    @rules.each do |rule|
      if (rule[:period] == charge[:period])
        upcoming_dates = get_upcoming_date charge[:due_date], rule[:time]
        if upcoming_dates == date
        due_dates << charge[:due_date]
        end
      end
    end
    due_dates
  end
  
  def frame
    puts "+---------------+---------------------------------------+"
    puts "|Date           |Reminders                              |"           
    puts "+---------------+---------------------------------------+"
    show
  end
  def show 
    if @reminders.length > 0 
      @reminders.each do |reminder|
          if reminder == @reminders[0]
          puts "|#{@date}     |#{reminder[:estate] }  due date: #{reminder[:due_date]}            |" 
          else 
            puts "|               |#{reminder[:estate] }  due date: #{reminder[:due_date]}            |" 
          end
       end
    else
      puts "|#{@date}     |(no reminders)                         |" 
    end
        puts "+---------------+---------------------------------------+"
  end
end
  
charge1 = {
          :estate_code => "0066S", 
          :period => "Quarterly",
          :due_date => Date.strptime('01/02/2013', '%d/%m/%Y')
        }
charge2 = {
          :estate_code => "0123S", 
          :period => "Twice a year",
          :due_date => Date.strptime('01/03/2013', '%d/%m/%Y')
        }
charge3 = {
          :estate_code => "0250S", 
          :period => "Quarterly",
          :due_date => Date.strptime('01/02/2013', '%d/%m/%Y')
        }

charge = Charge.new
charge.add_charge charge1
charge.add_charge charge2
charge.add_charge charge3


date = Date.strptime('01/01/2013', '%d/%m/%Y')
estates = ['0066S', '0123S', '0250S']
rules =
    [
      { :period => 'Quarterly',    :time => 1 },
      { :period => 'Twice a year', :time =>  2}
    ]
    
reminder = Reminder.new(rules)
reminders = reminder.on(date, estates)