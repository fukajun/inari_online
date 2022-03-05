class PaymentsController < ApplicationController
  before_action :authenticate_online!

  def index
    stages = Array.new(14)
    for i in 0..13
      subject = Subject.find_by(online_id: current_online, course: i + 1)
      stages[i] = (subject != nil && subject.question >= 16)? 1 : 0
      if (subject.nil?)
        stages[i] = nil
      else
        stages[i] = (subject.question >= 16)? 1 : 0
      end
    end

    # 受講申請可否配列
    subjects = Array.new(14)
    14.times do |i|
      if i == 1 - 1
        subjects[i] = true
      elsif i == 2 - 1
        subjects[i] = true if (stages[0] == 1)
      elsif i == 3 - 1
        subjects[i] = true if (((stages[0] == 1) && (stages[1] == nil)) || (stages[1] == 1) || (stages[0] == nil))
      elsif i == 4 - 1
        subjects[i] = true if (stages[2] == 1)
      elsif i == 5 - 1
        subjects[i] = true if (((stages[2] == 1) && (stages[3] == nil)) || (stages[3] == 1) || ((stages[0] == nil) && (stages[2] == nil)))
      elsif i == 6 - 1
        subjects[i] = true if (stages[4] == 1)
      elsif i == 7 - 1
        subjects[i] = true
      elsif i == 8 - 1
        subjects[i] = true if (stages[6] == 1)
      elsif i == 9 - 1
        subjects[i] = true if (stages[7] == 1)
      elsif i == 10 - 1
        subjects[i] = true if (stages[8] == 1)
      elsif i == 11 - 1
        subjects[i] = true
      elsif i == 12 - 1
        subjects[i] = true if (stages[10] == 1)
      elsif i == 13 - 1
        subjects[i] = true
      elsif i == 14 - 1
        subjects[i] = true if (stages[12] == 1)
      end
    end

    # 支払い一覧表示内容配列
    @payments = Array.new(14).map{Array.new(3, "")}
    14.times do |i|
      payment = Payment.find_by(online_id: current_online, course: i + 1)
      @payments[i][0] = Payment.courses.key(i+1)
      if payment != nil
        @payments[i][1] = payment.created_at.strftime("%Y年%m月%d日")
        @payments[i][2] = (payment.paid)? "支払い済" : "入金待ち"
      else
        @payments[i][1] = subjects[i]
      end
    end
  end

  def create
    @payment = Payment.new
    @payment.online_id = current_online.id
    @payment.course = params[:course]

    if (@payment.course == "数IA 1回目")
      current_online.update(math_iaf: 1)
    elsif (@payment.course == "数IA 2回目")
      current_online.update(math_ias: 1)
    elsif (@payment.course == "数IIB 1回目")
      current_online.update(math_iibf: 1)
    elsif (@payment.course == "数IIB 2回目")
      current_online.update(math_iibs: 1)
    elsif (@payment.course == "数IIIC 1回目")
      current_online.update(math_iiicf: 1)
    elsif (@payment.course == "数IIIC 2回目")
      current_online.update(math_iiics: 1)
    elsif (@payment.course == "演習1 1回目(前半)")
      current_online.update(math_ex1f: 1)
    elsif (@payment.course == "演習1 1回目(後半)")
      current_online.update(math_ex1s: 1)
    elsif (@payment.course == "演習1 2回目(前半)")
      current_online.update(math_ex2f: 1)
    elsif (@payment.course == "演習1 2回目(後半)")
      current_online.update(math_ex2s: 1)
    elsif (@payment.course == "演習2(前半)")
      current_online.update(math_ex3f: 1)
    elsif (@payment.course == "演習2(後半)")
      current_online.update(math_ex3s: 1)
    elsif (@payment.course == "演習数III(前半)")
      current_online.update(math_ex4f: 1)
    elsif (@payment.course == "演習数III(後半)")
      current_online.update(math_ex4s: 1)
    end
    @payment.save
    redirect_to request.referer
    RegistrationMailer.course_application(current_online, @payment).deliver
  end
end
