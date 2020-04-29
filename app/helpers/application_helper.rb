# frozen_string_literal: true

module ApplicationHelper
  def simple_date(time)
    time.strftime('%y年%m月%d日')
  end
end
