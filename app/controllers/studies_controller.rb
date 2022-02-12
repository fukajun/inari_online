class StudiesController < ApplicationController
  before_action :authenticate_online!

  def index
    @studies = Study.where(online_id: current_online.id).order(:question_id)

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

  def show
    @study = Study.find_by(online_id: current_online.id, id: params[:id])
    if @study != nil
      @correction_images = CorrectionImage.where(study_id: @study.id)
    else
      redirect_to studies_path
    end
  end
end
