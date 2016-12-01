require 'date'

class Service_charge_payment
	attr_reader :estate_code, :service_charge_period, :due_date
	
	def initialize estate_code, service_charge_period, due_date
		@estate_code = estate_code
		@service_charge_period = service_charge_period
		@due_date = due_date
	end	
end

class Reminder 

	def initialize 
		@array_service_charge_payments = []
	end

	def add_service_charge_payment service_charge_payment
		@array_service_charge_payments.push(service_charge_payment)
	end

	def on
		@array_service_charge_payments.each do |service_charge_payment|
			#If service is 'Quarterly' get reminder one calendar month before service charge due date. 
	 		if Date.today == service_charge_payment.due_date.prev_month
	 			publish_reminder(service_charge_payment)
	 		end
	 		
	 		if Date.today == service_charge_payment.due_date<<2
	 			#if service is 'Twice a year' get reminder two calendar months before service charge due date.
	 			publish_reminder(service_charge_payment)
	 		end
		end
	end
	
	def publish_frame
		puts "+---------------+---------------------------------------+"
		puts "|Date           |Reminders                              |"           
		puts "+---------------+---------------------------------------+"
	end
	
	def publish_reminder service_charge_payment
	  	  puts "|#{Date.today}""	|#{service_charge_payment.estate_code}  due date: #{service_charge_payment.due_date}		|" 
	  	  puts "+------------------------+------------------------------+"
	end
end



a = Service_charge_payment.new("0066S", "Quarterly", Date.new(2016, 2, 1))
b =	Service_charge_payment.new("0066S", "Quarterly", Date.new(2016, 5, 3))
c =	Service_charge_payment.new("0066S", "Quarterly", Date.new(2016, 8, 1))
d =	Service_charge_payment.new("0066S", "Quarterly", Date.new(2016, 11, 5))
e =	Service_charge_payment.new("0123S", "Quarterly", Date.new(2016, 2, 28))
f =	Service_charge_payment.new("0123S", "Quarterly", Date.new(2016, 5, 31))
g =	Service_charge_payment.new("0123S", "Quarterly", Date.new(2016, 8, 31))
h =	Service_charge_payment.new("0123S", "Quarterly", Date.new(2016, 11, 30))
i =	Service_charge_payment.new("0250S", "Twice a year", Date.new(2016, 1, 23))
j =	Service_charge_payment.new("0250S", "Twice a year", Date.new(2016, 6, 22))
k = Service_charge_payment.new("0066w", "quarterly", Date.new(2016, 11, 20))
l = Service_charge_payment.new("0066w", "quarterly", Date.new(2016, 12, 20))
reminder = Reminder.new
reminder.add_service_charge_payment a
reminder.add_service_charge_payment b
reminder.add_service_charge_payment c
reminder.add_service_charge_payment d
reminder.add_service_charge_payment e
reminder.add_service_charge_payment f
reminder.add_service_charge_payment j
reminder.add_service_charge_payment h
reminder.add_service_charge_payment i
reminder.add_service_charge_payment j
reminder.add_service_charge_payment k
reminder.add_service_charge_payment l
reminder.publish_frame
reminder.on


RSpec.describe 'Reminder' do
	let(:reminder) {Reminder.new }
    
   it "works fine" do
      expect(reminder) == true
   end

   it "call method with wrong argument" do
    expect(reminder.add_service_charge_payment(1)) == false
   end

   it "call method" do
   	@reminder = Reminder.new
    expect(@reminder.on) == true
   end 
end