# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  
  def new
    super
  end

  def create
    if verify_recaptcha
      super
    else
      self.resource = resource_class.new
      respond_with_navigational(resource) { render :new }
    end
  end


  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
