module ApplicationHelper
  def mt_img_tracking
    if cookies[:current_visitor_id]
      href = "https://dev.monetrack.com/sys/sale.js"
      productInfo = []
      @order.line_items.each do |item|
        productInfo.push({
          product_id: item.variant.product.id.to_s,
          product_price: item.price.to_s,
          product_quantity: item.quantity.to_s,
          product_name: item.variant.product.name
        });
      end

      sale = {
        sale: {
          visitor_id: cookies[:current_visitor_id],
          order_id: @order.number,
          product_info: URI.escape(productInfo.to_json),
          referer_url: URI.escape(cookies[:referer_url])
        }
      }
      href+= "?" + sale.to_query
      image_tag href, width: 1, height: 1, alt: ""

    end
  end
end
