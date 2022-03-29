class Message < ApplicationRecord
  validation :text, present: true
end
