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

  def render_signup_lead_img
    if cookies[:current_visitor_id] && cookies[:signup]
      cookies.delete :signup
      href = "https://dev.monetrack.com/sys/lead.js"

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        lead: {
          visitor_id: cookies[:current_visitor_id],
          action_id: 'signup',
          action_email: action_email,
          order_id: SecureRandom.urlsafe_base64
        }
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_signin_lead_img
    if cookies[:current_visitor_id] && cookies[:signin]
      cookies.delete :signin
      href = "https://dev.monetrack.com/sys/lead.js"

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        lead: {
          visitor_id: cookies[:current_visitor_id],
          action_id: 'signin',
          action_email: action_email,
          order_id: SecureRandom.urlsafe_base64
        }
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_logout_lead_img
    if cookies[:current_visitor_id] && cookies[:logout]
      cookies.delete :logout
      href = "https://dev.monetrack.com/sys/lead.js"

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        lead: {
          visitor_id: cookies[:current_visitor_id],
          action_id: 'logout',
          action_email: action_email,
          order_id: SecureRandom.urlsafe_base64
        }
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end

  def render_search_lead_img
    search_trigger = (params[:taxon].to_s != session[:taxon].to_s) || (params[:keywords].to_s != session[:keywords].to_s)
    session[:taxon] = params[:taxon]
    session[:keywords] = params[:keywords]
    if cookies[:current_visitor_id] && search_trigger
      href = "https://dev.monetrack.com/sys/lead.js"

      action_email = try_spree_current_user ? try_spree_current_user.email : "anonymous@example.com"
      lead = {
        lead: {
          visitor_id: cookies[:current_visitor_id],
          action_id: 'search',
          action_email: action_email,
          order_id: SecureRandom.urlsafe_base64
        }
      }
      href+= "?" + lead.to_query
      image_tag href, width: 1, height: 1, alt: ""
    end
  end
end
