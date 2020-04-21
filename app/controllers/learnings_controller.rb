class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy, :check_item, :relearn, :revert]
  before_action :authenticate_user!

  def index
    if current_user.present?

      @q = current_user.learnings.ransack(params[:q])

      #検索クエリ用
      # @q.build_condition if @q.conditions.empty?

      #ラベル検索用？
      # @labels = current_user.labels

      #ログイン中ユーザーの、チェック回数が０，あるいはreappearance_dateがDate.todayより古いものだけを並べる
      @learnings = @q.result(distinct: true).page(params[:page]) unless @q.checked_on == Date.today
# binding.irb
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
      @learnings = current_user.learnings.page(params[:page])
    else
      redirect_to login_url, notice: "Please log in."
    end
  end

  def check_item
# binding.irb
    @learning.checked_times += 1
    # binding.irb
    @learning.checked_on = Date.today
    # binding.irb
      case @learning.checked_times
        # binding.irb
        when 1
          @learning.reappearance_date = @learning.created_on + 86400
          @learning.save
        when 2
          @learning.reappearance_date = @learning.created_on + 3*86400
          @learning.save
          # binding.irb
        when 3
          @learning.reappearance_date = @learning.created_on + 7*86400
          @learning.save
          # binding.irb
        when 4
          @learning.reappearance_date = @learning.created_on + 14*86400
          @learning.save
        else
          @learning.reappearance_date = @learning.created_on + 30*86400
          @learning.save
      end
        #履歴移動は、その日にチェックしたものや翌日以降にチェック待ちのものを履歴ビューでみせればいいか
        #checked_onが今日と＝＝のものをindexの表示項目から除けばいい
        # binding.irb
        redirect_to learnings_path
  end

  def relearn
    @learnings.checked_times = 0
    redirect_to learnings_path, notice: "項目「#{@learnings.title}を再学習します。"
  end

  def revert
    @learnings.reappearance_date = Date.today-1
    redirect_to learnings_path
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
                                     :reappearance_date,
                                     :checked_times)
  end

  def search_params
    params.require(:q).permit!
  end
end
