class Math::IibFirstController < ApplicationController
  before_action :authenticate_online!

  def index
    @subject = Subject.find_by(online_id: current_online.id, course: 3)
    @studies = Study.where(online_id: current_online.id)
  end

  def postphone
    subject = Subject.find_by(online_id: current_online.id, course: 3)

    # 課題提出期限延長
    if subject.postphonement < 3
      checkDate = Calendar.where(check: true)
      lessonArray = Array.new
      checkDate.each do |i|
        date = i.start_time.strftime("%Y-%m-%d %H:%M:%S")
        lessonArray.push(date)
      end

      lessonId = subject.question
      lessonArray.each do |j|
        lessonColumn = "lesson#{lessonId}"
        if (subject[lessonColumn].strftime("%Y-%m-%d %H:%M:%S") == j)
          index = lessonArray.index(j)
          subject[lessonColumn] = lessonArray[index + 6]
          lessonId += 1
          break if lessonId > 22
        end
      end
      subject.postphonement += 1
      subject.update(subject_params)
    end

    redirect_to request.referer
  end

  def test
    parameter = params[:id].to_i
    questionNumber = "%02d" % params[:id]
    @questions = Question.where("title like ?", "math_iibf_test_#{questionNumber}%")
    questionId = Question.find_by("title like ?", "math_iibf_test_#{questionNumber}%")

    subject = Subject.find_by(online_id: current_online.id, course: 3)
    @study = Study.find_by(online_id: current_online.id, question_id: questionId.id) if (!questionId.nil?)

    if (@questions.empty?)
      access = false
    elsif (current_online.math_iibf == 4)
      access = true
    elsif (current_online.status == "有効")
      access = (parameter <= subject.question)? true : false
    else
      access = ((@study != nil) && (parameter <= subject.question))? true : false
    end

    if (access)
      if @study == nil
        @study = Study.new
        @study.online_id = current_online.id
        @study.question_id = questionId.id
        @study.save
        # 受講申請案内
        if questionNumber == "16"
          notification = Notification.new
          notification.title = "次の講座のご案内"
          notification.body = "次の講座の受講申請が可能です。"
          if notification.save
            notification_history = NotificationHistory.new
            notification_history.online_id = current_online.id
            notification_history.notification_id = notification.id
            notification_history.save
          end
        end
      end

      @timeArray = [@study.created_at, @study.answer_time]
    else
      @subject = subject
      @studies = Study.where(online_id: current_online.id)
      render "index"
    end
  end

  def test_answer
    @parameter = params[:id].to_i
    questionNumber = "%02d" % params[:id]
    @questions = Question.where("title like ?", "math_iibf_test_answer_#{questionNumber}%")
    questionId = Question.find_by("title like ?", "math_iibf_test_#{questionNumber}%")

    subject = Subject.find_by(online_id: current_online.id, course: 3)
    study = Study.find_by(online_id: current_online.id, question_id: questionId.id) if (!questionId.nil?)

    if (@questions.empty?)
      access = false
    elsif (current_online.math_iibf == 4)
      access = true
    elsif (current_online.status == "有効")
      if (subject.stage == 1)
        access = (@parameter < subject.question)? true : false
      elsif (subject.stage == 3)
        access = (@parameter <= subject.question)? true : false
      end
    else
      if (subject.stage == 1)
        access = ((study != nil) && (@parameter < subject.question))? true : false
      elsif (subject.stage == 3)
        access = ((study != nil) && (@parameter <= subject.question))? true : false
      end
    end

    if (!access)
      @subject = subject
      @studies = Study.where(online_id: current_online.id)
      render "index"
    end
  end

  def exercise
    parameter = params[:id].to_i
    questionNumber = "%02d" % params[:id]
    @questions = Question.where("title like ?", "math_iibf_exercise_#{questionNumber}%")
    questionId = Question.find_by("title like ?", "math_iibf_test_#{questionNumber}%")

    subject = Subject.find_by(online_id: current_online.id, course: 3)
    study = Study.find_by(online_id: current_online.id, question_id: questionId.id) if (!questionId.nil?)

    if (@questions.empty?)
      access = false
    elsif (current_online.math_iibf == 4)
      access = true
    elsif (current_online.status == "有効")
      if (subject.stage == 1)
        access = (parameter < subject.question)? true : false
      elsif (subject.stage == 3)
        access = (parameter <= subject.question)? true : false
      end
    else
      if (subject.stage == 1)
        access = ((study != nil) && (parameter < subject.question))? true : false
      elsif (subject.stage == 3)
        access = ((study != nil) && (parameter <= subject.question))? true : false
      end
    end

    if (!access)
      @subject = subject
      @studies = Study.where(online_id: current_online.id)
      render "index"
    end
  end

  def exercise_answer
    parameter = params[:id].to_i
    questionNumber = "%02d" % params[:id]
    @questions = Question.where("title like ?", "math_iibf_exercise_answer_#{questionNumber}%")
    questionId = Question.find_by("title like ?", "math_iibf_test_#{questionNumber}%")

    subject = Subject.find_by(online_id: current_online.id, course: 3)
    study = Study.find_by(online_id: current_online.id, question_id: questionId.id) if (!questionId.nil?)

    if (@questions.empty?)
      access = false
    elsif (current_online.math_iibf == 4)
      access = true
    elsif (current_online.status == "有効")
      access = (parameter < subject.question)? true : false
    else
      access = ((study != nil) && (parameter < subject.question))? true : false
    end

    if (!access)
      @subject = subject
      @studies = Study.where(online_id: current_online.id)
      render "index"
    end
  end

  def update
    questionNumber = "%02d" % params[:id]
    questionId = Question.find_by("title like ?", "math_iibf_test_#{questionNumber}%")

    subject = Subject.find_by(online_id: current_online.id, course: 3)
    study = Study.find_by(online_id: current_online.id, question_id: questionId.id)

    if params[:commit] != nil
      # 初回のみ回答時間登録
      if study.answer_time == nil
        currentTime = Time.now;
        startTime = study.created_at
        answerTime = currentTime - startTime
        study.answer_time = answerTime
      end
      study.update(study_params)

      # 単元テストの条件分岐
      if subject.question == params[:id].to_i
        if subject.question.in?([8, 15, 22])
          subject.update(question: subject.question + 1)
        else
          subject.update(stage: 3)
        end
      end
      # 単元修了処理
      if subject.question == 23
        current_online.update(math_iibf: 4)
        subject.update(stage: 0)

        # 次講座申請確認
        iibs = current_online.math_iibs
        iiicf = current_online.math_iiicf
        if (iibs == 2 || iiicf == 2)
          # Subjectテーブルに受講講座登録
          @subject = Subject.new
          @subject.online_id = current_online.id
          @subject.question = 1
          @subject.stage = 1

          # 受講講座開放
          if iibs == 2
            current_online.update(math_iibs: 3)
            @subject.course = 4
          elsif iiicf == 2
            current_online.update(math_iiicf: 3)
            @subject.course = 5
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
        end
      end
      redirect_to math_iib_first_test_answer_path(params[:id])
    else
      if subject.question == params[:id].to_i
        subject.update(question: subject.question + 1, stage: 1)
      end
      redirect_to math_iib_first_exercise_answer_path(params[:id])
    end
  end

  private
  def study_params
    params.require(:study).permit(answer_images_images: [])
  end

  def subject_params
    params.permit(:lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6, :lesson7, :lesson8, :lesson9, :lesson10, :lesson11, :lesson12, :lesson13, :lesson14, :lesson15, :lesson16, :lesson17, :lesson18, :lesson19, :lesson20, :lesson21, :lesson22, :postphonement)
  end
end
