class Admin::OnlinesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Online.ransack(params[:q])
    if params[:q_online_all]
      @onlines = @q.result(distinct: true).order(membership_number: "ASC").page(params[:page]).per(50)
    else
      @onlines = @q.result(distinct: true).where(status: true).order(membership_number: "ASC").page(params[:page]).per(50)
    end

    @courses = Online.courses.keys

    # 受講生数
    @learningCount = Array.new(14)
    @learningCount[0] = Online.where(math_iaf: 3, status: true).count
    @learningCount[1] = Online.where(math_ias: 3, status: true).count
    @learningCount[2] = Online.where(math_iibf: 3, status: true).count
    @learningCount[3] = Online.where(math_iibs: 3, status: true).count
    @learningCount[4] = Online.where(math_iiicf: 3, status: true).count
    @learningCount[5] = Online.where(math_iiics: 3, status: true).count
    @learningCount[6] = Online.where(math_ex1f: 3, status: true).count
    @learningCount[7] = Online.where(math_ex1s: 3, status: true).count
    @learningCount[8] = Online.where(math_ex2f: 3, status: true).count
    @learningCount[9] = Online.where(math_ex2s: 3, status: true).count
    @learningCount[10] = Online.where(math_ex3f: 3, status: true).count
    @learningCount[11] = Online.where(math_ex3s: 3, status: true).count
    @learningCount[12] = Online.where(math_ex4f: 3, status: true).count
    @learningCount[13] = Online.where(math_ex4s: 3, status: true).count
    @allLearningCount = Online.where(status: true).count
  end

  def show
    @online = Online.find(params[:id])
    @studies = Study.where(online_id: @online.id).order(:question_id)

    learning = Array.new(14)
    learning[0] = @online.math_iaf
    learning[1] = @online.math_ias
    learning[2] = @online.math_iibf
    learning[3] = @online.math_iibs
    learning[4]  = @online.math_iiicf
    learning[5] = @online.math_iiics
    learning[6] = @online.math_ex1f
    learning[7] = @online.math_ex1s
    learning[8] = @online.math_ex2f
    learning[9] = @online.math_ex2s
    learning[10] = @online.math_ex3f
    learning[11] = @online.math_ex3s
    learning[12] = @online.math_ex4f
    learning[13] = @online.math_ex4s

    @takingLectures = Hash.new
    for num in 1..14 do
      if (learning[num - 1] == 3)
        @takingLectures.store(Online.courses.keys[num - 1], Subject.find_by(online_id: @online.id, course: num).postphonement)
      end
    end

    # 単元テストスコア
    @scoreArray = Array.new
    @scoreAverage = Array.new
    scoreTotal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    @studies.each do |i|
      if (i.score != nil)
        score = i.score.to_s + " 点"

        if (i.question.title.include?("iaf"))
          num = i.question.title.slice(14, 2).to_i
          if (num == 8)
            @scoreArray[0] = score
            scoreTotal[0] += i.score
            @scoreAverage[0] = (scoreTotal[0]).to_s + " 点"
          elsif (num == 15)
            @scoreArray[1] = score
            scoreTotal[0] += i.score
            @scoreAverage[0] = (scoreTotal[0] / 2).to_s + " 点"
          elsif (num == 22)
            @scoreArray[2] = score
            scoreTotal[0] += i.score
            @scoreAverage[0] = (scoreTotal[0] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("ias"))
          num = i.question.title.slice(14, 2).to_i
          if (num == 8)
            @scoreArray[3] = score
            scoreTotal[1] += i.score
            @scoreAverage[1] = (scoreTotal[1]).to_s + " 点"
          elsif (num == 15)
            @scoreArray[4] = score
            scoreTotal[1] += i.score
            @scoreAverage[1] = (scoreTotal[1] / 2).to_s + " 点"
          elsif (num == 22)
            @scoreArray[5] = score
            scoreTotal[1] += i.score
            @scoreAverage[1] = (scoreTotal[1] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("iibf"))
          num = i.question.title.slice(15, 2).to_i
          if (num == 8)
            @scoreArray[6] = score
            scoreTotal[2] += i.score
            @scoreAverage[2] = (scoreTotal[2]).to_s + " 点"
          elsif (num == 15)
            @scoreArray[7] = score
            scoreTotal[2] += i.score
            @scoreAverage[2] = (scoreTotal[2] / 2).to_s + " 点"
          elsif (num == 22)
            @scoreArray[8] = score
            scoreTotal[2] += i.score
            @scoreAverage[2] = (scoreTotal[2] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("iibs"))
          num = i.question.title.slice(15, 2).to_i
          if (num == 8)
            @scoreArray[9] = score
            scoreTotal[3] += i.score
            @scoreAverage[3] = (scoreTotal[3]).to_s + " 点"
          elsif (num == 15)
            @scoreArray[10] = score
            scoreTotal[3] += i.score
            @scoreAverage[3] = (scoreTotal[3] / 2).to_s + " 点"
          elsif (num == 22)
            @scoreArray[11] = score
            scoreTotal[3] += i.score
            @scoreAverage[3] = (scoreTotal[3] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("iiicf"))
          num = i.question.title.slice(16, 2).to_i
          if (num == 7)
            @scoreArray[12] = score
            scoreTotal[4] += i.score
            @scoreAverage[4] = (scoreTotal[4]).to_s + " 点"
          elsif (num == 13)
            @scoreArray[13] = score
            scoreTotal[4] += i.score
            @scoreAverage[4] = (scoreTotal[4] / 2).to_s + " 点"
          elsif (num == 20)
            @scoreArray[14] = score
            scoreTotal[4] += i.score
            @scoreAverage[4] = (scoreTotal[4] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("iiics"))
          num = i.question.title.slice(16, 2).to_i
          if (num == 7)
            @scoreArray[15] = score
            scoreTotal[5] += i.score
            @scoreAverage[5] = (scoreTotal[5]).to_s + " 点"
          elsif (num == 13)
            @scoreArray[16] = score
            scoreTotal[5] += i.score
            @scoreAverage[5] = (scoreTotal[5] / 2).to_s + " 点"
          elsif (num == 20)
            @scoreArray[17] = score
            scoreTotal[5] += i.score
            @scoreAverage[5] = (scoreTotal[5] / 3).to_s + " 点"
          end
        elsif (i.question.title.include?("ex1s"))
          num = i.question.title.slice(15, 2).to_i
          if (num >= 18)
            @scoreArray[num] = score
            scoreTotal[6] += i.score
            @scoreAverage[6] = (scoreTotal[6] / (num - 17)).to_s + " 点"
          end
        elsif (i.question.title.include?("ex2s"))
          num = i.question.title.slice(15, 2).to_i
          if (num >= 18)
            @scoreArray[num + 5] = score
            scoreTotal[7] += i.score
            @scoreAverage[7] = (scoreTotal[7] / (num - 17)).to_s + " 点"
          end
        elsif (i.question.title.include?("ex3s"))
          num = i.question.title.slice(15, 2).to_i
          if (num >= 18)
            @scoreArray[num + 10] = score
            scoreTotal[8] += i.score
            @scoreAverage[8] = (scoreTotal[8] / (num - 17)).to_s + " 点"
          end
        elsif (i.question.title.include?("ex4s"))
          num = i.question.title.slice(15, 2).to_i
          if (num >= 18)
            @scoreArray[num + 15] = score
            scoreTotal[9] += i.score
            @scoreAverage[9] = (scoreTotal[9] / (num - 17)).to_s + " 点"
          end
        end
      end
    end
  end

  def edit
    @online = Online.find(params[:id])
  end

  def update
    @online = Online.find(params[:id])
    @studies = Study.where(online_id: @online.id)
    if @online.update(online_params)
      redirect_to admin_online_path(@online)
    else
      render "edit"
    end
  end

  private
  def online_params
    params.require(:online).permit(:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :high_school, :junior_high_school, :elementary_school, :grade, :postal_code, :prefecture, :address, :phone, :parent_email, :subject, :status, :note)
  end
end
