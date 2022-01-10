class Admin::PaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Online.ransack(params[:q])
    @onlines = @q.result(distinct: true)
    if params[:unpaid]
      @payments = Payment.where(online_id: @onlines, paid: false).order(id: "DESC")
    else
      @payments = Payment.where(online_id: @onlines).order(id: "DESC")
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    @online = Online.find(@payment.online_id)
    if @payment.update(payment_params)
      # 受講生番号採番
      if @online.membership_number == nil
        birthDay = @online.birthday.strftime("%Y%m%d").to_i
        baseDate = 20020402
        diffYear = (birthDay - baseDate) / 10000

        if diffYear < 0 # 2020年以前受講生
          numbering = Numbering.find(1)
        else
          numbering = Numbering.find(diffYear + 2)
        end
        number = numbering.final_number.floor(-2)
        newNumber = number + 100 + rand(100)
        numbering.update(final_number: newNumber)

        @online.membership_number = newNumber
      end

      # 振込確認
      if @payment.paid == true
        # Subjectテーブルに教科登録
        @subject = Subject.new
        @subject.online_id = @online.id
        @subject.question = 1
        @subject.stage = 1

        # 振込確認後に学習教科開放
        if @payment.course == "数IA 1回目"
          @online.math_iaf = 2
          @subject.course = 1
        elsif @payment.course == "数IA 2回目"
          @online.math_ias = 2
          @subject.course = 2
        elsif @payment.course == "数IIB 1回目"
          @online.math_iibf = 2
          @subject.course = 3
        elsif @payment.course == "数IIB 2回目"
          @online.math_iibs = 2
          @subject.course = 4
        elsif @payment.course == "数IIIC 1回目"
          @online.math_iiicf = 2
          @subject.course = 5
        elsif @payment.course == "数IIIC 2回目"
          @online.math_iiics = 2
          @subject.course = 6
        end

        # Subjectテーブルに提出期限登録
        checkDate = Calendar.where(check: true)
        today = Time.current
        lessonArray = Array.new
        count = -2
        times = 1
        checkDate.each do |i|
          date = i.start_time.strftime("%Y-%m-%d %H:%M:%S")
          if today < i.start_time - (9 * 60 * 60)
            if count > 5
              lessonArray.push(date)
              lessonColumn = "lesson#{times}"
              @subject[lessonColumn] = date
              count = 0
              times += 1
              break if times > 22
            end
            count += 1
          end
        end
        @subject.save
      else
        # 振込確認破棄
        if @payment.course == "数IA 1回目"
          @online.math_iaf = 1
          @subject = Subject.find_by(online_id: @online.id, course: 1)
        elsif @payment.course == "数IA 2回目"
          @online.math_ias = 1
          @subject = Subject.find_by(online_id: @online.id, course: 2)
        elsif @payment.course == "数IIB 1回目"
          @online.math_iibf = 1
          @subject = Subject.find_by(online_id: @online.id, course: 3)
        elsif @payment.course == "数IIB 2回目"
          @online.math_iibs = 1
          @subject = Subject.find_by(online_id: @online.id, course: 4)
        elsif @payment.course == "数IIIC 1回目"
          @online.math_iiicf = 1
          @subject = Subject.find_by(online_id: @online.id, course: 5)
        elsif @payment.course == "数IIIC 2回目"
          @online.math_iiics = 1
          @subject = Subject.find_by(online_id: @online.id, course: 6)
        end
        @subject.destroy
      end

      # 会員ステータス更新
      if @payment.paid == true
        @online.status = "有効"
      end

      @online.update(online_params)

      @status = "success"
    else
      @status = "fail"
    end
    render 'update.js.erb'
  end

  def destroy
    @payment = Payment.find(params[:id])
    online = Online.find(@payment.online_id)

    if (@payment.course == "数IA 1回目")
      online.math_iaf = 0
      subject = Subject.find_by(online_id: online.id, course: 1)
    elsif (@payment.course == "数IA 2回目")
      online.math_ias = 0
      subject = Subject.find_by(online_id: online.id, course: 2)
    elsif (@payment.course == "数IIB 1回目")
      online.math_iibf = 0
      subject = Subject.find_by(online_id: online.id, course: 3)
    elsif (@payment.course == "数IIB 2回目")
      online.math_iibs = 0
      subject = Subject.find_by(online_id: online.id, course: 4)
    elsif (@payment.course == "数IIIC 1回目")
      online.math_iiicf = 0
      subject = Subject.find_by(online_id: online.id, course: 5)
    elsif (@payment.course == "数IIIC 2回目")
      online.math_iiics = 0
      subject = Subject.find_by(online_id: online.id, course: 6)
    end

    online.update(online_params)
    @payment.destroy
    subject.destroy

    redirect_to request.referer
  end

  private
  def payment_params
    params.require(:payment).permit(:course, :paid)
  end

  def online_params
    params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics, :membership_number, :status)
  end
end
