class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @learnings = Learning.all
  end

  def new
    @learning = Learning.new
  end

  def create
      @learning = Learning.create(learning_params)
    if @learning.save
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
    @learning = Learning.find(params[:id])
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
