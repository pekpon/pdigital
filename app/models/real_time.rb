class RealTime < ActiveRecord::Base
  belongs_to :trackeable, :polymorphic => true
end
