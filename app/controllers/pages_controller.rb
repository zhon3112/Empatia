class PagesController < ApplicationController
  before_action :require_login, except: [:terms, :privacy_policy]

  def terms
    render 'pages/terms'
  end

  def privacy_policy
    render 'pages/privacy_policy'
  end
end
