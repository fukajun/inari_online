# frozen_string_literal: true

class Onlines::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :confirm]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def policy    
  end

  def confirm
    @online = Online.new(sign_up_params)
    @online.password = Devise.friendly_token.first(8) #パスワード自動生成

    # 学校名登録調整
    school = nil
    if !@online.high_school.blank?
      school = @online.high_school
    elsif !@online.junior_high_school.blank?
      school = @online.junior_high_school
    elsif !@online.elementary_school.blank?
      school = @online.elementary_school
    end
    @online.update(high_school: nil, junior_high_school: nil, elementary_school: nil)

    if @online.grade == nil
    elsif @online.grade.include?("高")
      @online.high_school = school
    elsif @online.grade.include?("中")
      @online.junior_high_school = school
    elsif @online.grade.include?("小")
      @online.elementary_school = school
    end

    if @online.valid?
      render :action => "confirm"
    else
      render :action => "new"
    end
  end

  # POST /resource
  def create
    @online = Online.new(sign_up_params)

    if params[:back] #登録画面に戻る
      render :new
      return
    else #完了画面に進む
      if (@online.course == "数IA 1回目")
        @online.math_iaf = 1
      elsif (@online.course == "数IIB 1回目")
        @online.math_iibf = 1
      elsif (@online.course == "数IIIC 1回目")
        @online.math_iiicf = 1
      end
      @online.save

      #Paymentテーブル作成
      @payment = Payment.new
      @payment.online_id = @online.id
      @payment.course = @online.course
      @payment.save

      redirect_to onlines_sign_up_complete_path(@online)
      RegistrationMailer.welcome(@online).deliver
      RegistrationMailer.welcome_parent(@online).deliver
    end

  #   super
  end

  def complete
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :high_school, :junior_high_school, :elementary_school, :grade, :postal_code, :prefecture, :address, :phone, :email, :parent_email, :course, :status])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
