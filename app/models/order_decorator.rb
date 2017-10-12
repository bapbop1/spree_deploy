Spree::Order.class_eval do
  checkout_flow do
  go_to_state :address
  go_to_state :payment, :if => lambda { |order| order.payment_required? }
   go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
   go_to_state :complete
   remove_transition :from => :delivery, :to => :confirm
  end
end

# change status shipment
Spree::Payment.class_eval do
	self.state_machine.after_transition :to => :completed, :do => :api_payment
  def api_payment
    options = {body: { "order_id" => self.order.number, "total_amount" => self.order.total, "status" => "approved" } }
    call_api(options)
  end
end

Spree::Order.class_eval do
	self.state_machine.after_transition :to => :canceled, :do => :api_order
  def api_order
    options = {body: { "order_id" => self.number, "total_amount" => self.total, "status" => "declined" } }
    call_api(options)
  end
end


def call_api(options)
  options[:body]["api_token"] = "lvLwEfEXic2d8Y7rKZR7MQ"
  response = HTTParty.post('https://dev.monetrack.com/api/v1/merchants/update_transaction_status', options)
  puts response.body, response.code, response.message, response.headers.inspect
end