ActiveAdmin.register PollOption do
  menu :parent => "Polls"
  
  index do
    column :option
    column :poll
    column "Votes" do |option|
      option.votes
    end
    
    default_actions
  end
end
