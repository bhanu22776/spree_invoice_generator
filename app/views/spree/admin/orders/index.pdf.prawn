require 'prawn'
require 'prawn/layout'


#render "Invoice" for Orders.
##################################################


@orders.each do |orders|


pdf.font "Times-Roman"
pdf.font_size 12

#Logo company
##################################################
     logo_path = "#{Rails.root.to_s}/app/assets/images/#{Spree::PrintInvoiceConfig[:print_invoice_logo_path]}"
     pdf.image logo_path, :width => 150, :height => 35, :position => :left
     pdf.text "Invoice", :size => 30,:style => :bold, :align => :right ,:position => :right

     pdf.move_down 10


#Company Name
##################################################
        pdf.text "#{Spree::Company::Config.company_name}",:size => 20, :style => :bold
        pdf.text " #{Spree::Company::Config.company_slogan}",:size => 13
        pdf.move_down 10


#Company Details
##################################################
y_position = pdf.cursor - 10
pdf.bounding_box([0, y_position], :width => 250, :height => 150) do
        pdf.transparent(0.0) { pdf.stroke_bounds }
        pdf.text "#{Spree::Company::Config.company_street}      #{Spree::Company::Config.company_address_number}"
        pdf.text "#{Spree::Company::Config.company_zip}        #{Spree::Company::Config.company_city}"
        pdf.text "#{Spree::Company::Config.company_phone}     Fax : #{Spree::Company::Config.company_fax}"
        pdf.text "#{Spree::Company::Config.company_website}  #{Spree::Company::Config.company_email}"
        pdf.text " VAT Number : #{Spree::Company::Config.company_vatnumber}"
end

#Invoice Information
##################################################
    pdf.bounding_box([280, y_position], :width => 250, :height => 100) do
        pdf.transparent(0.0) { pdf.stroke_bounds }
        pdf.text "INVOICE DATE : #{(orders.created_at.to_date)}",:align => :right
        pdf.text "INVOICE NUMBER : #{(orders.number.to_s)}", :align => :right
        pdf.text "TRANSCTION DATE :#{(orders.updated_at.to_date)}", :align => :right
        pdf.text "ACCOUNT : #{Spree::Company::Config.company_bannumber}" , align: :right
        pdf.text "BIC : #{Spree::Company::Config.company_bicnumber}" ,align: :right
    end
pdf.move_down 15


#
#Customer Billing Address Information
##################################################
y_position = pdf.cursor - 0
pdf.bounding_box([0, y_position], :width => 200, :height => 100) do

    pdf.transparent(0.0) { pdf.stroke_bounds }
    pdf.text "To:",:size => 15, :style => :bold,:align => :left

     pdf.text "#{orders.bill_address.first_name}  #{orders.bill_address.lastname}"
     pdf.text "#{orders.bill_address.address1}  #{orders.bill_address.address2}"
     pdf.text "#{orders.bill_address.zipcode} #{orders.bill_address.city} #{orders.bill_address.state_name}"
     pdf.text "#{orders.bill_address.vat_number}"
end

#Customer Shipping Address Information
##################################################
    pdf.bounding_box([340, y_position], :width => 180, :height => 100) do
        pdf.transparent(0.0) { pdf.stroke_bounds }
        pdf.text "SHIP To:",:size => 15, :style => :bold
             pdf.text "#{orders.ship_address.first_name}  #{orders.ship_address.lastname}"
             pdf.text "#{orders.ship_address.address1}  #{orders.ship_address.address2}"
             pdf.text "#{orders.ship_address.zipcode} #{orders.ship_address.city} #{orders.ship_address.state_name}"
             pdf.text "Phone :#{orders.ship_address.phone}"
    end



# Information Comments  Ends Here.
##################################################

pdf.move_down 3
pdf.text "COMMENTS OR SPECIAL INSTRUCTIONS",:style => :bold
pdf.text "#{orders.special_instructions}"
pdf. stroke_horizontal_rule
pdf.move_down  30


orders.line_items.each do |item|
@name= item.variant.product.name
@item_price = number_to_currency(item.price)
@total = number_to_currency(item.price * item.quantity)

end

pdf.table([ ["Quantity", "Description", "Unit Price","Base Price","VAT%","VAT","Total"],
            ["#{orders.item_count}","#{@name}","#{@item_price}","#{orders.display_item_total}","#{Spree::TaxRate.first.amount.to_s}","#{number_to_currency  orders.tax_total}","#{orders.display_item_total}"],
                                    ["","","","","","SUB-Total","#{orders.display_item_total}"],
                                    ["","","","","","VAT","#{orders.tax_total}"],
                                    ["","","","","","SHIPPING & HANDLINGL","#{orders.display_ship_total}"],
                                    ["","","","","","COUPON DISCOUN",""],
                                    ["","","","","","TOTAL DUE","#{orders.display_total}"]])








 pdf.move_cursor_to 50
 pdf.stroke_horizontal_rule
 pdf.move_down 5
 pdf.text "Payment is due to within 30 days after invoice date.If you have any questions concering this invoice"
 pdf.text "Contact -- #{Spree::Company::Config.company_name} ,  #{Spree::Company::Config.company_phone} , or  #{Spree::Company::Config.company_email}"

  #Starting New Page
   pdf.start_new_page


end

