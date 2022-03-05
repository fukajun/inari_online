class Admin::PaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Online.ransack(params[:q])
    @onlines = @q.result(distinct: true)
    if params[:q_unpaid]
      @payments = Payment.where(online_id: @onlines, paid: false).order(id: "DESC").page(params[:page])
    else
      @payments = Payment.where(online_id: @onlines).order(id: "DESC").page(params[:page])
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    online = Online.find(params[:online_id])
    payment = Payment.find_by(online_id: params[:online_id], course: params[:id])
    courseNum = payment.course_before_type_cast
    paid = params[:paid]

    iaf = online.math_iaf
    ias = online.math_ias
    iibf = online.math_iibf
    iibs = online.math_iibs
    iiicf = online.math_iiicf
    iiics = online.math_iiics
    ex1f = online.math_ex1f
    ex1s = online.math_ex1s
    ex2f = online.math_ex2f
    ex2s = online.math_ex2s
    ex3f = online.math_ex3f
    ex3s = online.math_ex3s
    ex4f = online.math_ex4f
    ex4s = online.math_ex4s

    if courseNum <= 6
      (iaf != 3 && ias != 3 && iibf != 3 && iibs != 3 && iiicf != 3 && iiics != 3)? startable = true : startable = false
    elsif courseNum <= 10
      (ex1f != 3 && ex1s != 3 && ex2f != 3 && ex2s != 3)? startable = true : startable = false
    elsif courseNum <= 12
      (ex3f != 3 && ex3s != 3)? startable = true : startable = false
    elsif courseNum <= 14
      (ex4f != 3 && ex4s != 3)? startable = true : startable = false
    end

    if payment.update(paid: paid)
      # 受講生番号採番
      if online.membership_number == nil
        birthDay = online.birthday.strftime("%Y%m%d").to_i
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

        online.membership_number = newNumber
      end

      # 振込確認
      if payment.paid == true
        if startable
          # Subjectテーブルに受講講座登録
          subject = Subject.new
          subject.online_id = online.id
          subject.question = 1
          subject.stage = 1

          # 振込確認後に受講講座開放
          if courseNum == 1
            online.math_iaf = 3
            subject.course = 1
          elsif courseNum == 2
            online.math_ias = 3
            subject.course = 2
          elsif courseNum == 3
            online.math_iibf = 3
            subject.course = 3
          elsif courseNum == 4
            online.math_iibs = 3
            subject.course = 4
          elsif courseNum == 5
            online.math_iiicf = 3
            subject.course = 5
          elsif courseNum == 6
            online.math_iiics = 3
            subject.course = 6
          elsif courseNum == 7
            online.math_ex1f = 3
            subject.course = 7
          elsif courseNum == 8
            online.math_ex1s = 3
            subject.course = 8
          elsif courseNum == 9
            online.math_ex2f = 3
            subject.course = 9
          elsif courseNum == 10
            online.math_ex2s = 3
            subject.course = 10
          elsif courseNum == 11
            online.math_ex3f = 3
            subject.course = 11
          elsif courseNum == 12
            online.math_ex3s = 3
            subject.course = 12
          elsif courseNum == 13
            online.math_ex4f = 3
            subject.course = 13
          elsif courseNum == 14
            online.math_ex4s = 3
            subject.course = 14
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
                subject[lessonColumn] = date
                count = 0
                times += 1
                break if times > 22
              end
              count += 1
            end
          end
          subject.save
        else
          if courseNum == 1
            online.math_iaf = 2
          elsif courseNum == 2
            online.math_ias = 2
          elsif courseNum == 3
            online.math_iibf = 2
          elsif courseNum == 4
            online.math_iibs = 2
          elsif courseNum == 5
            online.math_iiicf = 2
          elsif courseNum == 6
            online.math_iiics = 2
          elsif courseNum == 7
            online.math_ex1f = 2
          elsif courseNum == 8
            online.math_ex1s = 2
          elsif courseNum == 9
            online.math_ex2f = 2
          elsif courseNum == 10
            online.math_ex2s = 2
          elsif courseNum == 11
            online.math_ex3f = 2
          elsif courseNum == 12
            online.math_ex3s = 2
          elsif courseNum == 13
            online.math_ex4f = 2
          elsif courseNum == 14
            online.math_ex4s = 2
          end
        end
      else
        # 振込確認破棄
        if courseNum == 1
          online.math_iaf = 1
        elsif courseNum == 2
          online.math_ias = 1
        elsif courseNum == 3
          online.math_iibf = 1
        elsif courseNum == 4
          online.math_iibs = 1
        elsif courseNum == 5
          online.math_iiicf = 1
        elsif courseNum == 6
          online.math_iiics = 1
        elsif courseNum == 7
          online.math_ex1f = 1
        elsif courseNum == 8
          online.math_ex1s = 1
        elsif courseNum == 9
          online.math_ex2f = 1
        elsif courseNum == 10
          online.math_ex2s = 1
        elsif courseNum == 11
          online.math_ex3f = 1
        elsif courseNum == 12
          online.math_ex3s = 1
        elsif courseNum == 13
          online.math_ex4f = 1
        elsif courseNum == 14
          online.math_ex4s = 1
        end
      end

      # 会員ステータス更新
      online.status = "有効" if (payment.paid == true)
      online.update(online_params)

      redirect_to request.referer
    end
  end

  def destroy
    payment = Payment.find_by(online_id: params[:online_id], course: params[:id])
    online = Online.find(payment.online_id)
    courseNum = payment.course_before_type_cast

    if courseNum == 1
      online.math_iaf = 0
    elsif courseNum == 2
      online.math_ias = 0
    elsif courseNum == 3
      online.math_iibf = 0
    elsif courseNum == 4
      online.math_iibs = 0
    elsif courseNum == 5
      online.math_iiicf = 0
    elsif courseNum == 6
      online.math_iiics = 0
    elsif courseNum == 7
      online.math_ex1f = 0
    elsif courseNum == 8
      online.math_ex1s = 0
    elsif courseNum == 9
      online.math_ex2f = 0
    elsif courseNum == 10
      online.math_ex2s = 0
    elsif courseNum == 11
      online.math_ex3f = 0
    elsif courseNum == 12
      online.math_ex3s = 0
    elsif courseNum == 13
      online.math_ex4f = 0
    elsif courseNum == 14
      online.math_ex4s = 0
    end

    online.update(online_params)
    subject = Subject.find_by(online_id: online.id, course: courseNum)
    payment.destroy
    subject.destroy if (!subject.nil?)

    redirect_to request.referer
  end

  private
  def online_params
    params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics, :math_ex1f, :math_ex1s, :math_ex2f, :math_ex2s, :math_ex3f, :math_ex3s, :math_ex4f, :math_ex4s, :membership_number, :status)
  end
end
