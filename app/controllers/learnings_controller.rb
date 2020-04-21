class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if current_user.present?
      @q = current_user.learnings.ransack(params[:q])
      @learnings = @q.result(distinct: true).page(params[:page])
    else
      redirect_to login_url, notice: "Please log in."
    end
  end

  def history
    if current_user.present?
      @q = current_user.learnings.ransack(params[:q])
      @learnings = @q.result(distinct: true).page(params[:page])
    else
      redirect_to login_url, notice: "Please log in."
    end
  end

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

  def check_item
    @learnings.checked_times + 1
    @learnings.checked_on = Date.today
      case @learnings.checked_times
        when 1
          @learnings.reappearance_date = @learnings.created_on+1
        when 2
          @learnings.reappearance_date = @learnings.created_on+3
        when 3
          @learnings.reappearance_date = @learnings.created_on+7
        when 4
          @learnings.reappearance_date = @learnings.created_on+14
        else
          @learnings.reappearance_date = @learnings.created_on+30
        end
        #学習項目を履歴ページに移動する？その日にチェックしたものや翌日以降にチェックまちのものを履歴ビューでみせればいいか
        #checked_onが今日と＝＝のものをindexの表示項目から除けばいい
  end

  def relearn
    @learnings.checked_times = 0
    redirect_to learnings_path, notice: "項目「#{@learnings.title}を再学習します。"
  end

  def revert
    @learnings.checked_on = Date.today-1
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
                                     :checked_times)
  end
end
