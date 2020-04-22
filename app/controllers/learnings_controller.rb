class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy, :check_item, :relearn]
  before_action :authenticate_user!

  def index
    if current_user.present?

# @q = Learning.where(checked_times: 0).or(reappearance_date <= Date.today)

# @q = Learning.where(reappearance_date: Time.zone.today.beginning_of_day..Time.zone.today-100.end_of_day).to_sql


@q = current_user.learnings.where(reappearance_date: "1900-01-01".to_date..Time.zone.today).or(current_user.learnings.where(checked_times: 0).ransack(params[:q])

@learnings = @q.result(distinct: true).page(params[:page])

      # @q = current_user.learnings.ransack(params[:q])

      #検索クエリ初回用？
      # @q.build_condition if @q.conditions.empty?

      #ログイン中ユーザーの、チェック回数が０，あるいはreappearance_dateがDate.todayより古いものだけを取り出す
      # @learnings = @q.where(checked_times: 0).or(reappearance_date <= Date.today)

    else
      redirect_to login_url, notice: "Please log in."
    end
  end

  def search
    @q = current_user.learnings.search(search_params)
    @learnings = @q.result(distinct: true).page(params[:page])
  end

  def history
    if current_user.present?
      #履歴なのでログイン中ユーザのすべての学習項目を表示する
      @learnings = current_user.learnings.page(params[:page]).order(created_on: "DESC")
    else
      redirect_to login_url, notice: "Please log in."
    end
  end

  def check_item
    @learning.checked_times += 1
    @learning.checked_on = Date.today
      case @learning.checked_times
        when 1
          @learning.reappearance_date = @learning.created_on + 86400
        when 2
          @learning.reappearance_date = @learning.created_on + 3*86400
        when 3
          @learning.reappearance_date = @learning.created_on + 7*86400
        when 4
          @learning.reappearance_date = @learning.created_on + 14*86400
        else
          @learning.reappearance_date = @learning.created_on + 30*86400
      end
    @learning.save
    redirect_to learnings_path
  end

  def relearn
    @learning.checked_times = 0
    @learning.save
    redirect_to learnings_path, notice: "項目「#{@learning.title}を再学習します。"
  end

  # def revert
  #   @learnings.reappearance_date = Date.today-1
  #   redirect_to learnings_path
  # end

  def new
    @learning = Learning.new
  end

  def create
    @learning = current_user.learnings.create(learning_params)
      if @learning.save!
        redirect_to learnings_url, notice: "項目「#{@learning.title}」を登録しました。"
      else
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
   if @learning.update(learning_params)
     redirect_to learnings_path, notice: "項目「#{@learning.title}」を編集しました"
   else
     render :edit
   end
  end

  def destroy
    binding.irb
    @learning.destroy
    redirect_to learnings_path, notice:"項目を削除しました"
  end

  private

  def set_learning
    # @learning = Learning.find(params[:id])
    @learning = current_user.learnings.find(params[:id])
  end

  def learning_params
    params.require(:learning).permit(:title, { label_ids: [] },
                                     :main_content,
                                     :sub_content,
                                     :url_info,
                                     :image,
                                     :image_cache,
                                     :checked_on,
                                     :reappearance_date,
                                     :checked_times)
  end

  def search_params
    params.require(:q).permit!
  end
end
