class AdminController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'secret'

  layout 'admin'
end
