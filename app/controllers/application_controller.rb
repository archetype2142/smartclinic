class ApplicationController < ActionController::Base
	include ApplicationHelper
  
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == "application/json" }
	
	prepend_before_action do
    locale = choose_locale
    locale = :en unless locale && locale.to_sym.in?(I18n.available_locales)

    I18n.locale = locale

    if params[:locale] && !cookies[:lang]
      cookies[:lang] = locale
    end
  end

	def choose_locale
    i18n_from_param = params[:locale]&.to_sym
    i18n_from_cookie = cookies[:lang]&.to_sym

    return i18n_from_param if i18n_from_param.in?(I18n.available_locales)
    return i18n_from_cookie if i18n_from_cookie.in?(I18n.available_locales)
    return http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
  end
end
