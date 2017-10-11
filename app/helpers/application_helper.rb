module ApplicationHelper
  def mt_img_tracking
    href = SALE_URL
    productInfo = ""
    @order.line_items.each_with_index do |item, index|
      info = {
        "product_id_#{index+1}"=> item.variant.product.id.to_s,
        "price_#{index+1}"=> item.price.to_s,
        "quantity_#{index+1}"=> item.quantity.to_s,
        "product_name_#{index+1}"=> item.variant.product.name
      }
      productInfo += (info.to_query + "&")
    end

    sale = {
      merchant_token: "Merc02032017",
      order_id: @order.number,# + SecureRandom.urlsafe_base64,
      product_info: URI.escape(productInfo.to_json),
      referer_url: ""#URI.escape(cookies[:referer_url])
    }
    href+= "?" + sale.to_query + "&" + productInfo
    image_tag href, width: 1, height: 1, alt: ""
  end

  def render_signup_lead_img
    if cookies[:signup]
      cookies.delete :signup
      href = LEAD_URL

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        merchant_token: "Merc02032017",
        action_id: 'signup',
        action_email: action_email,
        order_id: SecureRandom.urlsafe_base64
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_signin_lead_img
    if cookies[:signin]
      cookies.delete :signin
      href = LEAD_URL

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        merchant_token: "Merc02032017",
        action_id: 'signin',
        action_email: action_email,
        order_id: SecureRandom.urlsafe_base64
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_logout_lead_img
    if cookies[:logout]
      cookies.delete :logout
      href = LEAD_URL

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        merchant_token: "Merc02032017",
        action_id: 'logout',
        action_email: action_email,
        order_id: SecureRandom.urlsafe_base64
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_search_lead_img
    search_trigger = (params[:taxon].to_s != session[:taxon].to_s) || (params[:keywords].to_s != session[:keywords].to_s)
    session[:taxon] = params[:taxon]
    session[:keywords] = params[:keywords]
    if search_trigger
      href = LEAD_URL

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        merchant_token: "Merc02032017",
        action_id: 'search',
        action_email: action_email,
        order_id: SecureRandom.urlsafe_base64
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end
end
