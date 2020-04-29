# frozen_string_literal: true

class Labeling < ApplicationRecord
  belongs_to :learning
  belongs_to :label
end
