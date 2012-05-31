class RealTime < ActiveRecord::Base
  belongs_to :trackeable, :polymorphic => true
  belongs_to :user
end
