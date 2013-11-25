Spree::Admin::OrdersController.class_eval do
  respond_to :pdf
  require "prawn"
  require "prawn/layout"
 def show
  load_order
   @order = order.find(params[:number])
   respond_to do |format|
     format.pdf do
        pdf = Prawn::Document.new(@order)
        send_data pdf.render, filename: "order_#{}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
     end
   end
 end

end