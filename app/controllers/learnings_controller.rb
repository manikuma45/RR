class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy]

  def index
    @learnings = Learning.all
  end

  def new
    @learning = Learning.new
  end

  def create
    learning = Learning.new(learning_params)
    learning.save
    redirect_to learnings_url, notice: "項目「#{learning.title}」を登録しました。"
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_learning
    # @learning = current_user.tasks.find(params[:id])
  end

  def learning_params
    params.require(:learning).permit(:title, { label_ids: [] },
                                     :main_content,
                                     :sub_content,
                                     :url_info,
                                     :image,
                                     :checked_on,
                                     :checked_times)
  end

end
