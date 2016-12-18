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
          upcoming_dates = upcoming charge
          if upcoming_dates.any?
            @reminders << {:estate => estate, :due_dates => upcoming_dates}
          end
        end
      end
    end
  @reminders
  frame
  show @reminders
  end

 def get_upcoming_date due_dates, rule_time
   dates = Array.new
   due_dates.each do |due_date|
    if due_date << rule_time == @date
    dates.push(due_date)
    end
   end
   dates
  end
  
  def upcoming charge
    due_dates = Array.new
  
    @rules.each do |rule|
      if (rule[:period] == charge[:period])
      upcoming_dates = get_upcoming_date charge[:due_dates], rule[:time]
      if upcoming_dates.any?
       due_dates << upcoming_dates
     end
      end
    end
    due_dates
  end

  def frame
    puts "+---------------+---------------------------------------+"
    puts "|Date           |Reminders                              |"           
    puts "+---------------+---------------------------------------+"
  end
   def show reminders
    if reminders.length > 0 
      reminders.each do |reminder|
        if reminder == @reminders[0]
           reminder[:due_dates].each do |due_date|
             if due_date.any?
                print "|#{@date}     |#{reminder[:estate] } due date "
                due_date.each {|due_date| print due_date.strftime('%d %b %Y')}
                puts "             |"
              end
           end
        else
          reminder[:due_dates].each do |due_date|
            if due_date.any?
              print "|               |#{reminder[:estate] } due date "
              due_date.each {|due_date| print due_date.strftime('%d %b %Y')}
              print "             |"
              print "\n"
            end
          end
        end
      end
    else 
      puts "|#{@date}     |(no reminders)                         |"
    end
    finish_frame
  end
  def finish_frame
    puts "+-------------------------------------------------------+"
  end
end
  

  
charge1 = {
          :estate_code => "0066S", 
          :period => "Quarterly",
          :due_dates => [Date.strptime('02/02/2013', '%d/%m/%Y')]
        }
charge2 = {
          :estate_code => "0123S", 
          :period => "Twice a year",
          :due_dates => [Date.strptime('02/03/2013', '%d/%m/%Y')]
        }
charge3 = {
          :estate_code => "0250S", 
          :period => "Quarterly",
          :due_dates => [Date.strptime('02/02/2013', '%d/%m/%Y')]
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
      { :period => 'Twice a year', :time => 2 }
    ]
    
reminder = Reminder.new(rules)
reminders = reminder.on(date, estates)