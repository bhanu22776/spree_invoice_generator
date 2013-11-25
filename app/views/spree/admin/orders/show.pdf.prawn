	       
require 'prawn'
require 'prawn/layout'	       

#Logo company
pdf.image "#{Rails.root.to_s}/public/assets/#{Spree::PrintInvoiceConfig[:print_invoice_logo_path]}"
pdf.stroke_horizontal_rule
pdf.move_down 10

#Company Name
pdf.text "Company Name : #{}"
pdf.text "Company Slogan"

#Company Details


	pdf.text "Company Street"
	pdf.text "Company Address Number"
	pdf.text "Company Zip"
	pdf.text "Company Phone"
	pdf.text "Company Website"
	pdf.text "Company VATNUMBER"
	pdf.fill_color "000000"



pdf.font "Helvetica"


pdf.text "INVOICE"
pdf.move_down 10

pdf.stroke_horizontal_rule
pdf.move_down 4
pdf.text "Invoice Number"
        pdf.move_down 2
pdf.text @order.number.to_s
pdf.stroke_horizontal_rule
pdf.move_down 10

pdf.text @order.item_total.to_s
pdf.move_down 5
pdf.text @order.adjustment_total.to_s
	pdf.move_down 5

pdf.text @order.total.to_s
pdf.text @order.state
pdf.move_down 5

pdf.text @order.email.to_s	
pdf.text @order.user_id.to_s
pdf.text @order.completed_at.to_s
pdf.text @order.bill_address_id.to_s
pdf.text @order.ship_address_id.to_s
pdf.text @order.shipment_state.to_s
pdf.text @order.payment_state.to_s
pdf.text @order.outstanding_balance.to_s

# Address Stuff


pdf.text  @order.email 



####################
	       pdf.font "Helvetica"


	       pdf.text "INVOICE",:size => 40, :style => :bold
	       pdf.move_down 10

			pdf.stroke_horizontal_rule
	        pdf.move_down 4
            pdf.text "Invoice Number"
                    pdf.move_down 2
	        pdf.text @order.number.to_s,:size => 30, :style => :bold

			pdf.stroke_horizontal_rule
	        pdf.move_down 10

			pdf.text @order.item_total.to_s
			pdf.move_down 5
		    pdf.text @order.adjustment_total.to_s
	   		pdf.move_down 5

			pdf.text @order.total.to_s
		    pdf.text @order.state
			pdf.move_down 5

			pdf.text @order.email.to_s	
		    pdf.text @order.user_id.to_s
			pdf.text @order.completed_at.to_s
		    pdf.text @order.bill_address_id.to_s
			pdf.text @order.ship_address_id.to_s
		    pdf.text @order.shipment_state.to_s
		    pdf.text @order.payment_state.to_s
			pdf.text @order.outstanding_balance.to_s

			# Address Stuff

 
           pdf.text  @order.email 


   #############################################################################



pdf.text @order.item_total.to_s
pdf.move_down 5
pdf.text @order.adjustment_total.to_s
pdf.move_down 5

pdf.text @order.total.to_s
pdf.text @order.state
pdf.move_down 5

pdf.text @order.email.to_s
pdf.text @order.user_id.to_s
pdf.text @order.completed_at.to_s
pdf.text @order.bill_address_id.to_s
pdf.text @order.ship_address_id.to_s
pdf.text @order.shipment_state.to_s
pdf.text @order.payment_state.to_s
pdf.text @order.outstanding_balance.to_s
  #####################################################333


require 'prawn'
require 'prawn/layout'

#Logo company
##################################
           pdf.font "Helvetica"
           pdf.image "#{Rails.root.to_s}/public/assets/#{Spree::PrintInvoiceConfig[:print_invoice_logo_path]}" ,width:70 ,height:30
           pdf.text "Invoice",size: 25  ,style: :bold ,align:  :right
           pdf.stroke_horizontal_rule

pdf.move_down 10

#Company Name && Company Slogan
##################################

pdf.text "#{Spree::Company::Config.company_name}",style: :bold,size: 20
pdf.text "#{Spree::Company::Config.company_slogan} "

pdf.move_down 10

#Company Details
##################################

y_position = pdf.cursor - 10
pdf.bounding_box([0, y_position], width: 250, height: 150) do
pdf.transparent(0.0) { pdf.stroke_bounds }
 pdf.text "Company Address",style: :bold
 pdf.move_down 5
     pdf.text "#{Spree::Company::Config.company_street}      #{Spree::Company::Config.company_address_number}"
     pdf.text "#{Spree::Company::Config.company_zip}        #{Spree::Company::Config.company_city}"
     pdf.text "#{Spree::Company::Config.company_phone}  Fax : #{Spree::Company::Config.company_fax}"
     pdf.text "#{Spree::Company::Config.company_website}  #{Spree::Company::Config.company_email}"
     pdf.text " VAT Number : #{Spree::Company::Config.company_vatnumber}"
end

#Invoice Details
##################################

pdf.bounding_box([300, y_position], width: 250, height: 150) do
pdf.transparent(0.0) { pdf.stroke_bounds }
  pdf.text "Transction Date : #{@order.created_at.to_date}",align: :right
  pdf.text "INVOICE NUMBER : #{(@order.number.to_s)}"  ,align: :right
  pdf.text "TRANSCTION DATE :#{(@order.updated_at.to_date)}"   ,align: :right
  pdf.text "ACCOUNT : BAN NUMBER", align: :right
  pdf.text "company BIC : BIC NUMBER",align: :right
end


#Billing Address Details
##################################
y_position = pdf.cursor - 10
pdf.bounding_box([0, y_position], width: 200, height: 100) do
pdf.transparent(0.0) { pdf.stroke_bounds }
 pdf.text "To:",size:15 , style: :bold,align: :left
         pdf.text "#{@order.bill_address.first_name}  #{@order.bill_address.lastname}"
          pdf.text "#{@order.bill_address.address1}  #{@order.bill_address.address2}"
          pdf.text "#{@order.bill_address.zipcode} #{@order.bill_address.city} #{@order.bill_address.state_name}"
          pdf.text "#{@order.bill_address.vat_number}"
end

#Shipping Address Details
##################################

pdf.bounding_box([300, y_position], width: 200, height: 100) do
pdf.transparent(0.0) { pdf.stroke_bounds }
 pdf.text "SHIP To:",size:15 , style: :bold,align: :left
 pdf.text "#{@order.ship_address.first_name}  #{@order.ship_address.lastname}"
pdf.text "#{@order.ship_address.address1}  #{@order.ship_address.address2}"
pdf.text "#{@order.ship_address.zipcode} #{@order.ship_address.city} #{@order.ship_address.state_name}"
pdf.text "Phone :#{@order.ship_address.phone}"
end

# Information Comments  Ends Here.
##################################

pdf.text "COMMENTS OR SPECIAL INSTRUCTIONS",style: :bold
pdf.text "#{@order.special_instructions.inspect}",style: :bold
pdf. stroke_horizontal_rule


# Order Information // Line Items
##################################
# Information Comments  Ends Here.
##################################
pdf.move_down 10
pdf.stroke_horizontal_rule

 @order.line_items.each do |item|
 @name= item.variant.product.name
 @item_price = number_to_currency(item.price)
 @quantity = item.quantity.to_s
 @total = number_to_currency(item.price * item.quantity)
 #@discount = number_to_currency(-1 * item.discount)
 #@total_discount = number_to_currency(-1 * item.discount * item.quantity)
 @name1 = item.variant.options_text.inspect
 end

 @order.adjustments.eligible.each do |adjustment|
    next if (adjustment.originator_type == 'Spree::TaxRate') and (adjustment.amount == 0)
   next if (adjustment.amount == 0)
   @product_adjustment_label =  adjustment.label
   @product_adjustment =
  end
# LIne Items / Order Data in Table
##################################

  pdf.table([ ["Quantity", "Description", "Unit Price","Base Price","VAT%","VAT","Total"],

                  ["#{@quantity}","#{@name}","#{@item_price}","#{@total}","#{@product_adjustment}","#{@order.tax_total.to_s}","#{}"],
                                         ])






#  Footer
##############################################

 pdf.move_cursor_to 50
 pdf.stroke_horizontal_rule
 pdf.move_down 5
 pdf.text "Payment is due to within 30 days after invoice date.If you have any questions concering this invoice"
 pdf.text "Contact :: #{Spree::Company::Config.company_name},#{Spree::Company::Config.company_phone},or #{Spree::Company::Config.company_email}",style: :bold



#  PDF ENDS HERE
##############################################


 pdf.text @name
 pdf.text @item_price
 pdf.text @quantity
 pdf.text @total
# pdf.text @discount
 pdf.text @total_discount.to_s